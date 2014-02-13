$(function() {
    $('#list').jqGrid({
        caption: '应付列表',
        autowidth: true,
        height: 'auto',
        datatype: 'xml',
        url: 'service/vendee.php',
        editurl: 'service/vendee.php',
        colNames: ['客户', '交易额', '应付'],
        colModel: [{
            name: 'name',
            index: 'name',
            editable: true,
            edittype: 'text',
            editoptions: { size: 10 },
            editrules: { required: true }
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
                caption: '采购清单',
                autowidth: true,
                height: 'auto',
                datatype: 'xml',
                url: 'service/sell/deliver.php?id=' + id,
                colNames: ['单号', '日期', '类型', '价格', '数量'],
                colModel: [{
                    name: 'id',
                    index: 'id',
                    align: 'center'
                }, {
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
