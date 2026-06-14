<?php

namespace Tests\Models;

use PHPUnit\Framework\TestCase;
use App\Models\NoticiaModel;
use App\Controllers\Noticias;
use Config\Database;
use Config\Services;

class NoticiaModelTest extends TestCase
{
    protected $db;
    protected $session;

    protected function setUp(): void
    {
        parent::setUp();
        
        // 1. Aislar base de datos manualmente
        $this->db = Database::connect('tests');
        $this->db->transBegin();

        // 2. Iniciar el servicio de sesión
        $this->session = Services::session();
    }

    protected function tearDown(): void
    {
        // 3. Destruir entorno y revertir la base de datos
        $this->db->transRollback();
        $this->db->close();
        
        $_POST = [];
        Services::reset();
        
        parent::tearDown();
    }

    public function testValidadorNoPuedePublicarNoticiaConTituloDuplicado()
    {
        $model = new NoticiaModel();

        // ==========================================================
        // PREPARACIÓN (Arrange): Insertamos los datos directo con el Modelo
        // ==========================================================
        
        // Creamos la noticia original ya Publicada
        $idNoticia1 = $model->insert([
            'titulo'      => 'Titulo duplicado de prueba',
            'descripcion' => 'Descripción genérica válida de más de 50 caracteres para la primera noticia.',
            'estado'      => 'Publicada',
            'autor_id'    => 15
        ]);

        // Creamos la segunda noticia esperando a ser validada
        $idNoticia2 = $model->insert([
            'titulo'      => 'Titulo duplicado de prueba', // MISMO TÍTULO
            'descripcion' => 'Otra descripción genérica para la segunda noticia.',
            'estado'      => 'Lista para Validación',
            'autor_id'    => 15
        ]);

        // Verificamos que la preparación no haya fallado
        $this->assertIsNumeric($idNoticia1, 'Error: No se pudo crear la noticia 1');
        $this->assertIsNumeric($idNoticia2, 'Error: No se pudo crear la noticia 2');

        // ==========================================================
        // ACCIÓN (Act): Simulamos al Validador usando el Controlador
        // ==========================================================
        
        // Configuramos la sesión para ser el Validador (ID 16)
        $this->session->set([
            'id' => 16, 
            'rol_editor' => 0,
            'rol_validador' => 1,
            'logueado' => true
        ]);

        // Inicializamos el Controlador
        $request = Services::request(null, false);
        $response = Services::response();
        $logger = Services::logger();

        $controlador = new Noticias();
        $controlador->initController($request, $response, $logger);

        // El Validador intenta publicar la Segunda Noticia
        $_POST['accion'] = 'publicar';
        $controlador->cambiarEstado($idNoticia2);

        // ==========================================================
        // COMPROBACIÓN (Assert): Verificamos qué pasó en la BD
        // ==========================================================
        
        $noticiaActualizada2 = $model->find($idNoticia2);

        // 1. El estado NO debe ser 'Publicada'
        $this->assertNotEquals(
            'Publicada', 
            $noticiaActualizada2['estado'], 
            'Falla Crítica: El controlador permitió publicar una noticia con un título que ya estaba publicado.'
        );

    }

    public function testValidadorNoPuedePublicarNoticiaConTituloDuplicadoRetornaMismoEstado()
    {
        $model = new NoticiaModel();

        // ==========================================================
        // PREPARACIÓN (Arrange): Insertamos los datos directo con el Modelo
        // ==========================================================
        
        // Creamos la noticia original ya Publicada
        $idNoticia1 = $model->insert([
            'titulo'      => 'Titulo duplicado de prueba',
            'descripcion' => 'Descripción genérica válida de más de 50 caracteres para la primera noticia.',
            'estado'      => 'Publicada',
            'autor_id'    => 15
        ]);

        // Creamos la segunda noticia esperando a ser validada
        $idNoticia2 = $model->insert([
            'titulo'      => 'Titulo duplicado de prueba', // MISMO TÍTULO
            'descripcion' => 'Otra descripción genérica para la segunda noticia.',
            'estado'      => 'Lista para Validación',
            'autor_id'    => 15
        ]);

        // Verificamos que la preparación no haya fallado
        $this->assertIsNumeric($idNoticia1, 'Error: No se pudo crear la noticia 1');
        $this->assertIsNumeric($idNoticia2, 'Error: No se pudo crear la noticia 2');

        // ==========================================================
        // ACCIÓN (Act): Simulamos al Validador usando el Controlador
        // ==========================================================
        
        // Configuramos la sesión para ser el Validador (ID 16)
        $this->session->set([
            'id' => 16, 
            'rol_editor' => 0,
            'rol_validador' => 1,
            'logueado' => true
        ]);

        // Inicializamos el Controlador
        $request = Services::request(null, false);
        $response = Services::response();
        $logger = Services::logger();

        $controlador = new Noticias();
        $controlador->initController($request, $response, $logger);

        // El Validador intenta publicar la Segunda Noticia
        $_POST['accion'] = 'publicar';
        $controlador->cambiarEstado($idNoticia2);

        // ==========================================================
        // COMPROBACIÓN (Assert): Verificamos qué pasó en la BD
        // ==========================================================
        
        $noticiaActualizada2 = $model->find($idNoticia2);


        // 2. La noticia debe retener su estado original
        $this->assertEquals(
            'Lista para Validación', 
            $noticiaActualizada2['estado'],
            'La noticia debió retener su estado original al fallar la validación.'
        );
    }
}