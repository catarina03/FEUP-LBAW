<script type="text/javascript" src="{{ URL::asset('js/utils.js') }}" defer></script>
<script type="text/javascript" src="{{ URL::asset('js/filterBox.js') }}" defer></script>
<div class="custom-filterBox filterbox col-xl-lg-1 col-md-3 px-auto  d-lg-flex d-none justify-content-center" style="margin-top: 6em;">
    <div class="container  col-md-3">
        <h4 class="text-center"> Search </h4>
        <form class="pt-2" action="" method="get">
            <div class="input-group rounded">
                <input type="text" id="search" class="form-control" placeholder="Search" aria-label="Search"
                       aria-describedby="search-addon"/>
                <span class="input-group-text border-0" id="search-addon" style="background-color:#fcf3ee;">
                            <i title="Search" class="fas fa-search"></i>
                        </span>
            </div>
            <select class="form-select mt-4" id="category" aria-label="Select a category" style="cursor:pointer;">
                <option value="" selected>Select a category</option>
                <option value="Music">Music</option>
                <option value="Cinema">Cinema</option>
                <option value="TvShow">TV Show</option>
                <option value="Theatre">Theatre</option>
                <option value="Literature">Literature</option>
            </select>
            <select class="form-select mt-4" id="type" aria-label="Select a type" style="cursor:pointer;">
                <option selected value="">Select a type</option>
                <option value="News">News</option>
                <option value="Article">Article</option>
                <option value="Review">Review</option>
            </select>
            <input type="date" class="form-control mt-4" id="startDate2" style="cursor:pointer;">
            <p class="text-center mt-1 mb-1">to</p>
            <input type="date" class="form-control mt-0" id="endDate2" style="cursor:pointer;">
            @auth
                <div class="form-check mt-4">
                    <input class="form-check-input" type="checkbox" value="" id="checkPeople"
                           style="cursor:pointer;">
                    <label class="form-check-label" style="margin-left: 10px;" for="checkPeople">
                        Only people I follow
                    </label>
                </div>
                <div class="form-check mt-4">
                    <input class="form-check-input" type="checkbox" value="" id="checkTags" style="cursor:pointer;">
                    <label class="form-check-label" style="margin-left: 10px;" for="checkTags">
                        Only tags I follow
                    </label>
                </div>
                <div class="form-check mt-4">
                    <input class="form-check-input" type="checkbox" value="" id="checkMyPosts" style="cursor:pointer;">
                    <label class="form-check-label" style="margin-left: 10px;" for="checkMyPosts">
                        Only my posts
                    </label>
                </div>
            @endauth
            <button type="submit" class="filterButton w-100 mt-4 p-1">
                <i title="Search" class="fa fa-circle-notch fa-spin d-none search-spinner"></i>
                <span class="search-span d-inline-block">Search</span>
            </button>
            <div class="justify-content-center d-flex mt-1">
                <span class="text-center error-span" style="color:#cc3300; font-size:10px"></span>
            </div>

        </form>
    </div>
    <div>
        <div class ="d-none go-top-scroll" style="position: fixed">
            <button class="d-flex btn mx-auto p-0 btn-lg" style="float:right;outline:none; box-shadow: none;" id="advanced-search-go-top"><i title="Arrow up"
                    class="fas fa-arrow-circle-up m-0 p-0 fa-lg"></i></button>
        </div>
    </div>
</div>
