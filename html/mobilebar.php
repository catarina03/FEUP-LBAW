<?php
    function draw_mobilebar() {
?>

<footer class="bottomNavbar d-lg-none">
        <div id="buttonGroup" class="btn-group selectors" role="group" aria-label="Basic example">
            <button id="home" type="button" class="btn button-active">
                <div class="selector-holder">
                    <i class="bi bi-house fs-2"></i>
                    <p>Home</p>
                </div>
            </button>
            <button id="feed" type="button" class="btn button-inactive">
                <div class="selector-holder">
                    <i class="bi bi-plus fs-2"></i>
                    <p>Create</p>
                </div>
            </button>
            <button id="create" type="button" class="btn button-inactive">
                <div class="selector-holder">
                    <i class="bi bi-bell fs-2"></i>
                    <p>Notifications</p>
                </div>
            </button>
            <button id="account" type="button" class="btn button-inactive">
                <div class="selector-holder">
                    <i class="bi bi-person-circle fs-2"></i>
                    <p>@ana_sousa</p>
                </div>
            </button>
        </div>
    </footer>

<?php
    }
    ?>