<?= $this->extend('Noticias/layout') ?>

<?= $this->section('contenido') ?>

<?php /** @var array $noticia */ ?>

<div class="crear-container">

    <div class="crear-card">

        <h3 class="crear-titulo">
            Editar Noticia
        </h3>
         
             <?php
            $color = "#eee";

            switch ($noticia['estado']) {
                case 'Borrador': $color = "#fff3cd"; break;
                case 'Lista para Validación': $color = "#dbeafe"; break;
                case 'Para Corrección': $color = "#f8d7da"; break;
            }
        ?>

        <div class="estado-contenedor">
            <span class="estado" style="background:<?= $color ?>">
                <?= $noticia['estado'] ?>
            </span>
        </div>
        <form method="post" action="/app_tp1/public/noticias/guardar/<?= $noticia['id'] ?>" enctype="multipart/form-data">

            
            <label><b>Título:</b></label><br>
            <input type="text" name="titulo" value="<?= $noticia['titulo'] ?>"class="input">

            <label><b>Descripción:</b></label><br>
            <textarea name="descripcion" class="input"><?= $noticia['descripcion'] ?></textarea>

           <label><b>Imagen</b></label>

            <div class="bloque-imagen">

                <div id="drop-area">
                    <p>Arrastrá una imagen acá o hacé click</p>

                    <input type="file"
                        id="imagen"
                        name="imagen"
                        accept="image/*"
                        hidden>
                </div>

                <div class="preview-container">

                    <?php if (!empty($noticia['imagen'])): ?>

                        <img id="previewImagen"
                            src="<?= base_url('uploads/' . $noticia['imagen']) ?>">

                    <?php else: ?>

                        <img id="previewImagen" style="display:none;">

                    <?php endif; ?>

                </div>

                <label class="checkbox-editar">
                    <input type="checkbox" name="quitar_imagen">
                    Quitar imagen
                </label>

            </div>
           
            <div class="acciones">

                <a href="<?= base_url('noticias') ?>" class="detalle-volver">
                    <img src="<?= base_url('img/flecha-volver.png') ?>" width="16" style="vertical-align:middle;">
                    Volver
                </a>

                 <div class="botones">
                    <button class="btn btn-guardar" type="submit" name="accion" value="guardar">
                    Guardar cambios
                    </button>

                    <button class="btn btn-validar" type="submit" name="accion" value="validar">
                    Enviar a validación
                    </button>

                    <a href="<?= base_url('noticias/mis') ?>" class="btn btn-gris" style="text-decoration: none;">
                        Cancelar
                    </a>
                </div>

            </div>

        </form>

    </div>

</div>

<?= $this->endSection() ?>