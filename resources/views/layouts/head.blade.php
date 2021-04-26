<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- CSRF Token -->
<meta name="csrf-token" content="{{ csrf_token() }}">

<title>{{ config('app.name', 'Laravel') }}</title>

<link rel="preconnect" href="{{ asset('https://fonts.gstatic.com')}}">
<link href="{{ asset('https://fonts.googleapis.com/css2?family=Montserrat&family=Roboto&display=swap')}}" rel="stylesheet">
<script src="{{ asset('https://kit.fontawesome.com/45528450c3.js')}}" crossorigin="anonymous"></script>

<link href="{{ asset('https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css')}}" rel="stylesheet"
    integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

<script src="{{ asset('https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js')}}"
    integrity="sha384-KsvD1yqQ1/1+IA7gi3P0tyJcT3vR+NdBTt13hSJ2lnve8agRGXTTyNaBYmCR/Nwi" crossorigin="anonymous">
</script>
<script src="{{ asset('https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.min.js')}}"
    integrity="sha384-nsg8ua9HAw1y0W1btsyWgBklPnCUAFLuTMS2G72MMONqmOymq585AcH49TLBQObG" crossorigin="anonymous">
</script>
<link rel="stylesheet" href="{{ asset('https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css')}}">

<script src="{{ asset('js/script.js')}}" defer></script>
<link href="{{ asset('css/style.css') }}" rel="stylesheet">