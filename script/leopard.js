$(function() {
    $('#purchase').jqGrid({
        caption: '销售清单',
        autowidth: true,
        height: "auto",
        datatype: 'xml',
        url: 'data/sell.xml',
        colNames: ['客户名', '总交易', '已收款', '余款'],
        colModel: [
            {name: 'custom', index: 'custom'},
            {name: 'total-amount', index: 'total-amount', sorttype: 'int'},
            {name: 'amount', index: 'amount', sorttype: 'int'},
            {name: 'balance', index: 'balance', sorttype: 'int'}
        ],
        sortorder: 'desc',
        sortname: 'balance',
        subGrid: true,
        subGridOptions: {
            reloadOnExpand: false
        },
        subGridRowExpanded: function(gid, id) {
            var template = '<table id="{id}"></table>';
            sid = gid + '_s';
            mid = gid + '_m';
            $('#' + gid).html(
                template.replace('{id}', sid)
              + template.replace('{id}', mid)
            );
            $('#' + sid).jqGrid({
                caption: '销售记录',
                autowidth: true,
                height: "auto",
                datatype: 'xml',
                url: 'data/details.xml',
                colNames: ['发货日期', '产品', '售价', '数量'],
                colModel: [
                    {name: 'date', index: 'date', sorttype: 'date'},
                    {name: 'product', index: 'product'},
                    {name: 'price', index: 'price', sorttype: 'int'},
                    {name: 'number', index: 'number', sorttype: 'int'}
                ],
                sortorder: 'desc',
                sortname: 'date'
            });
            $('#' + mid).jqGrid({
                caption: '收款记录',
                autowidth: true,
                height: "auto",
                datatype: 'xml',
                url: 'data/money.xml',
                colNames: ['收款日期', '金额'],
                colModel: [
                    {name: 'date', index: 'date', sorttype: 'date'},
                    {name: 'amount', index: 'amount', sorttype: 'int'}
                ],
                sortorder: 'desc',
                sortname: 'date'
            });
        }
    });
});
