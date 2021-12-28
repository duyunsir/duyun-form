<!-- 多选框 -->
{php}
	$_temps = explode("\r\n",$_field['config']['values']); if(is_array($_temps) || $_temps instanceof \think\Collection): if( count($_temps)==0 ) : echo "" ;else: foreach($_temps as $key=> $_temp): $_temp = explode("|",$_temp);
{/php}
<div class="checkbox i-checks" style="display: inline-block;">
	{php} $checked = (in_array(($_temp['1']),is_array($_field['value'])?$_field['value']:explode(',',$_field['value'])))?'checked':'';{/php}
	<label><input type="checkbox" id="{$_ns}_{$key}" name="{$_field.field}[]" value="{$_temp.1}" {$checked} {if condition='$_field.config.disabled eq 1'} disabled {/if} {if condition='$_field.config.readonly eq 1'} readonly {/if} {if condition='$key eq 0 AND $_field.config.required eq 1'}required{/if}>  {$_temp.0}</label>
</div>
{php}endforeach; endif; else: echo "" ;endif;{/php}