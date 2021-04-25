@extends('layouts.app')

@section('title', $card->name)

@section('content')
  @include('pages.resources.views.partials.card-test', ['card' => $card])
@endsection
