<!-- 下拉框 -->
<?php $_temps = explode("\r\n",$_field['config']['values']);$_field['config']['editable'] = isset($_field['config']['editable'])?$_field['config']['editable']:0;if($_field['config']['editable'] == '1'): ?>
<div class="form-inline"> <div class="form-group"> <input style="width: 100%" type="text" class="form-control help-block m-b-none" id="{$_ns}_obj" name="{$_field.field}" value="<?php echo $_field['value']; ?>" placeholder="<?php echo (isset($_field['config']['prompt']) && ($_field['config']['prompt'] !== '')?$_field['config']['prompt']:''); ?>"  {if condition='$_field.config.disabled eq 1'} disabled {/if} {if condition='$_field.config.readonly eq 1'} readonly {/if}{if condition='$_field.config.required eq 1'} required {/if} > </div> <div class="form-group"> <select style="width: 100%" class="form-control help-block m-b-none" id="{$_ns}" onchange="$('#{$_ns}_obj').val($(this).val());" {if condition='$_field.config.disabled eq 1'} disabled {/if} {if condition='$_field.config.readonly eq 1'} readonly {/if}{if condition='$_field.config.required eq 1'} required {/if} > <?php if(is_array($_temps) || $_temps instanceof \think\Collection): if( count($_temps) < 2 ) : echo "" ;else: foreach($_temps as $key=>$_temp): $_temp = explode("|",$_temp); ?><option value="<?php echo $_temp[1]; ?>" {if condition='$_field.value eq $_temp.1'} selected {/if}>{$_temp.0}</option> <?php endforeach; endif; else: echo "" ;endif; ?></select></div></div>
<?php else: ?>
<select class="form-control help-block m-b-none" id="{$_ns}" name="{$_field.field}"  {if condition='$_field.config.disabled eq 1'} disabled {/if} {if condition='$_field.config.readonly eq 1'}style="background-color: #fff;" readonly {/if}{if condition='$_field.config.required eq 1'} required {/if} ><option value="" selected="selected">==请选择==</option> <?php if(is_array($_temps) || $_temps instanceof \think\Collection): if( count($_temps)<2 ) : echo "" ;else: foreach($_temps as $key=>
	$_temp): $_temp = explode("|",$_temp); ?>
	<option value="<?php echo $_temp[1]; ?>" {if condition='$_field.value eq $_temp.1'} selected="selected" {/if}>{$_temp.0}
	</option>
	<?php endforeach; endif; else: echo "" ;endif; ?>
</select>
<?php endif;?>