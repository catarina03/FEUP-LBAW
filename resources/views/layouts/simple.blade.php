<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
    @include('layouts.head')
</head>
<body class="d-flex flex-column min-vh-100">
@yield('content')
</body>
</html>
