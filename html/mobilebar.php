<?php
    function draw_mobilebar() {
?>

<footer class="bottomNavbar d-lg-none">
    <div id="buttonGroup" class="btn-group selectors" role="group" aria-label="Basic example">
        <a id="home" type="button" class="btn button-active" href="homepage.php">
            <div class="selector-holder">
                <i class="bi bi-house fs-2"></i>
                <p>Home</p>
            </div>
        </a>
        <a id="feed" type="button" class="btn button-inactive" href="createpost.php">
            <div class="selector-holder">
                <i class="bi bi-plus fs-2"></i>
                <p>Create</p>
            </div>
        </a>
        <a id="create" type="button" class="btn button-inactive">
            <div class="selector-holder">
                <i class="bi bi-bell fs-2"></i>
                <p>Notifications</p>
            </div>
        </a>
        <a id="account" type="button" class="btn button-inactive" href="myprofile.php">
            <div class="selector-holder">
                <i class="bi bi-person-circle fs-2"></i>
                <p>@ana_sousa</p>
            </div>
        </a>
    </div>
</footer>

<?php
    }
    ?>