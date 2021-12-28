<ul class="upload-ul clearfix" style="padding-left: 0px;">
	<?php if(is_array($_field['value'])): foreach($_field['value'] as $ke => $_vu):?>
	<li id="fileBox_{$_vu.id}" class="diyUploadHover" data-id="{$_vu.id}"><div class="viewThumb"><div class="diyBar" style="display: none;"></div><p class="diyControl" style="line-height: 16px;"><span class="diyCancel"><i></i></span><span class="diyLeft"><i></i></span><span class="diyRight"><i></i></span></p>{if condition='$_vu.type eq "video"'} <video src="{$_vu.url|default=''}" controls="controls"></video>{else/}<img src="{$_vu.url|default=''}">{/if}</div>
	</li>
	<script type="text/javascript">
		$(function(){
			let pp= new Array();
			var $fileBox = $("#fileBox_{$_vu.id}");
			$fileBox.parent('.upload-ul').children('.diyUploadHover').each(function(index, el) {
	            pp.push($(this).attr('data-id'));
	        });
	        document.getElementById('{$_ns}_hidden').value=pp.join(',');
			//绑定左移事件;
	        var $diyLeft = $fileBox.find('.diyLeft').on('click',function(){
	        	let arr= new Array();
		        $(this).parents('.diyUploadHover').insertBefore($(this).parents('.diyUploadHover').prev());
		        $(this).parent('.upload-ul').children('.diyUploadHover').each(function(index, el) {
		            arr.push($(this).attr('data-id'));
		        });
		        document.getElementById('{$_ns}_hidden').value=arr.join(',');
	        });
	        //绑定右移事件;
	        var $diyRight = $fileBox.find('.diyRight').on('click',function(){
	        	let arr= new Array();
		        $(this).parents('.diyUploadHover').insertAfter($(this).parents('.diyUploadHover').next());
		        $(this).parent('.upload-ul').children('.diyUploadHover').each(function(index, el) {
		            arr.push($(this).attr('data-id'));
		        });
		        document.getElementById('{$_ns}_hidden').value=arr.join(',');
	        });
			//绑定取消事件;
	        var $diyCancel = $fileBox.find('.diyCancel').on('click',function(){
	        	let Id=$fileBox.attr('data-id');let arr= new Array();
	        	$(this).parents('.diyUploadHover').remove();
		        $(this).parent('.upload-ul').children('.diyUploadHover').each(function(index, el) {
		            arr.push($(this).attr('data-id'));
		        });
		        document.getElementById('{$_ns}_hidden').value=arr.join(',');
	            /*数据库删除操作代码*/
	            $.ajax({
	            	url: '{:yunurl("/upload/delfile")}',
	                type: 'post',
	                dataType: 'json',
	                data: {ids:Id},
	            }).done(function(res) {
                	$('#{$_ns}_upload-pick').show();
                	layer.msg(res.msg,{anim:4});
	            }).fail(function() {
	            	console.log("error");
	            });
	        });
	    });
	</script>
	<?php endforeach;endif; ?>
	{php} $style = (count($_field['value']?:[]) < ($_field['config']['num']??1))?'':'display: none;';{/php}
    <li class="upload-pick" id="{$_ns}_upload-pick"  style="{$style}">
        <div class="webuploader-container clearfix" id="{$_ns}"></div>
    </li>
</ul>
<input id="{$_ns}_hidden" name="{$_field.field}" type="hidden" class="form-control help-block m-b-none" value="" {if condition='$_field.config.required eq 1'} required {/if}>
<script>
    $(function(){
        var $tgaUpload = $('#{$_ns}').diyUpload({
            url:'{$_field.config.uploadUrl|default=""}',
            auto:true,
            accept: {
            	title: '{$_field.config.accept|default=""}',
                mimeTypes: '{$_field.config.accept|default="yun"}',
                extensions: "<?php if(!(empty($_field['config']['extensions']) || ($_field['config']['extensions'] instanceof \think\Collection && $_field['config']['extensions']->isEmpty()))): echo $_field['config']['extensions'];?><?php endif; ?>",
            },
            formData: {:html_entity_decode($_field.config.formData)},
            fileNumLimit : {$_field.config.num|default=1},
            chunked:{$_field.config.chunked|default='false'},
            thumb:{
                width:120,
                height:90,
                quality:90,
                allowMagnify:false,
                crop:true,
                type:"image/*"
            },
            success:function(data,response) {
                document.getElementById('{$_ns}_hidden').value+=','+response['id'];
                if (document.getElementById('{$_ns}_hidden').value.substr(0,1)==',') document.getElementById('{$_ns}_hidden').value=document.getElementById('{$_ns}_hidden').value.substr(1);
                $('#fileBox_'+data.id).attr('data-id',response['id']);
            },
            error:function( err ) { }
        });
    });
</script>
