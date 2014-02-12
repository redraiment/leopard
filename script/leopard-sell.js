$(function() {
    $('#purchase').jqGrid({
        caption: '销售清单',
        autowidth: true,
        height: 'auto',
        datatype: 'xml',
        url: 'service/sell/list.php',
        editurl: 'service/sell/edit.php',
        colNames: ['客户', '总交易', '已收款', '余款'],
        colModel: [{
            name: 'custom',
            index: 'custom',
            editable: true,
            edittype: 'text',
            editoptions: { size: 10 },
            editrules: { required: true }
        }, {
            name: 'total-amount',
            index: 'total-amount',
            align: 'right'
        }, {
            name: 'amount',
            index: 'amount',
            align: 'right'
        }, {
            name: 'rest',
            index: 'rest',
            align: 'right'
        }],
        pager: '#navigator',

        subGrid: true,
        subGridOptions: { reloadOnExpand: false },
        subGridRowExpanded: function(gid, id) {
            var template = '<table id="{id}"></table><div id="{id}-nav"></div>';
            sid = gid + '_s';
            $('#' + gid).html(template.replace(/\{id\}/g, sid));
            $('#' + sid).jqGrid({
                caption: '销售记录',
                autowidth: true,
                height: 'auto',
                datatype: 'xml',
                url: 'service/sell/deliver.php?id=' + id,
                colNames: ['发货日期', '产品', '售价', '数量'],
                colModel: [{
                    name: 'date',
                    index: 'date',
                    align: 'center'
                }, {
                    name: 'product',
                    index: 'product'
                }, {
                    name: 'price',
                    index: 'price',
                    align: 'right'
                }, {
                    name: 'count',
                    index: 'count',
                    align: 'right'
                }],
                pager: '#' + sid + '-nav'
            }).navGrid('#' + sid + '-nav');
        }
    }).navGrid('#navigator', {
        edit: false
    });
});
