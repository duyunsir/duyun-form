<!-- 布尔类型 -->
<div class="radio i-checks" style="display: inline-block;">
    <label><input type="radio" name="{$_field.field}" value="1" {if condition='$_field.config.required eq 1'} required {/if} {if condition='$_field.value eq 1'} checked {/if}{if condition='$_field.config.disabled eq 1'} disabled {/if} {if condition='$_field.config.readonly eq 1'} readonly {/if}> 是 </label>
	<label><input type="radio" name="{$_field.field}" value="0" {if condition='$_field.config.required eq 1'} required {/if} {if condition='$_field.value eq 0'} checked {/if}{if condition='$_field.config.disabled eq 1'} disabled {/if} {if condition='$_field.config.readonly eq 1'} readonly {/if} > 否 </label>
</div>