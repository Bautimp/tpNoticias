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

    public function testAutorNoPuedeValidarSuPropiaNoticia(){
        $model = new NoticiaModel();

        // Insertamos una noticia donde el autor es el Validador (ID 16)
        $idNoticia = $model->insert([
            'titulo'      => 'Noticia del validador',
            'descripcion' => 'Descripción de prueba para verificar el conflicto de intereses.',
            'estado'      => 'Lista para Validación',
            'autor_id'    => 16 // Jael
        ]);

        // Modificamos temporalmente la sesión para ser ese Validador (ID 16)
        $session = Services::session();
        $session->set([
            'id'            => 16, 
            'rol_editor'    => 0,
            'rol_validador' => 1,
            'logueado'      => true
        ]);

        // Mock del Request para simular que presiona el botón "Publicar"
        $mockRequest = $this->createMock(\CodeIgniter\HTTP\IncomingRequest::class);
        $mockRequest->method('getPost')->willReturn('publicar');

        // Ejecutar el Controlador
        $controlador = new Noticias();
        $controlador->initController($mockRequest, Services::response(), Services::logger());
        
        $resultado = $controlador->cambiarEstado($idNoticia);

        // Aserciones
        $this->assertInstanceOf(RedirectResponse::class, $resultado, 'El sistema no bloqueó al usuario.');
        $this->assertEquals(
            'No podés validar tu propia noticia.', 
            session()->getFlashdata('error'),
            'No se mostró el mensaje de error esperado.'
        );
    }

    public function testUsuarioSinRolEditorEsRechazadoAlIntentarCrearNoticia(){
        // Modificamos la sesión para ser un usuario sin rol de Editor
        $session = Services::session();
        $session->set([
            'id'            => 16, 
            'rol_editor'    => 0, // No tiene permisos de creación
            'rol_validador' => 1,
            'logueado'      => true
        ]);

        // Inicializar controlador (No necesitamos mockear POST porque 'crear' es por GET)
        $request = Services::request(null, false); 
        $controlador = new Noticias();
        $controlador->initController($request, Services::response(), Services::logger());

        // Ejecutar la vista de creación
        $resultado = $controlador->crear();

        // Aserción: Debe ser expulsado (Redirigido a la lista de noticias)
        $this->assertInstanceOf(
            RedirectResponse::class, 
            $resultado,
            'Una brecha de seguridad permitió a un usuario sin rol de Editor acceder a la vista de creación.'
        );
    }

    public function testEditorPuedeAnularUnaNoticiaEnBorrador(){
        $model = new NoticiaModel();

        // Insertamos un Borrador (El autor es el ID 15, que ya está seteado por defecto en nuestro setUp)
        $idNoticia = $model->insert([
            'titulo'      => 'Borrador a anular',
            'descripcion' => 'Este texto no llegará a publicarse nunca.',
            'estado'      => 'Borrador',
            'autor_id'    => 15
        ]);

        // Mock del Request para simular que presiona el botón "Anular"
        $mockRequest = $this->createMock(\CodeIgniter\HTTP\IncomingRequest::class);
        $mockRequest->method('getPost')->willReturn('anular');

        // Ejecutar el Controlador
        $controlador = new Noticias();
        $controlador->initController($mockRequest, Services::response(), Services::logger());
        $controlador->cambiarEstado($idNoticia);

        // Aserción: Comprobamos en la base de datos si el estado cambió de verdad
        $noticiaActualizada = $model->find($idNoticia);
        $this->assertEquals(
            'Anulada', 
            $noticiaActualizada['estado'],
            'El estado de la noticia no se actualizó correctamente a Anulada en la base de datos.'
        );
    }

}