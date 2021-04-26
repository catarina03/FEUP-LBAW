<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
  <head>
   @include('layouts.head')
  </head>
  <body class="d-flex flex-column min-vh-100">
    <main>
      <header>
        @include('layouts.navbar')
      </header>
    @yield('content')
    </main>
    @include('layouts.mobilebar')
  </body>
</html>
