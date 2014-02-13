$(function() {
    $('#list').jqGrid({
        caption: '库存管理',
        autowidth: true,
        height: 'auto',
        datatype: 'xml',
        url: 'service/product.php',
        editurl: 'service/product.php',
        colNames: ['编号', '名称', '已打字', '未打字', '次品'],
        colModel: [{
            name: 'private_id',
            index: 'private_id',
            editable: true,
            edittype: 'text',
            editoptions: { size: 10 },
            editrules: { required: true },
            searchoptions: { sopt: ['cn', 'nc'] }
        }, {
            name: 'name',
            index: 'name',
            editable: true,
            edittype: 'text',
            editoptions: { size: 10 },
            editrules: { required: true },
            searchoptions: { sopt: ['cn', 'nc'] }
        }, {
            name: 'marked',
            index: 'marked',
            align: 'right',
            searchoptions: { sopt: ['eq', 'ne', 'lt', 'le', 'gt', 'ge'] }
        }, {
            name: 'unmarked',
            index: 'unmarked',
            align: 'right',
            searchoptions: { sopt: ['eq', 'ne', 'lt', 'le', 'gt', 'ge'] }
        }, {
            name: 'unqualified',
            index: 'unqualified',
            align: 'right',
            searchoptions: { sopt: ['eq', 'ne', 'lt', 'le', 'gt', 'ge'] }
        }],
        pager: '#navigator',

        subGrid: true,
        subGridOptions: { reloadOnExpand: false },
        subGridRowExpanded: function(gid, id) {
            var template = '<table id="{id}"></table><div id="{id}-nav"></div>';
            sid = gid + '_s';
            $('#' + gid).html(template.replace(/\{id\}/g, sid));
            $('#' + sid).jqGrid({
                caption: '入库清单',
                autowidth: true,
                height: 'auto',
                datatype: 'xml',
                url: 'service/checkin.php?id=' + id,
                colNames: ['日期', '类别', '货架', '打字', '数量', '备注'],
                colModel: [{
                    name: 'date',
                    index: 'date',
                    align: 'center'
                }, {
                    name: 'property',
                    index: 'property'
                }, {
                    name: 'rack_id',
                    index: 'rack_id'
                }, {
                    name: 'has_marked',
                    index: 'has_marked',
                    align: 'center'
                }, {
                    name: 'count',
                    index: 'count',
                    align: 'right'
                }, {
                    name: 'description',
                    index: 'description'
                }],
                pager: '#' + sid + '-nav'
            }).navGrid('#' + sid + '-nav');
        }
    }).navGrid('#navigator', {
        edit: false
    });
});
