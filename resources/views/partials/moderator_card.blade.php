<div class="postsCards row justify-content-center">
    @include('pages.confirm')
    @foreach($reports as $report)
        <div class="col-12 col-md-6 col-xl-4 mb-4 report-section" data-id="{{$report->content_id}}" data-type="{{$report->type}}">
            <div class="card h-100"> {{-- TODO: on click--}}
                <img src="{{ URL::asset($report->thumbnail) }}" height="200" class="card-img-top" alt="...">
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

                    @include('partials.moderator_card_actions', ['assigned' => !($report->user_assigned==null), 'type' => $report->type, 'content_id'=>$report->content_id])
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


