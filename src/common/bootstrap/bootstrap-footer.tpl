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
<script src="{$Public}js/plugins/select2/select2.full.js"></script>
<script src="{$Public}js/plugins/bootstrap-table/jquery.treegrid.min.js"></script>
<script src="{$Public}js/plugins/bootstrap-table/extensions/treegrid/bootstrap-table-treegrid.min.js"></script>
<script src="{$Public}js/plugins/bootstrap-table/extensions/custom-view/bootstrap-table-custom-view.min.js"></script>
<script src="{$Public}js/plugins/fancybox/jquery.fancybox.js"></script>
<script>
    $.fn.select2.defaults.set( "theme", "bootstrap");
    $(window).resize(function () {
    　　$('.yuncon').css('height',$(window).height() - 50);
        $("#{$namespace}_exampleTableFromData").bootstrapTable('resetView', {height: $(window).height() - ((Yun.TableOptions.pagination)?180:125)});
    });
    $("body").delegate(".form-control","propertychange input",function(){
        if($(this).val() == ''){$(this).next('.editable-clear-x').css('display','none');}else{$(this).next('.editable-clear-x').css('display','block');}
    });
    $(".cle").on('click',function(){
        $(this).prev().val('');
        $(this).css('display','none');
        Yun.Search();
    });
    $(".saixuan").on('click',function(){
        $("._search").toggleClass("active");
    });
    $(document).ready(function(){
        $('.yuncon').css('height',$(window).height() - 50);
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
        localStorage.setItem("csrf-token", '{:token()}');
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
                export:"{:mca('export')}",
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
                cache:true,
                locale: 'zh-CN',
                url: '{:yunurl("/api/index")}',  /*请求后台的URL（*）*/
                method: 'post',  /*请求方式（*）*/
                ajaxOptions:{async:true},/*true为异步，false同步*/
                height: $(window).height() - 180,
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
                showCustomView:false,/*显示自定义视图*/
                exportDataType: 'basic',   //导出的方式 all全部 selected已选择的  basic', 'all', 'selected'.
                exportTypes:[ 'json', 'xml', /*'png',*/ 'csv', 'txt', 'sql', 'doc', 'excel', 'pdf'],
                exportOptions:{
                    //ignoreColumn: [-1,-1],  //忽略某一列的索引
                    fileName: '111',  //文件名称设置
                    worksheetName: 'sheet1',  //表格工作区名称
                    // tableName: questionNaireName,
                    // excelstyles: ['background-color', 'color', 'font-size', 'font-weight'], 设置格式
                },
                showPrint: false,/*显示打印*/
                showFooter:false,/*显示页脚*/
                buttonsClass:"primary",/*按钮主题*/
                serverSort:false,/*服务端排序*/
                uniqueId: "id",/*唯一id*/
                toolbar: "#Toolbar",/*工具栏*/
                toolbarAlign:"left",/*工具栏的位置*/
                dataType: "json",
                undefinedText: 'N/A',/*字段为空时显示*/
                contentType : "application/x-www-form-urlencoded",
                stickyHeader: false,/*悬浮头部*/
                stickyHeaderOffsetY:0,
                //stickyHeaderOffsetLeft: parseInt($('body').css('padding-left'), 10),/*左偏移量*/
                //stickyHeaderOffsetRight: parseInt($('body').css('padding-right'), 10),/*右偏移量*/
                search: false,/*是否显示表格搜索，此搜索是客户端搜索，不会进服务端*/
                //searchHighlight:true,/*搜索显示高亮。客户端*/
                searchTimeOut: 100,
                trimOnSearch:true,/*去除搜索时两端空格*/
                fixedColumns: false,/*固定列*/
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
                //theadClasses:'thead-dark',/*主题thead-dark*/
                smartDisplay:true,
                classes:'table table-bordered table-hover table-striped',/*table-bordered显示边框table-hover移入效果table-striped隔行间色table-dark黑色主题table-sm小table-borderless无边框*/
                //detailView:true,/*详细视图*/
                //detailViewicon:false,
                //detailViewByClick:true,
                //detailFormatter:"detailFormatter",
                //groupBy:true,
                //groupByField:['group'],
                responseHandler:function (res){
                    if (res.code==401) {YunCms.MSG.alert(res.msg, {anim: 4});
                        setTimeout(function () {
                            top.window.location.href=res.url;
                        }, 1500);
                    }
                    return res;
                },
                paginationSuccessivelySize: 2,/*分页索要数量*/
                paginationPagesBySide: 1,
                paginationUseIntermediate: false,
                paginationParts:['pageInfo','pageSize','pageList'],/*'pageInfoShort','pageInfo','pageSize','pageList'*/
                ajaxOptions:{
                    headers: {"Authorization":'{$Authorization|default="null"}'}
                },
                queryParams:function (params){
                    return $.extend({
                        rows: params.limit,//页面大小
                        page: (params.offset / params.limit) + 1,//页码
                    }, Yun.SearchParams);
                },
                loadingFontSize:'1.4rem',
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
                        headers: {
                            'X-CSRF-TOKEN': localStorage.getItem('csrf-token')
                        },
                        success: function (data, status) {
                            if (status == "success" && data['code'] == 1) $('#{$namespace}_exampleTableFromData').bootstrapTable('refresh');
                            localStorage.setItem("csrf-token", data['token']);
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