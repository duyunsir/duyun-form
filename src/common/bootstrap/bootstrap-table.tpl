{include file="../vendor/duyun/yunsaas/src/common/bootstrap/bootstrap-header.tpl" /}
<div class="ibox float-e-margins">
    {if condition='isset($Title) AND !empty($Title)'}
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
    {/if}
    <div class="ibox-content">
        <div class="example">
            {include file="../vendor/duyun/yunsaas/src/common/bootstrap/bootstrap-toolbar.tpl" /}
            <table style="height:auto;" id="{$namespace}_exampleTableFromData"><!-- data-loading-template="loadingTemplate" data-show-button-text="true" -->
            </table>
        </div>
    </div>
</div>
{include file="../vendor/duyun/yunsaas/src/common/bootstrap/bootstrap-footer.tpl" /}