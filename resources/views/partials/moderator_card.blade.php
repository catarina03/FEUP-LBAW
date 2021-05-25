<div class="postsCards row justify-content-center">
    @foreach($reports as $report)
        <div class="col-12 col-md-6 col-xl-4 mb-4">
            <div class="card h-100"> {{-- TODO: on click--}}
                <img src="{{ URL::asset('images/posts/'.$report->thumbnail) }}" height="200" class="card-img-top" alt="...">
                <div class="card-body">
                    <h5 class="card-title">{{ $report->title }}</h5>
                    <small> by <a id="authorName" href="{{ url('user/'.$report->user_id) }}">
                            {{$report->name}}</a>,
                        {{date("F j, Y", strtotime($report->created_at))}} </small>

                    <ul class="card-text mt-1 list-unstyled">
                        <li class="pt-1" id="inline-pdash-p"><strong>Author:</strong> {{$report->content_author}} </li>
                        <li class="pt-1" id="inline-pdash-p"><strong>Referenced content:</strong> {{$report->type}}</li>
                        <li class="pt-1" id="inline-pdash-p"><strong>Motive:</strong> {{$report->motive}} </li>
                        <li class="pt-1" id="inline-pdash-p"><strong>Reports:</strong> {{$report->n_reports}} </li>
                    </ul>

                    <div class="text-center">
                        @if($report->user_assigned == null)
                            <p class="assign-button" style="font-weight:bold;" data-bs-toggle="modal"
                               data-bs-target="#confirm">Assign to me</p>

                        @else
                            <p class="assign-button" style="font-weight:bold;" data-bs-toggle="modal"
                               data-bs-target="#confirm">Action</p>
                        @endif
                    </div>
                </div>
            </div>
        </div>
    @endforeach
</div>
{{--<nav class="manage_roles-pagination">
    <div class="pagination">
        {!! $reports->links() !!}
    </div>
</nav>--}}


