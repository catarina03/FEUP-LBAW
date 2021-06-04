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
@include('auth.login')
@include('auth.register')

@if(!empty(Session::get('showModal')) && Session::get('showModal') == "login")
    <script>
        $(function () {
            $('#loginModal').modal('show');
        });
    </script>
@elseif(!empty(Session::get('showModal')) && Session::get('showModal') == "register")
    <script>
        $(function () {
            $('#registerModal').modal('show');
        });
    </script>
@endif
</body>
</html>
