<!-- Scripts del modal Login y Registro -->
<script>
document.addEventListener("DOMContentLoaded", function() {
    let modal = "<?= session()->getFlashdata('modal') ?>";
    if (modal === 'login') {
        document.getElementById("loginFormModal").style.display = "flex";
    }

    if (modal === 'registro') {
        document.getElementById("registroModal").style.display = "flex";
    }

});

function abrirLogin() {
    document.getElementById("loginModal").style.display = "flex";
}

function cerrarLogin() {
    document.getElementById("loginModal").style.display = "none";
}

function abrirLoginForm() {
    cerrarLogin();
    document.getElementById("loginFormModal").style.display = "flex";
}

function cerrarLoginForm() {
    document.getElementById("loginFormModal").style.display = "none";
}

function abrirRegistro() {
    cerrarLogin();
    document.getElementById("registroModal").style.display = "flex";
}

function cerrarRegistro() {
    document.getElementById("registroModal").style.display = "none";
}

//Control de abril modal recuperar contraseña
window.onload = function() {
    <?php if (session()->getFlashdata('recuperar')): ?>
        abrirModalRecuperar();
    <?php endif; ?>
}
//Mensaje de éxito de Crear y Editar noticia
setTimeout(() => {
    const toast = document.querySelector('.toast-success');
    if (toast) {
        toast.style.opacity = '0';
        setTimeout(() => toast.remove(), 300);
    }
}, 3000);

//Scripts de Crear y Editar, la imagen
document.addEventListener("DOMContentLoaded", function () {

    const dropArea = document.getElementById("drop-area");
    const input = document.getElementById("imagen");
    const preview = document.getElementById("previewImagen");

    // Si la página no tiene imagen, no ejecutar
    if (!dropArea || !input || !preview) return;

    // CLICK EN EL ÁREA
    dropArea.addEventListener("click", () => input.click());

    // SELECCIONAR ARCHIVO
    input.addEventListener("change", (e) => {
        mostrarImagen(e.target.files[0]);
    });

    // DRAG OVER
    dropArea.addEventListener("dragover", (e) => {
        e.preventDefault();
        dropArea.classList.add("activo");
    });

    // DRAG LEAVE
    dropArea.addEventListener("dragleave", () => {
        dropArea.classList.remove("activo");
    });

    // DROP
    dropArea.addEventListener("drop", (e) => {
        e.preventDefault();

        dropArea.classList.remove("activo");

        const archivo = e.dataTransfer.files[0];

        input.files = e.dataTransfer.files;

        mostrarImagen(archivo);
    });

    // MOSTRAR PREVIEW
    function mostrarImagen(file) {

        if (!file || !file.type.startsWith("image/")) return;

        // Máximo 2MB
        if (file.size > 2 * 1024 * 1024) {
            alert("La imagen es demasiado grande (máx 2MB)");
            return;
        }

        const reader = new FileReader();

        reader.onload = (e) => {

            preview.src = e.target.result;

            preview.style.display = "block";

            preview.style.opacity = "1";

            // desmarcar quitar imagen
            const check = document.querySelector('input[name="quitar_imagen"]');

            if (check) {
                check.checked = false;
            }
        };

        reader.readAsDataURL(file);
    }

    // CHECKBOX QUITAR IMAGEN
    const checkEliminar = document.querySelector('input[name="quitar_imagen"]');

    if (checkEliminar) {

        checkEliminar.addEventListener("change", function (e) {

            if (e.target.checked) {

                preview.style.opacity = "0.3";

                input.value = '';

            } else {

                preview.style.opacity = "1";
            }
        });
    }

});

</script>
<!--Modal de recuperar-->
<script id="i4f1xr">
function abrirModalRecuperar() {
    document.getElementById('modalRecuperar').style.display = 'flex';
}

function cerrarModalRecuperar() {
    document.getElementById('modalRecuperar').style.display = 'none';
}

</script>  
