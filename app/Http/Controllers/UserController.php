<?php

namespace App\Http\Controllers;

use App\Models\AuthenticatedUser;
use App\Models\Post;
use App\Policies\PostPolicy;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //

    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the User profile
     *
     * @param  \App\Models\AuthenticatedUser  $authenticatedUser
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //Verify if user is authenticated and if user is owner of post
        $user_id = null;
        if(Auth::check()){
            $user_id = Auth::user()->id;
        }
        else{
            return redirect('/');
        }

        //verifica se é o dono do perfil se sim -> my profile, se nao userprofile
        $posts = Post::where('user_id', $id)->get();
        $nLikes = 0;
        foreach($posts as $post){
            $post->author = AuthenticatedUser::find($post->user_id)->name;
            $post->likes = DB::table("vote_post")->where("post_id",$post->id)->where("like",true)->get()->count();
            $post->thumbnail = "/images/".$post->thumbnail;
            $nLikes += $post->likes;
        }

        $nFollowers = DB::table("follow_user")->where("followed_user", $id)->get()->count();
        $nFollowing = DB::table("follow_user")->where("following_user", $id)->get()->count();

        $user = AuthenticatedUser::find($id);

        $photo = 'images/users/'.Auth::user()->profile_photo;

        if($user_id == $id){
            return view('pages.myprofile', ['user' => 'visitor', 'needsFilter' => 0, 'user_id'=>$user_id, 'photo'=>$photo, 'nFollowers'=>$nFollowers, 'nFollowing'=>$nFollowing, 'nLikes'=>$nLikes, 'user'=>$user, 'posts' => $posts] );
        }
        else {
            return view('pages.userprofile', ['needsFilter' => 0, 'photo'=>$photo, 'nFollowers'=>$nFollowers, 'nFollowing'=>$nFollowing, 'nLikes'=>$nLikes, 'user'=>$user, 'posts' => $posts] );
        }
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\AuthenticatedUser  $authenticatedUser
     * @return \Illuminate\Http\Response
     */
    public function edit(AuthenticatedUser $authenticatedUser)
    {
        //view de settings
        return view('pages.settings', ['needsFilter' => 0] );
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\AuthenticatedUser  $authenticatedUser
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, AuthenticatedUser $authenticatedUser)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\AuthenticatedUser  $authenticatedUser
     * @return \Illuminate\Http\Response
     */
    public function destroy(AuthenticatedUser $authenticatedUser)
    {
        //
    }

    public function roles(Request $request){
        DB::table("authenticated_user")->select("id","username","authenticated_user_type")->get();
    }

    public function editRole(Request $request,$user_id){
        $validatedData = $request->validate([
            'new_role' => 'required'
        ]);
        DB::table("authenticated_user")->where("id",$user_id)->update(["authenticated_user_type" => $validatedData["new_role"]]);
    }
    /**
     * Follow a user
     *
     * @param  \App\Models\AuthenticatedUser  $authenticatedUser
     * @return \Illuminate\Http\Response
     */
    public function follow($id)
    {
        $user = Auth::user();
        if(!Auth::check()) return; //mandar para login ou sem permissoes

        $followed_user = AuthenticatedUser::find($id);
        if($followed_user != null)
            $user->follow_user()->create(['followed_user'=> $id, 'following_user' => $user->id]);
    }


    /**
     * Unfollow a user
     *
     * @param  \App\Models\AuthenticatedUser  $authenticatedUser
     * @return \Illuminate\Http\Response
     */
    public function unfollow($id)
    {
        $user = Auth::user();
        if(!Auth::check()) return; //mandar para login ou sem permissoes

        $followed_user = AuthenticatedUser::find($id);
        if($followed_user != null)
            $user->follow_user()->delete(['followed_user'=> $id, 'following_user' => $user->id]);

    }

    /**
     * Block a user
     *
     * @param  \App\Models\AuthenticatedUser  $authenticatedUser
     * @return \Illuminate\Http\Response
     */
    public function block($id)
    {
        $user = Auth::user();
        if(!Auth::check()) return; //mandar para login ou sem permissoes

        $blocked_user = AuthenticatedUser::find($id);
        if($blocked_user != null)
            $user->block_user()->create(['blocked_user'=> $id, 'blocking_user' => $user->id]);
    }

    /**
     * Unblock a user
     *
     * @param  \App\Models\AuthenticatedUser  $authenticatedUser
     * @return \Illuminate\Http\Response
     */
    public function unblock($id)
    {
        $user = Auth::user();
        if(!Auth::check()) return; //mandar para login ou sem permissoes

        $blocked_user = AuthenticatedUser::find($id);
        if($blocked_user != null)
            $user->block_user()->delete(['blocked_user'=> $id, 'blocking_user' => $user->id]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\AuthenticatedUser  $authenticatedUser
     * @return \Illuminate\Http\Response
     */
    public function update_photo(Request $request, AuthenticatedUser $authenticatedUser)
    {
       // dd($request);

        $user = Auth::check();
        if(!Auth::check()) return;

        //
        $validator = Validator::make($request->all(),
        [
            'avatar' => ['required', 'image', 'mimes:jpeg,jpg,png,gif']
        ],
        [
            'avatar.required' => 'A photo must be uploaded',
            'avatar.image' => 'A photo must be a jpeg,jpg,png,gif image'
        ]);
        if ($validator->fails()) {
            return redirect(url()->previous())->withErrors($validator)->withInput();
        }

        // function assumes that the image is valid and verification was done before
        $date = date('Y-m-d H:i:s');
        $imageSalt = random_bytes(5);
        $imageName = hash("sha256", $request->file('avatar')->getFilename() . $date . $authenticatedUser->id . $imageSalt) . "." . $request->file('avatar')->getClientOriginalExtension();

        if($authenticatedUser->profile_photo != null && $authenticatedUser->profile_photo != 'abs.jpeg'){
            unlink(public_path('images/users/'.$authenticatedUser->profile_photo));
        } //TODO: TEST SEM O FILE ABS.JPEG


//        dd($request);

        $request->avatar->move(public_path('images/users'), $imageName);
      //  $request->profile_photo->move($request->avatar, public_path('images/users').$imageName);

        AuthenticatedUser::where('id', $authenticatedUser->id)->update(['profile_photo'=>$imageName]);
        $authenticatedUser->profile_photo = $imageName;

        //return $authenticatedUser->profile_photo;
        return view('partials.profilephoto', ['photo'=>$imageName]);
    }



    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\AuthenticatedUser  $authenticatedUser
     * @return \Illuminate\Http\Response
     */
    public function edit_bio(Request $request, AuthenticatedUser $authenticatedUser)
    {
        $user = Auth::check();
        if(!Auth::check()) return;

        //
        $validator = Validator::make($request->all(),
        [
            'bio-content' => ['required', 'string', 'max:120']
        ],
        [
            'bio-content.required' => 'The bio must be present',
            'bio-content.string' => 'The bio must be a string',
            'bio-content.max' => 'The bio must have 120 characters at max'

        ]);
        if ($validator->fails()) {
            return redirect(url()->previous())->withErrors($validator)->withInput();
        }

      //  dd($request);

        AuthenticatedUser::where('id', $authenticatedUser->id)->update(['bio'=>$request->input('bio-content')]);

        //return $authenticatedUser->profile_photo;
        return view('partials.profilebio', ['user'=>$authenticatedUser]);
    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\AuthenticatedUser  $authenticatedUser
     * @return \Illuminate\Http\Response
     */
    public function edit_account(Request $request, AuthenticatedUser $authenticatedUser)
    {
        $user = Auth::check();
        if(!Auth::check()) return;

        //
        $data = Validator::make($request->all(),
        [
            "name" => ["string", "max:50"],
            "username" => ["string", "max:50", "unique:authenticated_user"],
            "email" => ["string", "email", "max:50"],
        ]);

        if($data->fails()){
            return; //redirect
        }

        $user->name = $data['name'];
        $user->username = $data['username'];
        $user->email = $data['email'];
        $user->save();



    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\AuthenticatedUser  $authenticatedUser
     * @return \Illuminate\Http\Response
     */
    public function edit_social_networks(Request $request, AuthenticatedUser $authenticatedUser)
    {
        $user = Auth::check();
        if(!Auth::check()) return;

        //
        $data = Validator::make($request->all(),
        [
            "twitter" => ["string", "max:50"],
            "facebook" => ["string", "max:50"],
            "instagram" => ["string", "max:50"],
            "linkedin" => ["string", "max:50"]
        ]);

        if($data->fails()){
            return; //redirect
        }

        $user->twitter = $data['twitter'];
        $user->facebook = $data['facebook'];
        $user->instagram = $data['instagram'];
        $user->linkedin = $data['linkedin'];
        $user->save();
    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\AuthenticatedUser  $authenticatedUser
     * @return \Illuminate\Http\Response
     */
    public function edit_preferences(Request $request, AuthenticatedUser $authenticatedUser)
    {
        $user = Auth::check();
        if(!Auth::check()) return;

        //
        $data = Validator::make($request->all(),
        [
            "show_people_i_follow" => ["boolean"],
            "show_tags_i_follow" => ["string", "max:50"]
        ]);

        if($data->fails()){
            return; //redirect
        }

        $user->show_people_i_follow = $data['show_people_i_follow'];
        $user->show_tags_i_follow = $data['show_tags_i_follow'];
        $user->save();

    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\AuthenticatedUser  $authenticatedUser
     * @return \Illuminate\Http\Response
     */
    public function change_password(Request $request, AuthenticatedUser $authenticatedUser)
    {
        $user = Auth::check();
        if(!Auth::check()) return;

        //
        $data = Validator::make($request->all(),
        [
            'password' => 'required|string|min:6|confirmed',
            'new_password' => 'required|string|min:6|confirmed',
            'confirmation_password' => 'required|string|min:6|confirmed',
        ]);

        if($data->fails()){
            return; //redirect
        }

        if (Hash::check($data['confirmation_password'], Hash::make($data['new_password'])) === false) {
            return;
        } else if (!Hash::check($data['password'], $user->password)) {
            return response()->json(array(
                'success' => false,
                'errors' => array('password' => array('The password is incorrect.'))
            ), 300);
        }



        //inserir password
        $user->save();
    }




}
