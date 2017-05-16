[#include "../macro/btk-util.ftl"]
[#assign iteration = rand(0,5000)?string["0"]]
<div id="fcalendar${iteration!}" class="fullcalendar-btk">
[#if content.title?has_content]
    <h2>${content.title!}</h2>
[/#if]
    <div id="calendar${iteration!}"></div>
</div>
<script type="text/javascript">
    window.deferAfterjQueryLoaded.push(function () {
        var currentSeries${iteration!} = [];
    [#if content.eventsData?? && !content.enableGoogle!false && content.enableAjax!false]
        [#list cmsfn.children(content.eventsData) as series]
            [#if series.start??]
                var item = {title: "${series.name!""}"};
                [#assign startTime = series.start?string["yyyy-MM-dd"]!""]
                [#if series.time??]
                    [#assign startTime = startTime + " "+series.time]
                item.time = "${series.time!""}";
                [/#if]
                item.start = "${startTime}";
                [#if series.end??][#--item.url= 'http://google.com/';--]
                item.end = "${series.end?string["yyyy-MM-dd"]!""}";
                [/#if]
                currentSeries${iteration!}.push(item);
            [/#if]
        [/#list]
    [/#if]
    [#assign showNavigation = true]
    [#if content.calendarOptions?seq_index_of("navigation")<0][#assign showNavigation = false][/#if]
    [#assign views = '']
    [#if content.calendarOptions?seq_index_of("month")!=-1][#assign views = 'month'][/#if]
    [#if content.calendarOptions?seq_index_of("week")!=-1][#assign views = views+',basicWeek'][/#if]
    [#if content.calendarOptions?seq_index_of("day")!=-1][#assign views = views+',basicDay'][/#if]
    [#if content.enableGoogle!false]
    jQuery.getScript("${ctx.contextPath}/.resources/backoffice-light-module/bower_components/fullcalendar/dist/gcal.min.js"
            , function (data, textStatus, jqxhr) {
    [/#if]
        jQuery('#calendar${iteration!}').fullCalendar({
            firstDay: 1,
            header: {
                [#if showNavigation]left: 'prev,next today',center: 'title',[/#if]
                right: '${views!""}'[#--month,basicWeek,basicDay--]
            },
        [#if content.enableGoogle!false && content.googleApiKey?? && content.googleCalendarID??]
            googleCalendarApiKey: '${content.googleApiKey!""}',
            events: {
                googleCalendarId: '${content.googleCalendarID!""}',
                className: '${content.googleItemsClass!""}'
            },
        [#elseif content.enableAjax!false]
            eventSources: [
            [#list cmsfn.children(content.ajaxCollections) as data]
            {url:"${data.url!}"[#if data_has_next],[/#if]}
            [/#list]
            ],
        [#else]
            events: currentSeries${iteration!},
        [/#if]
            timeFormat: 'H(:mm)'
        });
    [#if content.enableGoogle!false]
    });
    [/#if]
    })
    ;
</script>
[#--
------------        Google integration      -------------
https://fullcalendar.io/docs/google_calendar/
---------------------------------------------------------
<script type='text/javascript' src='fullcalendar/gcal.js'></script>
$(document).ready(function() {
    $('#calendar').fullCalendar({
        googleCalendarApiKey: '<YOUR API KEY>',
        eventSources: [
            {
                googleCalendarId: 'abcd1234@group.calendar.google.com'
            },
            {
                googleCalendarId: 'efgh5678@group.calendar.google.com',
                className: 'nice-event'
            }
        ]
    });
});
--]