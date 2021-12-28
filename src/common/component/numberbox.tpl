{php} 
	$min = (isset($_field['config']['min']) && ($_field['config']['min'] !== '')?"min='".$_field['config']['min']."'":'');
	$max = (isset($_field['config']['max']) && ($_field['config']['max'] !== '')?"max='".$_field['config']['max']."'":'');
	$minlength = (isset($_field['config']['minlength']) && ($_field['config']['minlength'] !== '')?"minlength='".$_field['config']['minlength']."'":'');
	$maxlength = (isset($_field['config']['maxlength']) && ($_field['config']['maxlength'] !== '')?"maxlength='".$_field['config']['maxlength']."'":'');
{/php}
<input type="number" id="{$_ns}" class="form-control help-block m-b-none" name="{$_field.field}" value="{$_field.value}" placeholder="<?php echo (isset($_field['config']['prompt']) && ($_field['config']['prompt'] !== '')?$_field['config']['prompt']:''); ?>" {if condition='$_field.config.disabled eq 1'} disabled {/if} {if condition='$_field.config.readonly eq 1'} readonly {/if}{if condition='$_field.config.required eq 1'} required {/if} {$max} {$min} {$minlength} {$maxlength}/> 