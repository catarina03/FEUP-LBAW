<div class="col-12 mb-4 ">
    <div class="card h-100 m-auto text-center align-items-center justify-content-center " style="min-height: 30vh;">
        @auth
            @if($homepage)
            <h4 class="pt-4"> Unfortunately, no posts were found according to your preferences :(</h4>
            <h6> To see any posts in your homepage you can either <a href="/user/{{$user->id}}/settings#change-password" style="color:black;">change your preferences</a> or <a href="/addpost" style="color:black;">create a new post</a></h6>
            @else
                <h4 class="pt-4"> Unfortunately, no posts were found according to your search :(</h4>
                <h6> To see any posts in your homepage you can either change your search parameters or <a href="/addpost" style="color:black;">create a new post</a></h6>
            @endif
        @endauth
        @guest
            @if($homepage)
                <h4 class="pt-4"> Unfortunately, no posts were found at the moment:(</h4>
                <h6> To see any posts in your homepage you can <a href="/login" style="color:black;">login and create a new post</a></h6>
            @else
                <h4 class="pt-4"> Unfortunately, no posts were found according to your search :(</h4>
                <h6> To see any posts in your homepage you can either change your search parameters or <a href="/login" style="color:black;">login and create a new post</a></h6>
            @endif
        @endguest
    </div>
</div>

