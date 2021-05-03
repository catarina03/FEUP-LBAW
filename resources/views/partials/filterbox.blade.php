@section('filter-box')
<div class="custom-filterBox col-md-3 d-lg-block d-none text-center">
    <div class="container">
        <h4> Search </h4>
        <form class="pt-2" action="advanced_search.php" method="post">
            <div class="input-group rounded">
                <input type="search" class="form-control" placeholder="Search" aria-label="Search"
                       aria-describedby="search-addon" />
                <span class="input-group-text border-0" id="search-addon" style="background-color:#fcf3ee;">
                            <i class="fas fa-search"></i>
                        </span>
            </div>
            <select class="form-select mt-4" aria-label="Select a type" style="cursor:pointer;">
                <option selected>Select a type</option>
                <option value="1">News</option>
                <option value="2">Article</option>
                <option value="3">Review</option>
                <option value="4">Suggestion</option>
            </select>
            <input type="date" class="form-control mt-4" id="startDate" aria-label="Start Date"
                   style="cursor:pointer;">
            <a> to </a>
            <input type="date" class="form-control mt-2" id="endDate" aria-label="End Date"
                   style="cursor:pointer;">

            <div class="form-check mt-4">
                <input class="form-check-input" type="checkbox" value="" id="checkPeople"
                       style="cursor:pointer;">
                <label class="form-check-label" for="checkPeople">
                    Only people I follow
                </label>
            </div>
            <div class="form-check mt-4">
                <input class="form-check-input" type="checkbox" value="" id="checkTags" style="cursor:pointer;">
                <label class="form-check-label" for="checkTags">
                    Only tags I follow
                </label>
            </div>

            <input type="submit" class="filterButton w-100 mt-4 p-1" value="Filter">
        </form>
    </div>
</div>
@show
