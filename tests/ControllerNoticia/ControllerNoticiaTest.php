<?php

namespace Tests\ControllerNoticia;

use PHPUnit\Framework\TestCase;
use App\Controllers\Noticias;
use App\Models\NoticiaModel;
use Config\Database;
use Config\Services;
use CodeIgniter\HTTP\RedirectResponse;
use CodeIgniter\Validation\Validation;

class ControllerNoticiaTest extends TestCase
{
    protected $db;

    protected function setUp(): void
    {
        parent::setUp();
        
        // Aislar base de datos manualmente
        $this->db = Database::connect('tests');
        $this->db->transBegin();

        // Simular entorno de Sesión (Usuario logueado con rol de Editor)
        $session = Services::session();
        $session->set([
            'id'         => 15,
            'rol_editor' => 1,
            'logueado'   => true
        ]);

        // Mockear el Validador nativo.
        $mockValidator = $this->createMock(Validation::class);
        $mockValidator->method('withRequest')->willReturn($mockValidator);
        $mockValidator->method('run')->willReturn(true);
        Services::injectMock('validation', $mockValidator);
    }

    protected function tearDown(): void
    {
        // Limpiar Base de Datos (Rollback manual)
        $this->db->transRollback();
        $this->db->close();
        Services::reset();
        parent::tearDown();
    }

    public function testElControladorRechazaNoticiasConTituloPublicadoDuplicado()
    {
        $model = new NoticiaModel();
        
        // --- PASO 1: Insertar la noticia original en la BD ---
        $model->insert([
            'titulo'      => 'Titulo prueba desde controlador',
            'descripcion' => 'Descripción de prueba válida original.',
            'estado'      => 'Publicada',
            'autor_id'    => 15
        ]);

        // --- PASO 2: MOCK DEL REQUEST HTTP ---
        // Como estamos en la consola (CLI), creamos un clon falso de una petición Web
        // y le programamos exactamente qué debe responder cuando el controlador pida los datos.
        $mockRequest = $this->createMock(\CodeIgniter\HTTP\IncomingRequest::class);
        
        // Simulamos la función getPost()
        $mockRequest->method('getPost')->willReturnCallback(function($key) {
            $data = [
                'titulo'        => 'Titulo prueba desde controlador', // TÍTULO DUPLICADO
                'descripcion'   => 'Otra descripción distinta.',
                'accion'        => 'validar'
            ];
            return $data[$key] ?? null;
        });

        // Simulamos la función getFile() para que devuelva nulo (sin imagen)
        $mockRequest->method('getFile')->willReturn(null);

        // --- PASO 3: Inicializar el Controlador con el Request simulado ---
        $response = Services::response();
        $logger   = Services::logger();

        $controlador = new Noticias();
        $controlador->initController($mockRequest, $response, $logger);

        // Llamamos al método guardar() simulando la creación de la noticia
        $resultado = $controlador->guardar();

        // --- PASO 4: Aserciones ---
        
        // Comprobamos que el controlador frene la ejecución y retorne una redirección
        $this->assertInstanceOf(
            RedirectResponse::class, 
            $resultado, 
            'El controlador no detuvo la ejecución ni redirigió al detectar el duplicado.'
        );

        // Comprobamos que en la sesión se haya guardado el array de errores
        $errores = session()->getFlashdata('errors');
        
        $this->assertIsArray($errores, 'La noticia se guardó con éxito en lugar de ser rechazada. No se registró ningún error en la sesión.');
        
        $this->assertArrayHasKey(
            'titulo', 
            $errores, 
            'El controlador no generó el error específico para el campo título.'
        );
        
        $this->assertEquals(
            'Ya existe una noticia publicada con este título.', 
            $errores['titulo'],
            'El mensaje de error no coincide con la regla de negocio esperada.'
        );
    }

    // =========================================================================
    // TEST 2: CONFLICTO DE INTERESES (Seguridad)
    // =========================================================================
    public function testAutorNoPuedeValidarSuPropiaNoticia()
    {
        $model = new NoticiaModel();

        // 1. Insertamos una noticia donde el autor es el Validador (ID 16)
        $idNoticia = $model->insert([
            'titulo'      => 'Noticia del validador',
            'descripcion' => 'Descripción de prueba para verificar el conflicto de intereses.',
            'estado'      => 'Lista para Validación',
            'autor_id'    => 16 // Jael
        ]);

        // 2. Modificamos temporalmente la sesión para ser ese Validador (ID 16)
        $session = Services::session();
        $session->set([
            'id'            => 16, 
            'rol_editor'    => 0,
            'rol_validador' => 1,
            'logueado'      => true
        ]);

        // 3. Mock del Request para simular que presiona el botón "Publicar"
        $mockRequest = $this->createMock(\CodeIgniter\HTTP\IncomingRequest::class);
        $mockRequest->method('getPost')->willReturn('publicar');

        // 4. Ejecutar el Controlador
        $controlador = new Noticias();
        $controlador->initController($mockRequest, Services::response(), Services::logger());
        
        $resultado = $controlador->cambiarEstado($idNoticia);

        // 5. Aserciones
        $this->assertInstanceOf(RedirectResponse::class, $resultado, 'El sistema no bloqueó al usuario.');
        $this->assertEquals(
            'No podés validar tu propia noticia.', 
            session()->getFlashdata('error'),
            'No se mostró el mensaje de error esperado.'
        );
    }

    // =========================================================================
    // TEST 3: CONTROL DE ACCESO (Rutas)
    // =========================================================================
    public function testUsuarioSinRolEditorEsRechazadoAlIntentarCrearNoticia()
    {
        // 1. Modificamos la sesión para ser un usuario sin rol de Editor
        $session = Services::session();
        $session->set([
            'id'            => 16, 
            'rol_editor'    => 0, // No tiene permisos de creación
            'rol_validador' => 1,
            'logueado'      => true
        ]);

        // 2. Inicializar controlador (No necesitamos mockear POST porque 'crear' es por GET)
        $request = Services::request(null, false); 
        $controlador = new Noticias();
        $controlador->initController($request, Services::response(), Services::logger());

        // 3. Ejecutar la vista de creación
        $resultado = $controlador->crear();

        // 4. Aserción: Debe ser expulsado (Redirigido a la lista de noticias)
        $this->assertInstanceOf(
            RedirectResponse::class, 
            $resultado,
            'Una brecha de seguridad permitió a un usuario sin rol de Editor acceder a la vista de creación.'
        );
    }

    // =========================================================================
    // TEST 4: TRANSICIÓN DE ESTADOS (Happy Path)
    // =========================================================================
    public function testEditorPuedeAnularUnaNoticiaEnBorrador()
    {
        $model = new NoticiaModel();

        // 1. Insertamos un Borrador (El autor es el ID 15, que ya está seteado por defecto en nuestro setUp)
        $idNoticia = $model->insert([
            'titulo'      => 'Borrador a anular',
            'descripcion' => 'Este texto no llegará a publicarse nunca.',
            'estado'      => 'Borrador',
            'autor_id'    => 15
        ]);

        // 2. Mock del Request para simular que presiona el botón "Anular"
        $mockRequest = $this->createMock(\CodeIgniter\HTTP\IncomingRequest::class);
        $mockRequest->method('getPost')->willReturn('anular');

        // 3. Ejecutar el Controlador
        $controlador = new Noticias();
        $controlador->initController($mockRequest, Services::response(), Services::logger());
        $controlador->cambiarEstado($idNoticia);

        // 4. Aserción: Comprobamos en la base de datos si el estado cambió de verdad
        $noticiaActualizada = $model->find($idNoticia);
        $this->assertEquals(
            'Anulada', 
            $noticiaActualizada['estado'],
            'El estado de la noticia no se actualizó correctamente a Anulada en la base de datos.'
        );
    }

}