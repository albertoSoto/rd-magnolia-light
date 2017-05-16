[#--deprecated--]
[#macro dataTableHeaders]
<script src="${ctx.contextPath}/.resources/backoffice-light-module/bower_components/webcomponentsjs/webcomponents-lite.min.js"></script>
<script>
    window.Polymer = window.Polymer || {};
    window.Polymer.dom = 'shadow';
</script>
[#--
${ctx.contextPath}/.resources/backoffice-light-module/bower_components/paper-datatable/paper-datatable-card.html
--]
<link rel="import" href="${ctx.contextPath}/.resources/backoffice-light-module/bower_components/polymer/polymer-mini.html">
[#--<link rel="import" href="../../../paper-card/paper-card.html">--]
[#--<link rel="import" href="${ctx.contextPath}/.resources/backoffice-light-module/bower_components/paper-datatable/paper-datatable-card.html">--]
<link rel="import" href="${ctx.contextPath}/.resources/backoffice-light-module/bower_components/paper-datatable/paper-datatable.html">
<link rel="import" href="${ctx.contextPath}/.resources/backoffice-light-module/bower_components/paper-datatable//docs/documentation-menu.html">
<!--style is="custom-style">
    :root{
    }
    body{
        overflow:hidden;
    }
    paper-card{
        display:block;
    }
</style-->
[/#macro]
