<select class="form-select report_content_select" aria-label="Select a motive" style="width: 80%">
    <option selected disabled>Select a motive</option>
    @foreach($motives as $motive)
        <option value="{{$motive->motive}}">{{$motive->motive}}</option>
    @endforeach
</select>
