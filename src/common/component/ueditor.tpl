<style type="text/css">
	#edui1_toolbarbox {
	    position: relative !important;
	}
</style>
<script type="text/javascript" charset="utf-8" src="{$Public}js/plugins/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="{$Public}js/plugins/ueditor/ueditor.all.min.js"></script>
<script type="text/plain" name="{$_field.field}" id="{$_ns}">{:html_entity_decode($_field.value)}</script>
<script type="text/javascript">
	$(function(){
		//实例化编辑器
    um = UE.getEditor('{$_ns}',{autoFloatEnabled:false,readonly : <?php if($_field['config']['readonly'] == '1'): ?> true <?php else:?>false<?php endif;?>,autoHeightEnabled:<?php echo (isset($_field['config']['autoheightenabled']) && ($_field['config']['autoheightenabled'] !== '')?$_field['config']['autoheightenabled']:'false'); ?>,maximumWords:<?php echo (isset($_field['config']['maximumwords']) && ($_field['config']['maximumwords'] !== '')?$_field['config']['maximumwords']:'10000'); ?>,wordCount:<?php echo (isset($_field['config']['wordcount']) && ($_field['config']['wordcount'] !== '')?$_field['config']['wordcount']:'true'); ?>,elementPathEnabled:<?php echo (isset($_field['config']['elementpathenabled']) && ($_field['config']['elementpathenabled'] !== '')?$_field['config']['elementpathenabled']:'true'); ?>,initialFrameHeight:<?php echo (isset($_field['config']['initialframeheight']) && ($_field['config']['initialframeheight'] !== '')?$_field['config']['initialframeheight']:'420'); ?>,}); });
</script>