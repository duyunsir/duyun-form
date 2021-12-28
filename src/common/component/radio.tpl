<?php $_temps = explode("\r\n",$_field['config']['values']); if(is_array($_temps) || $_temps instanceof \think\Collection): if( count($_temps)<1 ) : echo "可选项最少1项" ;else: foreach($_temps as $key=> $_temp): $_temp = explode("|",$_temp); ?>
	<div class="radio i-checks" style="display: inline-block;">
		<label><input {if condition='$key eq 0 AND $_field.config.required eq 1'} required {/if}{if condition='$_field.config.readonly eq 1'} readonly {/if} type="radio" name="<?php echo $_field['field']; ?>" id="<?php echo $_ns; ?>_<?php echo $key; ?>" value="<?php echo $_temp[1]; ?>" {if condition='$_field.value eq $_temp.1'} checked {/if} {if condition='$_field.config.disabled eq 1'} disabled {/if} > {$_temp.0}</label>
	</div>
<?php endforeach; endif; else: echo "未配置可选项" ;endif; ?>