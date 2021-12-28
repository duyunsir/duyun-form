{php} 
	$minlength = (isset($_field['config']['minlength']) && ($_field['config']['minlength'] !== '')?"minlength='".$_field['config']['minlength']."'":'');
	$maxlength = (isset($_field['config']['maxlength']) && ($_field['config']['maxlength'] !== '')?"maxlength='".$_field['config']['maxlength']."'":'');
{/php}
<textarea class="form-control help-block m-b-none" id="{$_ns}" name="{$_field.field}" rows="<?php echo (isset($_field['config']['height']) && ($_field['config']['height'] !== '')?$_field['config']['height']:'5'); ?>" placeholder="<?php echo (isset($_field['config']['prompt']) && ($_field['config']['prompt'] !== '')?$_field['config']['prompt']:''); ?>" {if condition='$_field.config.disabled eq 1'} disabled {/if} {if condition='$_field.config.readonly eq 1'} readonly {/if}{if condition='$_field.config.required eq 1'} required {/if} {$minlength} {$maxlength}>
{$_field.value|html_entity_decode}</textarea>