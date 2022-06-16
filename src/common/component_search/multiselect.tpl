<link href="{$Public}css/plugins/fmulselect/FMulSelectUI.min.css" rel="stylesheet">
<?php $_field['config']['editable'] = $_field['config']['editable']??0;if($_field['config']['editable'] == '1'): ?>
<div class="form-inline">
    <div class="form-group">
        <input type="text" class="form-control help-block m-b-none" id="{$_ns}_obj" name="{$_field.field}@{$_field.condition}" value="{$_field.value}" placeholder="<?php echo (isset($_field['config']['prompt']) && ($_field['config']['prompt'] !== '')?$_field['config']['prompt']:''); ?> " {if condition='$_field.config.disabled eq 1'} disabled {/if} {if condition='$_field.config.readonly eq 1'} readonly {/if}{if condition='$_field.config.required eq 1'} required {/if} style="width: 100%;z-index: 99;">
    </div>
    <div class="form-group" >
        <div id="{$_ns}" class="form-control" style="width: 100%;margin-top: 5px;"></div>
    </div>
</div>
<?php else: ?>
<input type="hidden" name="{$_field.field}@{$_field.condition}" value="{$_field.value}">
<div id="{$_ns}" class="form-control help-block m-b-none" style="width: 100%;z-index: 9;"></div>
<?php endif;?>
<script src="{$Public}js/plugins/fmulselect/fmulselect.js"></script>
<script type="text/javascript">
    $(function(){
        <?php
            $_where = [];
            if((isset($_field['config']['queryparams']) && !empty($_field['config']['queryparams']))) {
                $_queryparams = explode("\r\n", $_field['config']['queryparams']);
                foreach($_queryparams as $key => $value) {
                    $_tmp = explode('|', $value);
                    if (stripos($_tmp[2], '(I)') === 0) {
                        $_tmp[2] = input(substr($_tmp[2], 3));
                    }
                    elseif(stripos($_tmp[2], '(@)') === 0) {
                        $_tmp[2] = $_data[substr($_tmp[2], 3)];
                    }
                    elseif(stripos($_tmp[2], '($)') === 0) {
                        $_tmp[2] = get_tpl_value($_data, substr($_tmp[2], 3));
                    };
                    $_where[] = [$_tmp[0],$_tmp[1],$_tmp[2]];
                }
            };
        ?>
        $.ajax({
            url: '{:yunurl("/api/index")}',
            type: 'POST',
            dataType: 'json',
            headers: {
                'Authorization': '{:yun_encrypt(['where'=>$_where,'api'=>'multiselect','model'=>$_field['config']['model']??'','field'=>$_field['config']['value']?:'id','order'=>['sort'=>'desc','id'=>'desc']],7200)}'
            },
            success:function(res){
                $('#{$_ns}').FMulSelect({
                    // width: 500,  // 宽度，默认自动
                    height: 'auto',  // 高度，默认30px
                    levels: {$_field.config.levels|default=3},   // 联动级别数量，默认 3级 ,可配置范围 1-n，理论上没有上限
                    data: res['rows'], // 数据源，json格式
                    // levelNames: ['请选择', '请选择', '请选择'],//每个级别的名称，如省市区
                    dataKeyNames: {  //配置数据源的key值 默认 id  name  child
                        "id": "{$_field.config.value|default='id'}",
                        "name": "{$_field.config.name|default='title'}",
                        "childs": "child"
                    }
                });
                $('#{$_ns}').FMulSelectSetVal([{:json_encode($_field.value,JSON_UNESCAPED_SLASHES)}]);
            }
        });
    });
    
</script>