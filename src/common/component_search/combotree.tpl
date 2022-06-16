<!-- 下拉选项（数据源） -->
<style>.comboTreeDropDownContainer ul {margin-left: 12px !important;}</style>
<link rel="stylesheet" type="text/css" href="{$Public}css/plugins/combo-tree/style.css"/>
<input class="form-control help-block m-b-none" type="text" id="{$_ns}" placeholder="<?php echo (isset($_field['config']['prompt']) && ($_field['config']['prompt'] !== '')?$_field['config']['prompt']:''); ?>" autocomplete="off" {if condition='$_field.config.disabled eq 1'} disabled {/if} {if condition='$_field.config.readonly eq 1'} style="cursor: pointer !important;background-color:#fff !important;" readonly {/if}{if condition='$_field.config.required eq 1'} required {/if}/>
<input id="{$_ns}_comboTree" class="form-control" type="hidden" name="{$_field.field}@{$_field.condition}" value="{$_field.value}">
<script src="{$Public}js/plugins/combo-tree/comboTreePlugin.js"></script>
<script>
	$(function() {
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
					$_where[] = ['name'=>$_tmp[0].'@'.$_tmp[1],'value'=>$_tmp[2]];
				}
			};
		?>
		$.ajax({
            url: '{:yunurl('/api/index')}',
            type: 'POST',
            dataType: 'json',
            headers: {
                'Authorization': '{:yun_encrypt(['where'=>$_where,'api'=>'modeldata','model'=>$_field['config']['model']??'','app'=>$_field['config']['app']??'','order'=>['sort'=>'desc','id'=>'asc']],7200)}'
            },
            data: {
            	rows: 1000,
            	page: 1
            },
            success:function(res){
            	let bbb = $('#{$_ns}').comboTree({
            		key: "{$_field.config.value|default='id'}",
                    name: "{$_field.config.name|default='title'}",
					source : YunCms.FN.array2tree(res.rows),
					isMultiple: <?php echo (isset($_field['config']['isMultiple']) && ($_field['config']['isMultiple'] !== '')?$_field['config']['isMultiple']:'false'); ?>,
					cascadeSelect: true,
					selectableLastNode: true,
					selected:{:json_encode(explode(',',$_field.value))}
				}).onChange(function(){
					$('#{$_ns}_comboTree').val(this.getSelectedIds());
				});
            }
        });
    });
</script>