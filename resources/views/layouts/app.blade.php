<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
    @include('layouts.head')
</head>
<body class="d-flex flex-column min-vh-100">
<header>
    @include('layouts.navbar')
</header>
@yield('content')
@include('layouts.footer')
@include('layouts.navbar_mobile')
</body>
</html>
