[#include "../macro/header.ftl"/]
[#include "../macro/btk-util.ftl"/]
<!doctype html>
<html lang="${cmsfn.language()}">
<head>
[#-- cms.page enables the page dialog.  --]
[@cms.page /]
[@cms.area name="htmlheader" /]
</head>
<body>
[@setDeferJquery openJsTags=true/]
<div class="site-wrapper">
    <div class="site-wrapper-inner">
        <div class="cover-container">
            <div class="masthead clearfix"></div>
            <div class="inner cover">
            [#--be0cb6c9-f230-4483-80da-27729edf2224--]
                <div class="container">
            [#if content.image?has_content]
                [#assign redition = damfn.getRendition(content.image, "square100") /]
                <img src="${redition.link}" class="col-md-2 pull-left">
            [/#if]
                    <h1 class="cover-heading col-md-10" >
                    ${content.title!def.title!"No Hello Magnolia! "}
                    </h1>
                </div>
                <section class="main">
                [@cms.area name="main" /]
                </section>
            </div>
        </div>
    </div>
</div>
[@getJSLinks site=sitefn.site()!/]
</body>
</html>