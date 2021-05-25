@foreach($comments as $comment)
    @include("partials.single_comment",["comment"=>$comment,"user_id" => $user_id])
@endforeach