
@php $toasters = session()->pull('toaster', []) @endphp
@foreach ($toasters as $toaster)
    @include('partials.template_toaster', ['text' => $toaster])
@endforeach
@php session()->forget('toaster') @endphp
