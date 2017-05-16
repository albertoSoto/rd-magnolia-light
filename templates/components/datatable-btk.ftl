[#include "../macro/btk-util.ftl"]
[#include "../macro/btk-table-helper.ftl"]
[#assign iteration = rand(0,5000)?string["0"]]
[#assign datatableID = "datatable"+iteration]
<div class="datatable-btk">
[#if content.title?has_content]
    <h2>${content.title!}</h2>
[/#if]
[#if content.desc?has_content]
    <div>${cmsfn.decode(content).desc!}</div>
[/#if]
[#if content.categories?has_content && content.categories?size > 0]
    [#list content.categories as item]
        [#assign category = cmsfn.contentById(item, "category")!]
    [/#list]
[/#if]
[@datatable object=category!"" configuration=content id=datatableID!""/]
    <div id="btnTemplate${datatableID}" style="display: none;">
    [#if content.actions??]
        <div class="btn-group btn-group-xs">
            [#list cmsfn.children(content.actions) as customAction ]
            [#-- label + url + method: ajaxHtml, redraw, post --]
                <button type="button" class="btn btn-default btn-btk-action"
                        data-url="${customAction.url!""}"
                        data-method="${customAction.method!""}">
                    <span class="label">${customAction.label!"Action label not defined"}</span>
                </button>
            [/#list]
        </div>
    [/#if]
    </div>
</div>
<script type="text/javascript">
    [@compress_single_line]
    window.deferAfterjQueryLoaded.push(function () {
        var btk_${datatableID!} = jQuery('#${datatableID}').DataTable(
            [#if content.enableAjax!false]
                [#assign ajaxUrl = content.url!"${ctx.contextPath}/.resources/backoffice-light-module/webresources/exampleData/datatable-btk-data-example.json"]
                    {
                        "columnDefs": [
                            [#assign colcounter = 0]
                            [#list cmsfn.children(content.order) as customColumn ]
                                [#assign title=""]
                                [#if content.labels??]
                                    [#list cmsfn.children(content.labels) as customLabel ]
                                        [#if customColumn.columnKey== customLabel.key]
                                            [#assign title=customLabel.label!""]
                                        [/#if]
                                    [/#list]
                                [/#if]
                                {
                                    "targets": ${colcounter!"0"},
                                    "data": "${customColumn.columnKey!""}",
                                    "title": "${title!customColumn.columnKey}"
                                }[#if customColumn_has_next],[/#if]
                                [#assign colcounter = colcounter+1]
                            [/#list]
                            [#if content.actions??]
                                , {
                                "targets": ${colcounter},
                                "title": "Actions",
                                "data": null,
                                "sortable": false,
                                "searchable": false,
                                "defaultContent": jQuery("#btnTemplate${datatableID}").html()
                            }
                            [/#if]],
                        "ajax": "[#if content.enableCtx?? && content.enableCtx]${ctx.contextPath!""}[/#if]${ajaxUrl!""}"
                    [#--]
                    "columnDefs": [
                        {
                            "targets": 0,
                            "title": "Actions",
                            "data": null,
                            "sortable": false,
                            "searchable": false,
                            "defaultContent": jQuery("#btnTemplate").html()
                        },
                        {"targets": 1, "data": "extn", "title": "id"},
                        {"targets": 2, "data": "name", "title": "Nombre"},
                        {"targets": 3, "data": "position", "title": "Posicion"},
                        {"targets": 4, "data": "salary", "title": "Salario"}
                    ]
                    --]
                    }
            [/#if]
        );
        [#if content.actions??]
            jQuery('#${datatableID!} tbody').on('click', 'button.btn-btk-action', function () {
                var tr = jQuery(this).closest('tr');
                var row = btk_${datatableID!}.row(tr);
            [#-- label + url + method: ajaxHtml, redraw, post --]
                var data = row.data();
                var action = jQuery(this).data();
                var url = "[#if content.enableCtx?? && content.enableCtx]${ctx.contextPath!""}[/#if]" + action.url;
                switch (action.method) {
                    case "ajaxHtml":
                        $.backofficeApp.global.doAjax(url, 'POST', data, function (result) {
                            $.backofficeApp.global.openModal("", result, "Cerrar");
                        }, function (e) {
                            $.backofficeApp.global.openModal("Configuration problem"
                                    , "There was an error loading " + url
                                    , "Close window");
                        });
                        break;
                    case "redraw":
                        $.backofficeApp.global.doAjax(url, 'POST', data, function (result) {
                            location.reload();
                        }, function (e) {
                            $.backofficeApp.global.openModal("Configuration problem"
                                    , "There was an error loading " + url
                                    , "Close window");
                        });
                        break;
                    case "post":
                        $.backofficeApp.global.redirectPost(url, data);
                        break;
                    default:
                        console.log("no action detected");
                }
            });
        [/#if]
    });
    [/@compress_single_line]
</script>