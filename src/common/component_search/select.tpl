<!-- select2下拉框 -->
<!-- http://select2.github.io/select2-bootstrap-theme/4.0.3.html -->
<link href="{$Public}css/plugins/select2/select2.css" rel="stylesheet" />
<link href="{$Public}css/plugins/select2/select2-bootstrap.css" rel="stylesheet" />
<div class="input-group">
<?php $_temps = explode("\r\n",$_field['config']['values']);$_field['config']['editable'] = isset($_field['config']['editable'])?$_field['config']['editable']:0;if($_field['config']['editable'] == '1'): ?>
 <input style="width: 50%;margin: 0;" type="text" class="form-control help-block m-b-none" id="{$_ns}_obj" name="{$_field.field}@{$_field.condition}" value="<?php echo $_field['value']; ?>" placeholder="<?php echo (isset($_field['config']['prompt']) && ($_field['config']['prompt'] !== '')?$_field['config']['prompt']:''); ?>"  {if condition='$_field.config.disabled eq 1'} disabled {/if} {if condition='$_field.config.readonly eq 1'} readonly {/if}{if condition='$_field.config.required eq 1'} required {/if} ><select style="width: 50%;margin: 0;" class="form-control" id="{$_ns}" onchange="$('#{$_ns}_obj').val($(this).val());" {if condition='$_field.config.disabled eq 1'} disabled {/if} > <?php if(is_array($_temps) || $_temps instanceof \think\Collection): if( count($_temps) < 2 ) : echo "" ;else: foreach($_temps as $key=>$_temp): $_temp = explode("|",$_temp); ?><option value="<?php echo $_temp[1]; ?>" {if condition='$_field.value eq $_temp.1'} selected {/if}>{$_temp.0}</option> <?php endforeach; endif; else: echo "" ;endif; ?></select>
<?php else: ?>
<select class="form-control help-block m-b-none" id="{$_ns}" name="{$_field.field}@{$_field.condition}" {if condition='$_field.config.disabled eq 1'} disabled {/if} {if condition='$_field.config.readonly eq 1'}style="background-color: #fff;width: 50%;margin: 0;" readonly {/if}{if condition='$_field.config.required eq 1'} required {/if} ><option value="" selected="selected">==请选择==</option> <?php if(is_array($_temps) || $_temps instanceof \think\Collection): if( count($_temps)<2 ) : echo "" ;else: foreach($_temps as $key=>$_temp): $_temp = explode("|",$_temp); ?>
	<option value="<?php echo $_temp[1]; ?>" {if condition='$_field.value eq $_temp.1'} selected="selected" {/if}>{$_temp.0}
	</option>
	<?php endforeach; endif; else: echo "" ;endif; ?>
</select>
<?php endif;?>
</div>
<script src="{$Public}js/plugins/select2/select2.full.js"></script>
<script src="{$Public}js/plugins/select2/i18n/zh-CN.js"></script>
<script>
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
	$.fn.select2.defaults.set( "theme", "bootstrap");
	var {$_ns}_value = "{$_field.config.value|default='id'}";
	var {$_ns}_name = "{$_field.config.name|default='title'}";
	let {$_ns}_select = {
		language:"zh-CN",
		allowClear: true,
		placeholder: "<?php echo (isset($_field['config']['prompt']) && ($_field['config']['prompt'] !== '')?$_field['config']['prompt']:''); ?>",
		multiple: <?php echo ((isset($_field['config']['isMultiple']) && $_field['config']['isMultiple'] == 1)?'true':'false'); ?>,// 多选，默认false
		maximumSelectionLength: <?php echo (isset($_field['config']['selectedlength']) && ($_field['config']['selectedlength'] !== '')?$_field['config']['selectedlength']:0); ?>, // 多选 - 设置最多可以选择多少项
		escapeMarkup: function (m) { return m; }, //template的html显示效果，否则输出代码
		/*templateResult: function ( repo ) {// 自定义下拉选项的样式模板
			return '<div></div>';
		},
		templateSelection: function ( repo ) {// 自定义选中选项的样式模板
			return repo.title;
		}*/
	};
	if(2 == '{$_field.config.item_type|default=1}') {$_ns}_select.ajax = {
		url: "{:yunurl("/api/index")}",
		type: 'POST',
		dataType: 'json',
		headers: {
            'Authorization': '{:yun_encrypt(['where'=>$_where,'api'=>'modeldata','model'=>$_field['config']['model']??'','app'=>$_field['config']['app']??'','order'=>['sort'=>'desc','id'=>'asc']],7200)}'
        },
		delay: 250,
		data: function (params) {
			return {
				where : [{'name':{$_ns}_name+'@like','value':"%"+((YunCms.FN.isEmpty(params.term))?'':params.term)+"%"}],
				rows: 20,
				page: params.page
			};
		},
		processResults: function (data, params) {
			params.page = params.page || 1;
        	var rows = $.map(data.rows, function(val,index){
        		val['id'] = val[{$_ns}_value];
        		val['text'] = val[{$_ns}_name];
				return val;
			});
			return {
				results: rows,
				pagination: {
					more: (params.page * 20) < data.total
				}
			};
		},
		cache: true
	};
	$( "#{$_ns}" ).select2({$_ns}_select);
</script>