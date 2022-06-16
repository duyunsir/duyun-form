<div id="Toolbar">
  <div class="form-inline" role="form">
    <div class="form-group">
        {if in_array('collapse',$Button)}
        <button class="btn btn-white" data-toggle="tooltip" data-placement="top" title="展开/折叠" onclick="Yun.Collapse()">
            展开/折叠
        </button>
        {/if}
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
                {if access(mca('move'),0)&&in_array('move',$Button)}
                <li class="divider"></li>
                <li><a href="javascript:;" onclick="Yun.Move()" class="font-bold">移动选中</a>
                </li>
                {/if}
            </ul>
        </div>
        {/if}
        {if access(mca('export'),0)&&in_array('export',$Button)}
        <select class="form-control" id="exportType">
            <option value="basic">只导出当前页数据</option>
            <option value="all">导出所有数据</option>
            <option value="selected">导出选中的数据</option>
        </select>
        <script>
            $('#exportType').change(function () {
                Yun.TableOptions.exportDataType = $(this).val();
                $("#{$namespace}_exampleTableFromData").bootstrapTable('destroy').bootstrapTable(Yun.TableOptions);
            });
        </script>
        {/if}
    </div>
    <div class="form-group btn-group">
        {if condition='empty($_groups)'}
            <input autocomplete="on" id="{$namespace}_keyword" type="search" class="form-control search-input" placeholder="请输入搜索内容">
            <span class="editable-clear-x cle" style="display:none;cursor: pointer;"></span>
        {else/}
            <button class="btn btn-white saixuan" data-toggle="tooltip" data-placement="top" title="筛选">
                <i class="fas fa-filter" aria-hidden="true"></i> 筛选
            </button>
        {/if}
    </div>
  </div>
</div>