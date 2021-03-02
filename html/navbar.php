<?php 
    function draw_nav_bar(){
?>
<nav class="navbar navbar-custom navbar-expand-lg navbar-dark bg-dark ">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Logo</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item pg-2">
          <a class="nav-link" href="#">Music</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Cinema</a>
        </li> 
        <li class="nav-item">
          <a class="nav-link" href="#">TV Show</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Theatre</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Literature</a>
        </li>
        <li class="nav-item">
        <img src="https://demos.creative-tim.com/argon-dashboard-pro/assets/img/theme/team-4.jpg" alt="Avatar" class="avatar">
        </li>
      </ul>
    </div>
  </div>
</nav>
<?php
}
?>