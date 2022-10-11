<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <style>
        body {
            font-family:'Dejavu Sans', Arial, Helvetica, sans-serif;
            font-size: 11px;
        }
    </style>
</head>
<body>

@if ($logo)
    <center>
        <img src="{{ $logo }}">
        <p>{{$company_name}}</p>
    </center>
@endif
<br>

<p>
    {{ trans('general.date') }}: {{ date($date_settings) }} <br>
    {{ trans('general.consumable') }}: {{ $item_model }}<br>
</p>

@if ($eula)
    <hr>
    {!!  $eula !!}
    <hr>
@endif


<p>
    Assigned on: {{$check_out_date}}<br>
    Assigned to: {{$assigned_to}}<br>
    Accepted on: {{$accepted_date}}
</p>


@if ($signature!='')
    <img src="{{ $signature }}" style="max-width: 600px; border-bottom: black solid 1px;">
@endif
</body>
</html>
