{include file="../vendor/duyun/yunsaas/src/common/header.tpl" /}
{php} $app = getApp(request()->pathinfo());{/php}
<!-- <link href="https://unpkg.com/jquery-resizable-columns@0.2.3/dist/jquery.resizableColumns.css" rel="stylesheet"> -->
<link href="{$Public}css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
<link href="{$Public}css/plugins/bootstrap-table/perfect-scrollbar.css" rel="stylesheet">
<link href="{$Public}js/plugins/bootstrap-table/extensions/sticky-header/bootstrap-table-sticky-header.css" rel="stylesheet">
<link href="{$Public}js/plugins/bootstrap-table/extensions/fixed-columns/bootstrap-table-fixed-columns.min.css" rel="stylesheet">
<link href="{$Public}js/plugins/bootstrap-table/extensions/editable/bootstrap-editable.css" rel="stylesheet">
<link href="{$Public}css/plugins/select2/select2.css" rel="stylesheet" />
<link href="{$Public}css/plugins/bootstrap-table/jquery.treegrid.css" rel="stylesheet">
<!-- <link href="{$Public}css/iconfont/iconfont.css" rel="stylesheet"> -->
<link href="{$Public}js/plugins/fancybox/jquery.fancybox.css" rel="stylesheet">
<style>.fixed-table-pagination{height: 14px;}.bootstrap-table .fixed-table-container .fixed-table-body {overflow: hidden;position: relative;}.fixed-table-loading{top: 0 !important;}.layui-layer-tips {margin-top: -17px !important;}</style>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated {$Animat|default='fadeIn'}">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title" style="padding-top: 7px;">
                        <div class="col-sm-9" style="padding-left: 0px;margin-top: 7px;">
                            <h5>{$Title}</h5>
                        </div>
                        <div class="col-sm-3" style="padding-right: 0px;">
                            <!-- <div class="input-group">
                                <input autocomplete="on" id="{$namespace}_keyword" type="text" class="input-sm form-control"> <span class="input-group-btn">
                                <button onclick="Yun.Search()" type="button" class="btn btn-sm btn-primary"> 搜索</button> </span>
                            </div> -->
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="example">
                            <div id="Toolbar">
                              <div class="form-inline" role="form">
                                <div class="form-group">
                                    {if access(mca('add'),0)&&in_array('add',$Button)}
                                    <button class="btn btn-white" data-toggle="tooltip" data-placement="top" title="添加" onclick="YunCms.RTS.sub(Yun.Add)">
                                        <i class="fas fa-plus" aria-hidden="true"></i>
                                    </button>
                                    {/if}
                                    {if access(mca('copy'),0)&&in_array('copy',$Button)}
                                    <button class="btn btn-white" data-toggle="tooltip" data-placement="top" title="表单复制" onclick="Yun.Copy('{:input('id')}')"><i class="far fa-copy" aria-hidden="true"></i>
                                    </button>
                                    {/if}
                                    {if access(mca('optimize'),0)&&in_array('optimize',$Button)}
                                    <button class="btn btn-white {$namespace}_batch" disabled data-toggle="tooltip" data-placement="top" title="优化选中" onclick="Yun.Optimize()">优化选中
                                    </button>
                                    {/if}
                                    {if access(mca('repair'),0)&&in_array('repair',$Button)}
                                    <button class="btn btn-white {$namespace}_batch" disabled data-toggle="tooltip" data-placement="top" title="修复选中" onclick="Yun.Repair()">修复选中
                                    </button>
                                    {/if}
                                    {if access(mca('exports'),0)&&in_array('exports',$Button)}
                                    <button class="btn btn-white {$namespace}_batch" disabled data-toggle="tooltip" data-placement="top" title="备份选中" onclick="Yun.Exports()">备份选中
                                    </button>
                                    {/if}
                                    {if access(mca('delete'),0)&&in_array('delete',$Button)}
                                    <button type="button" disabled onclick="YunCms.RTS.del('',Yun.Del)" class="btn btn-white {$namespace}_batch" data-toggle="tooltip" data-placement="top" title="删除">
                                        <i class="glyphicon glyphicon-trash" aria-hidden="true"></i>
                                    </button>
                                    {/if}
                                    {if in_array('batch',$Button)}
                                    <div class="btn-group">
                                        <button data-toggle="dropdown" disabled class="btn btn-white dropdown-toggle {$namespace}_batch">批量操作<span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu">
                                            {if access(mca('status'),0)}
                                            <li><a href="javascript:;" onclick="YunCms.RTS.field(false,1,Yun.Status)" class="font-bold">批量审核</a>
                                            </li>
                                            <li><a href="javascript:;" onclick="YunCms.RTS.field(false,0,Yun.Status)" class="font-bold">取消审核</a>
                                            </li>
                                            <li class="divider"></li>
                                            {/if}
                                            {if access(mca('lock'),0)}
                                            <li><a href="javascript:;" onclick="YunCms.RTS.field(false,1,Yun.Lock)" class="font-bold">批量锁定</a>
                                            </li>
                                            <li><a href="javascript:;" onclick="YunCms.RTS.field(false,0,Yun.Lock)" class="font-bold">批量解锁</a>
                                            </li>
                                            {/if}
                                        </ul>
                                    </div>
                                    {/if}
                                </div>
                                <div class="form-group btn-group">
                                  <input autocomplete="on" id="{$namespace}_keyword" type="search" class="form-control search-input" placeholder="">
                                </div>
                                <!-- <button onclick="Yun.Search()" type="button" class="btn btn-primary btn-sm">搜索</button> -->
                              </div>
                            </div>
                            <table id="{$namespace}_exampleTableFromData"><!-- data-loading-template="loadingTemplate" data-show-button-text="true" -->
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    {include file="../vendor/duyun/yunsaas/src/common/footer.tpl" /}
    <script src="{$Public}js/plugins/holder/holder.min.js"></script>
    <script src="{$Public}js/plugins/bootstrap-table/bootstrap-table.min.js"></script>
    <script src="{$Public}js/plugins/bootstrap-table/perfect-scrollbar.min.js"></script>
    <script src="{$Public}js/plugins/bootstrap-table/extensions/mobile/bootstrap-table-mobile.min.js"></script>
    <script src="{$Public}js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
    <script src="{$Public}js/plugins/bootstrap-table/extensions/export/tableExport.min.js"></script>
    <script src="{$Public}js/plugins/bootstrap-table/extensions/export/bootstrap-table-export.min.js"></script>
    <script src="{$Public}js/plugins/bootstrap-table/extensions/print/bootstrap-table-print.min.js"></script>
    <script src="{$Public}js/plugins/bootstrap-table/extensions/sticky-header/bootstrap-table-sticky-header.min.js"></script>
    <script src="{$Public}js/plugins/bootstrap-table/extensions/fixed-columns/bootstrap-table-fixed-columns.min.js"></script>
    <!-- <script src="https://unpkg.com/jquery-resizable-columns@0.2.3/dist/jquery.resizableColumns.min.js"></script>
    <script src="https://unpkg.com/bootstrap-table@1.18.3/dist/extensions/resizable/bootstrap-table-resizable.min.js"></script> -->
    <script src="{$Public}js/plugins/bootstrap-table/extensions/editable/bootstrap-editable.min.js"></script>
    <script src="{$Public}js/plugins/bootstrap-table/extensions/editable/bootstrap-table-editable.min.js"></script>
    <script src="{$Public}js/plugins/select2/select2.js"></script>
    <script src="{$Public}js/plugins/bootstrap-table/jquery.treegrid.min.js"></script>
    <script src="{$Public}js/plugins/bootstrap-table/extensions/treegrid/bootstrap-table-treegrid.min.js"></script>
    <script src="{$Public}js/plugins/fancybox/jquery.fancybox.js"></script>
    <script>
        $(document).ready(function(){
            $(".fancybox").fancybox({openEffect:"none",closeEffect:"none"});
            var ps;
            $("#{$namespace}_exampleTableFromData").on('post-body.bs.table', function () {
              if (ps) ps.destroy()
              ps = new window.PerfectScrollbar('.fixed-table-body')
            })
            $("#{$namespace}_keyword").keypress(function (e) {
                if (e.which == 13) {
                    Yun.Search();
                }
            });/*回车执行*/
            /*选中按钮禁用*/
            $("#{$namespace}_exampleTableFromData").on('check.bs.table uncheck.bs.table check-all.bs.table uncheck-all.bs.table', function () {
                $(".{$namespace}_batch").prop('disabled', !$("#{$namespace}_exampleTableFromData").bootstrapTable('getSelections').length)
            });
            //输入框输入定时自动搜索
            // var to = false;
            // $('#{$namespace}_keyword').keyup(function () {
            //     if(to) {
            //       clearTimeout(to); 
            //     }
            //     to = setTimeout(function () {
            //         Yun.Search();
            //     }, 250);
            // });
        });
        $(function(){
            Yun = {
                Access:{
                    delete:"{:mca('delete')}",
                    status:"{:mca('status')}",
                    sort:"{:mca('resort')}",
                    lock:"{:mca('lock')}",
                    add:"{:mca('add')}",
                    edit:"{:mca('edit')}",
                },
                /*排序配置*/
                Resort:{
                    namespace:'{$namespace}',
                    url:'{:url($app."/resort")}'
                },
                /*审核status配置*/
                Status:{
                    namespace:'{$namespace}',
                    url:'{:url($app."/status")}'
                },
                /*锁定lock配置*/
                Lock:{
                    namespace:'{$namespace}',
                    url:'{:url($app."/lock")}'
                },
                /*删除配置*/
                Del:{
                    namespace:'{$namespace}',
                    url:'{:url($app."/delete")}',
                    loadAfter:function(res){
                        if (res.code==1) {$('#{$namespace}_exampleTableFromData').bootstrapTable('refresh');}
                    }
                },
                /*添加配置*/
                Add : {
                    namespace:'{$namespace}',
                    url:'{:url($app."/add")}',/*设置添加栏目*/
                    loadAfter:function(res){
                        if (res.code==1) {$('#{$namespace}_exampleTableFromData').bootstrapTable('refresh');YunCms.RTS.closeAll();}
                    }
                },
                /*编辑配置*/
                EditParams : {
                    namespace:'{$namespace}',
                    url: '{:url($app."/edit")}',/*设置id*/
                    queryParams:{},
                    loadAfter:function(res){
                        if (res.code==1){$('#{$namespace}_exampleTableFromData').bootstrapTable('refresh');YunCms.RTS.closeAll();}
                    }
                },
                /*搜索配置*/
                SearchParams : {},
                /*编辑操作*/
                Edit : function(Params) {
                    this.EditParams.queryParams = $.extend(this.EditParams.queryParams, Params);
                    YunCms.RTS.sub(this.EditParams);
                },
                /*菜单组*/
                Menus : function(value, row, index,arr) {
                    var value = [1,0];
                    menus = (YunCms.FN.isInArray(arr,'lock'))?'<div class="btn-group btn-group-sm dropup" style="display: inline-block;"><button class="btn shadow-0 '+((row.locked==0)?'btn-outline-success':'btn-warning')+'" data-toggle="tooltip" data-placement="top" title="'+ ((row.locked==1)?'已锁':'未锁') +'" onclick="YunCms.RTS.field('+row.id+','+value[row.locked]+',Yun.Lock)"><i class="fas '+ ((row.locked==1)?'fa-lock':'fa-unlock-alt') +'" aria-hidden="true"></i></button></div>':'';

                    menus += '<div class="btn-group shadow-0" style="display: inline-block;margin-left:5px;"> <div class="btn-group btn-group-sm dropup">';
                    menus += (YunCms.FN.isInArray(arr,'status'))?'<button onclick="YunCms.RTS.field('+row.id+','+value[row.status]+',Yun.Status)" type="button" class="btn shadow-0 '+((row.status==1)?'btn-outline-success':'btn-warning')+'" data-toggle="tooltip" data-placement="top" title="'+ ((row.status==1)?'已审核':'未审核') +'"><i class="fas '+((row.status==1)?'fa-check':'fa-times')+'" aria-hidden="true"></i></button>':'';
                    menus += (YunCms.FN.isInArray(arr,'edit'))?'<button onclick="Yun.Edit({id:'+row.id+'})" type="button" class="btn btn-outline-info" data-toggle="tooltip" data-placement="top" title="编辑"><i class="far fa-edit" aria-hidden="true"></i></button>':'';
                    menus += (YunCms.FN.isInArray(arr,'createcode'))?'<button onclick="Yun.Createcode({id:'+row.id+'})" type="button" class="btn shadow-0 btn-outline-success" data-toggle="tooltip" data-placement="top" title="生成代码"><i class="fas fa-laptop-code" aria-hidden="true"></i></button>':'';
                    
                    menus += (YunCms.FN.isInArray(arr,'manage'))?'<button onclick="Yun.Manage({id:'+row.id+'})" type="button" class="btn btn-outline-success shadow-0" data-toggle="tooltip" data-placement="top" title="表单管理"><i class="fab fa-wpforms" aria-hidden="true"></i></button>':'';
                    menus += (YunCms.FN.isInArray(arr,'preview'))?'<button onclick="Yun.Preview({id:'+row.id+'})" type="button" class="btn btn-outline-success shadow-0" data-toggle="tooltip" data-placement="top" title="表单预览"><i class="far fa-eye" aria-hidden="true"></i></button>':'';
                    menus += (YunCms.FN.isInArray(arr,'sort')) ?'<input min="0" type="number" onchange="YunCms.RTS.field('+row.id+',this.value,Yun.Resort)" class="form-control sort" value="'+row.sort+'">':'';
                    menus += (YunCms.FN.isInArray(arr,'set')) ?'<button name="'+row.id+'" onclick="Yun.Set(this.name)"  type="button" class="btn btn-outline-success shadow-0" data-toggle="tooltip" data-placement="top" title="设置"><i class="glyphicon glyphicon-cog" aria-hidden="true"></i></button>':'';
                    menus += (YunCms.FN.isInArray(arr,'rule'))?'<button onclick="Yun.Rule({group_id:'+row.id+'})" type="button" class="btn btn-outline-success shadow-0" data-toggle="tooltip" data-placement="top" title="功能分配">功能</button>':'';
                    menus += (YunCms.FN.isInArray(arr,'menu'))?'<button onclick="Yun.Menu({group_id:'+row.id+'})" type="button" class="btn btn-outline-success shadow-0" data-toggle="tooltip" data-placement="top" title="菜单分配">菜单</button>':'';
                    menus += (YunCms.FN.isInArray(arr,'delete')) ?'<button onclick="YunCms.RTS.del('+row.id+',Yun.Del)" type="button" class="btn btn-outline-danger " data-toggle="tooltip" data-placement="top" title="删除"><i class="far fa-trash-alt" aria-hidden="true"></i></button></button>':'';
                    menus += '</div></div>';
                    return menus;
                },
                /*Bootstrap表格数据*/
                TableOptions:{
                    url: '{:yunurl("/api/index")}',  /*请求后台的URL（*）*/
                    method: 'post',  /*请求方式（*）*/
                    ajaxOptions:{async:true},/*true为异步，false同步*/
                    height: getHeight(),
                    // singleSelect: true,/*复选框只能选择一条记录*/
                    striped: true,   /*是否显示行间隔色*/
                    pagination: true, /*是否显示分页（*)*/
                    sidePagination: 'server',/*设置为服务器端分页*/
                    pageNumber: 1, /*初始化加载第一页，默认第一页,并记录*/
                    pageSize: 20, /*每页的记录行数（*）*/
                    pageList: [20, 50, 100],/*可供选择的每页的行数*/
                    showRefresh: true,/*显示刷新*/
                    // showToggle: true,/*卡片视图*/
                    showColumns: true,/*显示列刷选*/
                    showColumnsToggleAll:true,/*显示列全部按钮*/
                    showExport: false,/*显示导出*/
                    exportDataType: 'basic',   //导出的方式 all全部 selected已选择的  basic', 'all', 'selected'.
                    exportTypes:[ 'json', 'xml', /*'png',*/ 'csv', 'txt', 'sql', 'doc', 'excel', 'pdf'],
                    exportOptions:{
                        ignoreColumn: [-1,-2],  //忽略某一列的索引
                        fileName: '111',  //文件名称设置
                        worksheetName: 'sheet1',  //表格工作区名称
                        // tableName: questionNaireName,
                        // excelstyles: ['background-color', 'color', 'font-size', 'font-weight'], 设置格式
                    },
                    showPrint: false,/*显示打印*/
                    showFooter:false,/*显示页脚*/
                    serverSort:false,/*服务端排序*/
                    uniqueId: "id",/*唯一id*/
                    toolbar: "#Toolbar",/*工具栏*/
                    toolbarAlign:"left",/*工具栏的位置*/
                    dataType: "json",
                    undefinedText: 'N/A',/*字段为空时显示*/
                    contentType : "application/x-www-form-urlencoded",
                    stickyHeader: true,/*悬浮头部*/
                    search: false,/*是否显示表格搜索，此搜索是客户端搜索，不会进服务端*/
                    searchTimeOut: 100,
                    trimOnSearch:true,/*去除搜索时两端空格*/
                    fixedColumns: true,/*固定列*/
                    fixedNumber: 2,/*固定前列*/
                    fixedRightNumber: 1,/*固定后列*/
                    clickToSelect:true,/*点击行选中*/
                    singleSelect:false,
                    maintainSelected :true, //3,开启分页保持选择状态，就是用户点击下一页再次返回上一页
                    mobileResponsive:true,/*开启移动端自适应*/
                    showPaginationSwitch:false,/*开启显示和关闭分页按钮*/
                    showFullscreen:true,/*显示全屏*/
                    idField:"id",/*设置选择行的字段 */
                    paginationPreText:"上一页",/*分页按钮名称*/
                    paginationNextText:"下一页",/*分页按钮名称*/
                    resizable:true,/*可排序*/
                    // responseHandler:function (res){
                    //     return JSON.parse(res);
                    // },
                    queryParams:function (params){
                        return $.extend({
                            rows: params.limit,//页面大小
                            page: (params.offset / params.limit) + 1,//页码
                            order:{
                                'create_time':'desc',
                                'id':'desc',
                            }
                        }, Yun.SearchParams);
                    },
                    // formatLoadingMessage: function () {  
                    //     return "请稍等，正在加载中...";
                    // }, 
                    formatNoMatches: function () {  //没有匹配的结果
                        return '抱歉，未查询到数据';
                    },
                    onEditableSave: function (field, row, oldValue, $el) {
                        $.ajax({
                            type: "post",
                            url: "edit",
                            data: row,
                            dataType: 'JSON',
                            success: function (data, status) {
                                if (status == "success" && data['code'] == 0) $('#{$namespace}_exampleTableFromData').bootstrapTable('refresh');
                                YunCms.MSG.alert(data['msg']);
                            },
                            error: function () {
                                YunCms.MSG.error('编辑失败');
                            },
                            complete: function () {}
                        });
                    },
                }
            };
            //获取table的高度
            function getHeight() {
                return $(window).height() - 100;
            }
        });
        // function loadingTemplate(message) {
        //     // if (type === 'fa') {
        //       return '<i class="fa fa-spinner fa-spin fa-fw fa-2x"></i> 正在努力加载数据中,请稍后...'
        //     // }
        //     // if (type === 'pl') {
        //       return '<div class="ph-item"><div class="ph-picture"></div></div>'
        //     // }
        // }
    </script>
</body>
</html>