<div class="reports-table" style="overflow-x: scroll">
    <table class="table mt-4 roles-list align-middle table-hover" style="background-color:#fcf3ee;">
        <thead>
        <tr>
            <th class="p-3 ps-4" scope="col">Post Title</th>
            <th scope="col" class="text-center p-3">Reported Content</th>
            <th scope="col" class="text-center p-3">Author</th>
            <th scope="col" class="text-center p-3">Motive</th>
            <th scope="col" class="text-center p-3">Reports</th>
            <th scope="col" class="text-center p-3 ps-0">Actions</th>
        </tr>
        </thead>
        <tbody class="reports-items">
        @if(count($reports) > 0)
            @include('pages.confirm')
            @include('pages.report_action')
            @foreach($reports as $report)
                <tr class="report-row " style="cursor:pointer;" data-href="'/post/'{{$report->post_id}}">
                    <td class="report-item col-md-5 title ps-4 pt-2 pb-2">{{ $report->title}}</td>
                    <td class="report-item col-md-2 text-center pt-2 pb-2"> {{$report->type}} </td>
                    <td class="report-item text-center pt-2 pb-2"> {{$report->content_author}} </td>
                    <td class="report-item -md-1 text-center pt-2 pb-2"> {{$report->motive}} </td>
                    <td class="report-item text-center pt-2 pb-2"> {{$report->n_reports}} </td>
                    <td class="text-center report-actions-section ps-0 pe-3" data-id="{{$report->content_id}}"
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

