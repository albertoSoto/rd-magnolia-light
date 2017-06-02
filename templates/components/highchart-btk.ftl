[#include "../macro/btk-util.ftl"]
[#assign iteration = rand(0,5000)?string["0"]]
<div class="highchart-btk" id="hchart${iteration!}">
[#if content.title?has_content]
    <h2>${content.title!}</h2>
[/#if]
</div>
<script type="text/javascript">
    window.deferAfterjQueryLoaded.push(function () {

    [#-- theme loading
        jQuery.getScript("${ctx.contextPath}/.resources/backoffice-light-module/bower_components/highcharts/themes/dark-green.js"
                , function (data, textStatus, jqxhr) {
                    console.log("Load theme was performed.");
    --]
        var currentSeries${iteration!} = [];
    [#list cmsfn.children(content) as series]
        var item = {name: "${series.name!""}", data: []};
        [#list cmsfn.children(series) as value]
            item.data.push(${value.value!""});
        [/#list]
        currentSeries${iteration!}.push(item);
    [/#list]

        $('#hchart${iteration!}').highcharts({
            chart: {
                type:'${content.chartType!"column"}',
                style: {
                    fontFamily: 'Open Sans'
                }
            },
            title: {
                text: '${content.title!}',
                x: -20 //center
            },
            subtitle: {
                text: '${content.subtitle!}',
                x: -20
            },
            yAxis: {
                title: {
                    text: '${content.labelAxisY!}'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                valueSuffix: ''
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0
            },
            series: currentSeries${iteration!}
        });
        //}); [#-- theme loading --]
    });
</script>
