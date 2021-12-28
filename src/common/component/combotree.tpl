<!-- 下拉选项（数据源） -->
<style>.comboTreeDropDownContainer ul {margin-left: 12px !important;}</style>
<link rel="stylesheet" type="text/css" href="{$Public}css/plugins/combo-tree/style.css"/>
<input class="form-control help-block m-b-none" type="text" id="{$_ns}" placeholder="<?php echo (isset($_field['config']['prompt']) && ($_field['config']['prompt'] !== '')?$_field['config']['prompt']:''); ?>" autocomplete="off" {if condition='$_field.config.disabled eq 1'} disabled {/if} {if condition='$_field.config.readonly eq 1'} style="cursor: pointer !important;background-color:#fff !important;" readonly {/if}{if condition='$_field.config.required eq 1'} required {/if}/>
<input id="{$_ns}_comboTree" class="form-control" type="hidden" name="{$_field.field}" value="{$_field.value}">
<script src="{$Public}js/plugins/combo-tree/comboTreePlugin.js"></script>
<script>
	$(function() {
		<?php
			if (!empty($_field['config']['queryparams'])) {
				$_where = [];
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
            url: '{:yunurl('/api/index')}',
            type: 'POST',
            dataType: 'json',
            data: {
            	rows: 1000,
            	page: 1,
            	api:'modeldata',
            	order: {
					'sort': 'desc',
				},
				model: '{$_field.config.model}',
				<?php if((isset($_field['config']['queryparams']) && !empty($_field['config']['queryparams']))): ?>
				where: {:json_encode($_where)},
				<?php endif;?>
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