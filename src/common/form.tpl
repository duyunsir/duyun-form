{include file="../vendor/duyun/yunsaas/src/common/header.tpl" /}
<link href="{$Public}css/plugins/iCheck/all.css" rel="stylesheet">
<style>.select2-container{min-width:14rem;}.input-group > .select2-hidden-accessible:first-child + .select2-container--bootstrap > .selection > .select2-selection, .input-group > .select2-hidden-accessible:first-child + .select2-container--bootstrap > .selection > .select2-selection.form-control{border-radius: 0;}</style>
<script type="text/javascript">
    // var index = parent.layer.getFrameIndex(window.name);
    // parent.layer.title('{$FORM|default="云CMS"}-{$_form.title}', index);
    um = '';
    localStorage.setItem('csrf-token', '{:token()}');
</script>
</head>
<body class="white-bg">
    <div class="wrapper wrapper-content animate__animated animate__{$Animat|default='fadeIn'}">
        <div class="row">
            <div class="col-sm-12">
            	{php}$yc = 0;{/php}
                <form id="{$_form.formtime}Form" autocomplete="on" role="form">
                	<div class="tabs-container">
                		{if condition='$_form.is_tab eq 1'}
	                    <div class="tabs-left">
	                        <ul class="nav nav-tabs">
	                        	{foreach $_groups as $key=>$_fields }
	                            <li class="{if condition='$yc eq 0'}active{/if}"><a data-toggle="tab" href="#{$_form.formtime}-{$key}"> {$key}</a>
	                            </li>
	                            {php}$yc++;{/php}
	                            {/foreach}
	                        </ul>
	                        {php}$yc = 0;{/php}
	                        <div class="tab-content ">
						{/if}
							{foreach $_groups as $key=>$_fields }
						{if condition='$_form.is_tab eq 1'}
                            <div id="{$_form.formtime}-{$key}" class="tab-pane {if condition='$yc eq 0'}active{/if}">{php}$yc++;{/php}
                            <div class="panel-body ">
                        {/if}

                                	<div class="row" style="padding: 0 15px;">
                                	{foreach $_fields as $key=>$_field }
	                                	{php}
										$_nowtime = time();
										$_ns = 'yuncms_'.md5('yuncmsformfield_'.$_field['field'].$_nowtime);
										$_field['config']['disabled'] = $_field['config']['disabled']??0;
										$_field['config']['required'] = $_field['config']['required']??0;
										$_field['config']['readonly'] = $_field['config']['readonly']??0;
										$_field['config']['is_group'] = $_field['config']['is_group']??0;
										{/php}
										{if condition='$_field.type eq "hidden"'}
											<input type="hidden" name="{$_field.field}" value="{$_field.value}" />
										{else/}

    										<div class="col-xs-12 {$_field.config.grid|default='col-sm-12'}">
												<div class="form-group">
													<label style="width: auto;padding-left:0;" for="{$_ns}" class="col-xs-12 col-sm-2 control-label">{if condition='$_field.config.required eq 1'} <span class="xin" style="color: red;font-size: 13px;margin-left: -10px;">*</span> {/if}{$_field.title}</label>
													<div class="col-xs-12 col-sm-12 yunsaasvalidate" style="padding-left: 0;">
														{switch $_field.type}
															{case value="bool"}
															    <!-- 布尔类型 -->
									                            {include file="../vendor/duyun/yunsaas/src/common/component/bool.tpl" type='' /}
									                        {/case}
															{case value="select"}
															    <!-- 下拉框 -->
									                            {include file="../vendor/duyun/yunsaas/src/common/component/select.tpl" type='' /}
									                        {/case}
															{case value="radio"}
															    <!-- 单选框 -->
									                            {include file="../vendor/duyun/yunsaas/src/common/component/radio.tpl" type='' /}
									                        {/case}
															{case value="checkbox"}
															    <!-- 多选框 -->
									                            {include file="../vendor/duyun/yunsaas/src/common/component/checkbox.tpl" type='' /}
									                        {/case}
															{case value="textbox"}
															    <!-- 单行文本框 -->
									                            {include file="../vendor/duyun/yunsaas/src/common/component/textbox.tpl" type='' /}
									                        {/case}
															{case value="multitextbox"}
															    <!-- 多行文本框 -->
									                            {include file="../vendor/duyun/yunsaas/src/common/component/multitextbox.tpl" type='' /}
									                        {/case}
															{case value="numberbox"}
															    <!-- 数字框 -->
									                            {include file="../vendor/duyun/yunsaas/src/common/component/numberbox.tpl" type='' /}
									                        {/case}
															{case value="ueditor"}
															    <!-- 百度编辑器 -->
									                            {include file="../vendor/duyun/yunsaas/src/common/component/ueditor.tpl" type='' /}
									                        {/case}
															{case value="ckeditor"}
															    <!-- ckeditor编辑器 -->
									                            {include file="../vendor/duyun/yunsaas/src/common/component/ckeditor.tpl" type='' /}
									                        {/case}
															{case value="combotree"}
															    <!-- 下拉选项（数据源） -->
									                            {include file="../vendor/duyun/yunsaas/src/common/component/combotree.tpl" type='' /}
									                        {/case}

															{case value="files"}
															    <!-- 资源上传 -->
									                            {include file="../vendor/duyun/yunsaas/src/common/component/files.tpl" type='' /}
									                        {/case}

															{case value="datetimebox"}
															    <!-- 时间日期 -->
									                            {include file="../vendor/duyun/yunsaas/src/common/component/datetimebox.tpl" type='' /}
									                        {/case}
															{case value="daterange"}
															    <!-- 时间日期 -->
									                            {include file="../vendor/duyun/yunsaas/src/common/component/daterange.tpl" type='' /}
									                        {/case}
															{case value="datadict"}
															    <!-- 数据字典 -->
									                            {include file="../vendor/duyun/yunsaas/src/common/component/datadict.tpl" type='' /}
									                        {/case}
									                        {case value="multiselect"}
															    <!-- 多级下拉关联 -->
									                            {include file="../vendor/duyun/yunsaas/src/common/component/multiselect.tpl" type='' /}
									                        {/case}
															{case value="button"}
															    <!-- 按钮 -->
									                            {include file="../vendor/duyun/yunsaas/src/common/component/button.tpl" type='' /}
									                        {/case}
															{case value="iconpanel"}
															    <!-- ico图标面板 -->
									                            {include file="../vendor/duyun/yunsaas/src/common/component/iconpanel.tpl" type='' /}
									                        {/case}
															{case value="keywords"}
															    <!-- 关键字 -->
									                            {include file="../vendor/duyun/yunsaas/src/common/component/keywords.tpl" type='' /}
									                        {/case}
															{default /}
															<span style="color:red;"> {$_field.type} 表单类型不存在 请联系QQ:987772927 </span>
														{/switch}
														{php}if(!(empty($_field['remark']) || ($_field['remark'] instanceof \think\Collection && $_field['remark']->isEmpty()))): {/php}
															<span title="{$_field.remark}" data-toggle="tooltip" class="help-block m-b-none" style="text-overflow: ellipsis;white-space: nowrap; overflow: hidden;"><i class="fa fa-info-circle"></i> {$_field.remark}</span>
														{php} endif; {/php}
														<div class="hr-line-dashed"></div>
													</div>
												</div>
											</div>
										{/if}
									{/foreach}
									</div>
						{if condition='$_form.is_tab eq 1'}
								</div>
                            </div>
                        {/if}
							{/foreach}
						{if condition='$_form.is_tab eq 1'}
	                        </div>
	                    </div>
	                	{/if}
	                </div>
                </form>
            </div>
        </div>
    </div>
    <script src="{$Public}js/plugins/iCheck/icheck.min.js"></script>
    <script src="{$Public}js/webuploader.js"></script>
	<script src="{$Public}js/diyUpload.js?v=1.2.2"></script>
    <script src="{$Public}js/plugins/validate/jquery.validate.min.js"></script>
    <script src="{$Public}js/plugins/validate/messages_zh.min.js"></script>
    <script>
        $(document).ready(function(){$(".i-checks").iCheck({checkboxClass:"icheckbox_flat-blue",radioClass:"iradio_flat-blue",})});
        $.validator.setDefaults({
			highlight: function(e) {
				$(e).closest(".form-group").removeClass("has-success").addClass("has-error")
			},
			success: function(e) {
				e.closest(".form-group").find('.xin').css('color', '#1a7bb9');
				e.closest(".form-group").removeClass("has-error").addClass("has-success")
			},
			errorElement: "span",
			errorPlacement: function(e, r) {
				r.closest('.yunsaasvalidate').find('.hr-line-dashed').before(e);
			},
			focusCleanup: true,
			onkeyup: false,
			errorClass: "help-block m-b-none",
			validClass: "help-block m-b-none"
		}), $().ready(function() {
			$("#{$_form.formtime}Form").validate();
		});
        function formsubmit(){
        	var validate = $("#{$_form.formtime}Form").validate().form();
			if (validate) return $('#{$_form.formtime}Form').serialize();
			return false;
        }
    </script>
</body>

</html>