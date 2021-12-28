<link rel="stylesheet" href="{$Public}css/plugins/bootstrap-iconpicker/bootstrap-iconpicker.min.css"/>
<style>.table-icons input{width: 100% !important;}</style>
<?php $_field['config']['editable'] = isset($_field['config']['editable'])?$_field['config']['editable']:0;if($_field['config']['editable'] == '1'): ?>
<div class="input-group">
	<input id="{$_ns}_obj" name="{$_field.field}" type= "text" class="form-control help-block m-b-none" value="<?php echo $_field['value']; ?>" placeholder="<?php echo (isset($_field['config']['prompt']) && ($_field['config']['prompt'] !== '')?$_field['config']['prompt']:''); ?>" {if condition='$_field.config.disabled eq 1'} disabled {/if} {if condition='$_field.config.readonly eq 1'} readonly {/if}{if condition='$_field.config.required eq 1'} required {/if}>
	<span class="input-group-append" > 
		<button id="target" class="btn btn-primary" data-iconset="fontawesome5" data-icon="fas fa-align-justify" data-search-text="搜索图标（英文）" data-rows="7" data-cols="8" data-label-footer="{0} - {1} 个，共 {2} 个图标" data-selected-class="btn-primary" data-search="true" role="iconpicker" {if condition='$_field.config.disabled eq 1'} disabled {/if} data-align="center" style="margin-top: 7px;"></button>
	</span> 
</div>
<?php else: ?>
<div class="input-group">
	<input id="{$_ns}_obj" name="{$_field.field}" type= "hidden" class="form-control" value="<?php echo $_field['value']; ?>">
	<button id="target" class="btn btn-primary" data-iconset="fontawesome5" data-icon="fas fa-align-justify" data-search-text="搜索图标（英文）" data-rows="7" data-cols="8" data-label-footer="{0} - {1} 个，共 {2} 个图标" data-selected-class="btn-primary" data-search="true" role="iconpicker" {if condition='$_field.config.disabled eq 1'} disabled {/if} {if condition='$_field.config.required eq 1'} required {/if}></button>
</div>
<?php endif;?>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="{$Public}js/plugins/bootstrap-iconpicker/bootstrap-iconpicker.bundle.min.js"></script>
<script>$( '#target' ).on( 'change' , function(e) {$('#{$_ns}_obj').val(((e.icon == 'empty')?'':e.icon));});</script>