<div class="reports-table" style="overflow-x: scroll">
    <table class="table mt-4 roles-list align-middle">
        <thead>
        <tr>
            <th scope="col">Post Title</th>
            <th scope="col" class="text-center ">Reported Content</th>
            <th scope="col" class="text-center ">Author</th>
            <th scope="col" class="text-center ">Motive</th>
            <th scope="col" class="text-center ">Reports</th>
            <th scope="col" class="text-center ">Actions</th>
        </tr>
        </thead>
        <tbody class="reports-items">
        @if(count($reports) > 0)
            @include('pages.confirm')
            @include('pages.report_action')
            @foreach($reports as $report)
                <tr class="report-row">
                    <td class="col-md-4 title"><a href="{{ url('/post/'.$report->post_id) }}">{{ $report->title}}</a>
                    </td>
                    <td class="col-md-2 text-center"> {{$report->type}} </td>
                    <td class="text-center"> {{$report->content_author}} </td>
                    <td class="col-md-1 text-center"> {{$report->motive}} </td>
                    <td class="text-center"> {{$report->n_reports}} </td>
                    <td class="text-center report-actions-section" data-id="{{$report->content_id}}"
                        data-type="{{$report->type}}">
                        @include('partials.moderator_card_actions', ['assigned' => !($report->user_assigned==null)])

                    </td>
                </tr>
            @endforeach
        @else
            <tr>
                <td>No results found!</td>
            </tr>
        @endif
        </tbody>

    </table>
</div>
<nav class="table-pagination">
    <div class="pagination">
        {{--        {!! $roles->links() !!}--}}
    </div>
</nav>

