@foreach($comments as $comment)
    @include("partials.single_comment",["comment"=>$comment])
@endforeach