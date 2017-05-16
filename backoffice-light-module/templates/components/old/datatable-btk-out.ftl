[#include "../../macro/btk-util.ftl"]
[#include "../../macro/old/btk-headers.ftl"]
[@dataTableHeaders/]
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
        <span class="label label-default">${category.name!category.@name!}</span>
    [/#list]
[/#if]
[#--if content.option?has_content]
    <div>${content.option!}</div>
[/#if--]
    <template is="dom-bind" id="app">
        <demo-menu>
            <style is="custom-style">
                paper-card {
                    --paper-card-header-text: {
                        font-family: 'Roboto', 'Noto', sans-serif;
                        font-weight: normal;
                        font-size: 20px;
                    }
                }
            </style>
            <paper-card heading="Just a normal data table">
                <paper-datatable data="{{data}}" selectable multi-selection>
                    <paper-datatable-column header="Dessert (100g serving)" property="title" type="String"
                                            style="width:99%;" sortable></paper-datatable-column>
                    <paper-datatable-column header="Calories" property="calories" type="Number" align="right" sortable
                                            tooltip="The total amount of food energy in the given serving size."
                                            sorted></paper-datatable-column>
                    <paper-datatable-column header="Fat (g)" property="fat" type="Number" align="right"
                                            format-value="[[toFixedOne]]" sortable
                                            tooltip="The total amount of fat in the given serving size."></paper-datatable-column>
                    <paper-datatable-column header="Carbs (g)" property="carbs" type="Number" align="right" sortable
                                            tooltip="The total amount of carbs in the given serving size."></paper-datatable-column>
                    <paper-datatable-column header="Protein (g)" property="protein" type="Number" align="right"
                                            format-value="[[toFixedOne]]" sortable
                                            tooltip="The total amount of protein in the given serving size."></paper-datatable-column>
                    <paper-datatable-column header="Sodium (mg)" property="sodium" type="Number" align="right" sortable
                                            tooltip="The amount of sodium as a percentage of the recommended daily amount."></paper-datatable-column>
                    <paper-datatable-column header="Calcium (%)" property="calcium" type="Number" align="right"
                                            format-value="[[toPercentage]]" sortable
                                            tooltip="The amount of calcium as a percentage of the recommended daily amount."></paper-datatable-column>
                    <paper-datatable-column header="Iron (%)" property="iron" type="Number" align="right"
                                            format-value="[[toPercentage]]" sortable
                                            tooltip="The amount of iron as a percentage of the recommended daily amount."></paper-datatable-column>
                </paper-datatable>
            </paper-card>
    </template>
    <script>
        var app = document.querySelector('#app');
        app.data = [
            {
                id: 0,
                title: 'Frozen yogurt',
                calories: 159,
                fat: 6,
                carbs: 24,
                protein: 4,
                sodium: 87,
                calcium: .14,
                iron: .01
            },
            {
                id: 1,
                title: 'Ice cream sandwich',
                calories: 237,
                fat: 9,
                carbs: 37,
                protein: 4.3,
                sodium: 129,
                calcium: .08,
                iron: .01
            },
            {
                id: 2,
                title: 'Eclair',
                calories: 262,
                fat: 16,
                carbs: 24,
                protein: 6,
                sodium: 337,
                calcium: .06,
                iron: .07
            },
            {
                id: 3,
                title: 'Cupcake',
                calories: 305,
                fat: 3.7,
                carbs: 67,
                protein: 4.3,
                sodium: 413,
                calcium: .03,
                iron: .08
            },
            {
                id: 4,
                title: 'Gingerbread',
                calories: 356,
                fat: 16,
                carbs: 49,
                protein: 3.9,
                sodium: 327,
                calcium: .07,
                iron: .16
            },
            {id: 5, title: 'Jelly bean', calories: 373, fat: 0, carbs: 94, protein: 0, sodium: 50, calcium: 0, iron: 0}
        ];
        app.toFixedOne = function (value) {
            return value.toFixed(1);
        };
        app.toPercentage = function (value) {
            return Math.round(value * 10000) / 100 + '%';
        };
    </script>
</div>


