<link rel="stylesheet" type="text/css" href="{$Public}css/plugins/combo-tree/style.css"/>
<script src="{$Public}js/plugins/combo-tree/comboTreePlugin.js"></script>
<style>.help-block{margin-top:0;}.m-xs{width: auto;flex-wrap: nowrap;justify-content: flex-start;flex-direction: row;}.m-xs .FMulSelectUI{z-index:99;}.comboTreeDropDownContainer{top:34px;}.comboTreeDropDownContainer ul {margin-left: 12px !important;}.comboTreeArrowBtn{z-index: 9;top:1px;padding-left: 3px;padding-top: 3px;}.comboTreeInputBox{border-radius: 0 !important;}.date .input-group-addon{display:none;}.select2-container{min-width:14rem;}.input-group > .select2-hidden-accessible:first-child + .select2-container--bootstrap > .selection > .select2-selection, .input-group > .select2-hidden-accessible:first-child + .select2-container--bootstrap > .selection > .select2-selection.form-control{border-radius: 0;}</style>
<form role="form" class="form-inline" id="search_form">
{foreach $_groups as $key=>$_fields }
    {foreach $_fields as $key=>$_field }
    {php}
    $_nowtime = time();
    $_ns = 'yuncms_'.md5('yuncmsformfield_'.$_field['field'].$_nowtime);
    $_field['config']['readonly'] = $_field['config']['readonly']??0;
    {/php}
    <style>#{$_ns}{min-width: 14rem;}</style>
    {switch $_field.type}
        {case value="hidden"}
            <!-- 隐藏域 -->
            <input type="hidden" name="{$_field.field}@{$_field.condition}" value="{$_field.value}" />
        {/case}
        {case value="textbox"}
            <!-- 单行文本框 -->
            <div class="input-group m-xs"><span class="input-group-addon">{$_field.title}</span>
                {include file="../vendor/duyun/yunsaas/src/common/component_search/textbox.tpl" type='' /}
            </div>
        {/case}
        {case value="combotree"}
            <!-- 下拉选项（数据源） -->
            <div class="input-group m-xs"><span class="input-group-addon">{$_field.title}</span>
                {include file="../vendor/duyun/yunsaas/src/common/component_search/combotree.tpl" type='' /}
            </div>
        {/case}
        {case value="select"}
            <!-- 普通下拉 -->
            <div class="input-group m-xs"><span class="input-group-addon">{$_field.title}</span>
                {include file="../vendor/duyun/yunsaas/src/common/component_search/select.tpl" type='' /}
            </div>
        {/case}
        {case value="daterange"}
            <!-- 时间日期 -->
            <div class="input-group m-xs"><span class="input-group-addon">{$_field.title}</span>
                {include file="../vendor/duyun/yunsaas/src/common/component_search/daterange.tpl" type='' /}
            </div>
        {/case}
        {case value="datadict"}
            <!-- 数据字典 -->
            <div class="input-group m-xs"><span class="input-group-addon">{$_field.title}</span>
                {include file="../vendor/duyun/yunsaas/src/common/component_search/datadict.tpl" type='' /}
            </div>
        {/case}
        {case value="multiselect"}
            <!-- 多级下拉关联 -->
            <div class="input-group m-xs"><span class="input-group-addon">{$_field.title}</span>
                {include file="../vendor/duyun/yunsaas/src/common/component_search/multiselect.tpl" type='' /}
            </div>
        {/case}
        {default /}
        <span style="color:red;"> {$_field.type} 表单类型不存在 请联系QQ:987772927 </span>
    {/switch}
    {/foreach}
{/foreach}
    <div class="input-group m-xs"><a class="btn btn-primary" onclick="Yun.Search()" style="color:#fff;line-height: 1rem;">搜索</a></div>
</form>