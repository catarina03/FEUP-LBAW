<?php
    function draw_mobilebar($user) {
?>

<footer class="bottomNavbar d-lg-none">
    <div id="buttonGroup" class="btn-group selectors" role="group" aria-label="Mobile bottom navbar">

        <a id="home" type="button" class="btn button-active" href="homepage.php">
            <div class="selector-holder pb-1">
                <i class="bi bi-house fs-1"></i>
            </div>
        </a>
        <?php
        if($user == "moderator" || ($user == "system_manager")){
                ?>
        <a id="dashboard" type="button" class="btn button-inactive" href="dashboard.php">
            <div class="selector-holder">
                <i class="bi bi-list-task fs-1"></i>
            </div>
        </a>
        <?php } 
        if($user == "system_manager") { ?>
        <a id="roles_manager" type="button" class="btn button-inactive" href="role_manager.php">
            <div class="selector-holder">
                <i class="bi bi-people-fill fs-1"></i>
            </div>
        </a>
        <?php } ?>
        <?php if($user != "visitor") { ?>
        <a id="feed" type="button" class="btn button-inactive" href="createpost.php">
            <div class="selector-holder">
                <i class="bi bi-plus-square-dotted fs-1"></i>
            </div>
        </a>
        <a id="create" type="button" class="btn button-inactive">
            <div class="selector-holder">
                <i class="bi bi-bell fs-1"></i>
            </div>
        </a>
        <a id="account" type="button" class="btn button-inactive" href="myprofile.php">
            <div class="selector-holder">
                <i class="bi bi-person-circle fs-1"></i>
            </div>
        </a>
        <?php }
        else {?>
        <a id="login" type="button" class="btn button-inactive">
            <div class="selector-holder p-2" data-bs-toggle="modal" data-bs-target="#login">
                <img src="./images/enter.svg" height="27px">
            </div>
        </a>
        <?php } ?>
    </div>


</footer>

<?php
    }
    ?>