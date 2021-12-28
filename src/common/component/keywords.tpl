<div class="row">
<div class="col-md-10">
	<input id="<?php echo $_ns; ?>" class="form-control" name="<?php echo $_field['field']; ?>" value="<?php echo $_field['value']; ?>" placeholder="<?php echo (isset($_field['config']['prompt']) && ($_field['config']['prompt'] !== '')?$_field['config']['prompt']:''); ?>"<?php if($_field['config']['disabled'] == '1'): ?> disabled <?php endif; if($_field['config']['readonly'] == '1'): ?> readonly <?php endif; if($_field['config']['required'] == '1'): ?> required <?php endif; ?> />
</div>
<div class="col-md-2">
	<button type="button" class="btn btn-success btn-block" onclick="<?php echo (isset($_field['config']['type']) && ($_field['config']['type'] !== 'Tip')?$_field['config']['type']:''); ?>('#<?php echo $_ns; ?>','<?php echo (isset($_field['config']['type']) && ($_field['config']['type'] !== 'Tip')?$_field['config']['type']:''); ?>');"><?php if(isset($_field['config']['type']) && $_field['config']['type'] == 'suggest_keywords'): ?>提取关键词<?php endif; ?><?php if(isset($_field['config']['type']) && $_field['config']['type'] == 'suggest_tags'): ?>提取标签<?php endif; ?><?php if(!isset($_field['config']['type'])): ?>错误配置<?php endif; ?></button>
</div>
<!-- <div class="col-md-2" style="display: inline-block;">
	<button type="button" class="btn btn-success btn-block" onclick="<?php echo (isset($_field['config']['type']) && ($_field['config']['type'] !== 'Tip')?$_field['config']['type']:''); ?>('#<?php echo $_ns; ?>','<?php if(isset($_field['config']['field']) && $_field['config']['field']){echo 'yuncms_'.md5('yuncmsformfield_'.$_field['config']['field'].$_nowtime);}else{echo '0';} ?> ','<?php echo (isset($_field['config']['strong']) && ($_field['config']['strong'] !== '')?$_field['config']['strong']:'0'); ?> ');">插入到内容</button>
</div> -->
</div>
<script>
function <?php echo (isset($_field['config']['type']) && ($_field['config']['type'] !== 'Tip')?$_field['config']['type']:''); ?>(IDns,Api){
	if (Api=='Tip') {layer.msg('请检查表单配置是否正确',{anim:6});return false;}
	var anArray = {};
	<?php if(!empty($_field['config']['extract'])):foreach(explode(',',$_field['config']['extract']) as $ext => $_ract):?>
	if ($('input[name="<?php echo preg_replace("/\[.*?\]/", "", $_ract); ?>"]').val()) {var <?php echo preg_replace("/\[.*?\]/", "", $_ract); ?>keywords=$('input[name="<?php echo preg_replace("/\[.*?\]/", "", $_ract); ?>"]').val();}
	if ($('textarea[name="<?php echo preg_replace("/\[.*?\]/", "", $_ract); ?>"]').val()) {var <?php echo preg_replace("/\[.*?\]/", "", $_ract); ?>keywords=$('textarea[name="<?php echo preg_replace("/\[.*?\]/", "", $_ract); ?>"]').val();}
	if (um) {
		var <?php echo preg_replace("/\[.*?\]/", "", $_ract); ?>keywords=um.getContentTxt();
	}
	anArray['<?php echo preg_replace("/\[.*?\]/", "", $_ract); ?>'] = <?php echo preg_replace("/\[.*?\]/", "", $_ract); ?>keywords;
	<?php endforeach;endif; ?>
	$.ajax({
        url: '{:yunurl('/api/index')}',
        type: 'POST',
        dataType: 'json',
        data: {
        	api:'<?php echo (isset($_field['config']['type']) && ($_field['config']['type'] !== 'Tip')?$_field['config']['type']:''); ?>',
        	num:<?php echo (isset($_field['config']['num']) && ($_field['config']['num'] !== '')?$_field['config']['num']:8); ?>,
        	<?php if(isset($_field['config']['type']) && $_field['config']['type'] == 'suggest_keywords'): ?>
        	pos:<?php echo (isset($_field['config']['pos']) && ($_field['config']['pos'] !== '')?json_encode($_field['config']['pos']):[]); ?>,
        	<?php endif; ?>
        	k:JSON.parse(JSON.stringify(anArray)),
        },
        success:function(res){
        	$(''+IDns+'').val('');
        	$(''+IDns+'').val(res.data);
        }
    });
}
</script>