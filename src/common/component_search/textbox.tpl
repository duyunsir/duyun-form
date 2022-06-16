{php} 
	$minlength = (isset($_field['config']['minlength']) && ($_field['config']['minlength'] !== '')?"minlength='".$_field['config']['minlength']."'":'');
	$maxlength = (isset($_field['config']['maxlength']) && ($_field['config']['maxlength'] !== '')?"maxlength='".$_field['config']['maxlength']."'":'');
	$input_type = $_field['config']['type']??0;
{/php}
{if condition='$input_type eq 0 AND !empty($_field.config.mask)'}
<link rel="stylesheet" href="{$Public}css/plugins/jasny/jasny-bootstrap.min.css"/>
<script src="{$Public}js/plugins/jasny/jasny-bootstrap.min.js"></script>
{/if}
{if condition='$input_type eq 2'}
<link rel="stylesheet" type="text/css" href="{$Public}css/plugins/tagsinput/tagsinput.css"/>
<script src="{$Public}js/plugins/tagsinput/tagsinput.min.js"></script>
{/if}
<input type="<?php if($input_type == '1'): ?>password<?php else: echo 'text' ; endif;?>" class="form-control help-block m-b-none" id="{$_ns}" name="{$_field.field}@{$_field.condition}" value="{$_field.value}" placeholder="<?php echo (isset($_field['config']['prompt']) && ($_field['config']['prompt'] !== '')?$_field['config']['prompt']:''); ?>" {if condition='$_field.config.disabled eq 1'} disabled {/if} {if condition='$_field.config.readonly eq 1'} readonly {/if}{if condition='$_field.config.required eq 1'} required {/if} {$minlength} {$maxlength} {if condition='$input_type eq 2'} data-role="tagsinput" {/if} {if condition='$input_type eq 0 AND !empty($_field.config.mask)'} data-mask="{$_field.config.mask|default=''}" {/if}>
<span class="editable-clear-x cle" style="display:none;cursor: pointer;"></span>