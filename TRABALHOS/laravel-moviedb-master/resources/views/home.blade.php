@extends('layouts.app')

@section('content')
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-7" style="margin-top: 2%">
                <div class="box">
                    <h3 class="box-title" style="padding: 2%">Gráfico teste</h3>
                    <div class="box-body">
                        <div id="container" style="width:100%; height:400px;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('scripts')
<!-- Custom Scripts -->
<script type="text/javascript">
    usersCount = @json($users);
    document.addEventListener('DOMContentLoaded', function () {
        const chart = Highcharts.chart('container', {
            chart: {
                type: 'bar'
            },
            title: {
                text: 'Usuários cadastrados no Movie Database por ano'
            },
            xAxis: {
                categories: ['2020']
            },
            yAxis: {
                title: {
                    text: 'Quantidade de usuários'
                }
            },
            series: [{
                data: [usersCount]
            }]
        });
    });
</script>
@endpush
