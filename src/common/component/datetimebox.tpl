<div class="input-group date">
	{php}$D = $_field['value']?:date('Y-m-d');{/php}
    <span class="input-group-addon" style="width: 8%;padding: 8px 12px;"><i class="fa fa-calendar"></i></span>
    <input style="margin-top: 0;" type="text" class="form-control help-block m-b-none" id="{$_ns}" name="{$_field.field}" value="{$D}" placeholder="<?php echo (isset($_field['config']['prompt']) && ($_field['config']['prompt'] !== '')?$_field['config']['prompt']:''); ?>" {if condition='$_field.config.disabled eq 1'} disabled {/if} {if condition='$_field.config.readonly eq 1'} readonly {/if}{if condition='$_field.config.required eq 1'} required {/if} data-mask="9999-99-99">
</div>
<script language="javascript" type="text/javascript" src="{$Public}js/plugins/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	$(function () {
		var [min,max] = "{$_field.config.daterange}".split(" 到 ");
		var Parameter = "<?php echo (isset($_field['config']['timeparameter']) && ($_field['config']['timeparameter'] !== '')?$_field['config']['timeparameter']:'yyyy-MM-dd'); ?>";
		var Con = {dateFmt:Parameter};
		switch({$_field.config.type|default=0}){
			case 1:
				Con['minDate'] = min;
				Con['maxDate'] = max;
				break;
			case 2:
				Con['minDate'] = '%y-%M-01';
				Con['maxDate'] = '%y-%M-%ld';
				break;
			case 3:
				Con['maxDate'] = '%y-%M-{%d-1}';
				break;
			case 4:
				Con['maxDate'] = '%y-%M-%d';
				break;
			default:
			break;
		}
		$('#{$_ns}').attr('onclick', "WdatePicker("+JSON.stringify(Con)+");");
	});
</script>
