<link href="{$Public}css/plugins/fmulselect/FMulSelectUI.min.css" rel="stylesheet">
<?php $_field['config']['editable'] = $_field['config']['editable']??0;if($_field['config']['editable'] == '1'): ?>
<div class="form-inline">
    <div class="form-group">
        <input type="text" class="form-control help-block m-b-none" id="{$_ns}_obj" name="{$_field.field}" value="{$_field.value}" placeholder="<?php echo (isset($_field['config']['prompt']) && ($_field['config']['prompt'] !== '')?$_field['config']['prompt']:''); ?> " {if condition='$_field.config.disabled eq 1'} disabled {/if} {if condition='$_field.config.readonly eq 1'} readonly {/if}{if condition='$_field.config.required eq 1'} required {/if} style="width: 100%;">
    </div>
    <div class="form-group" >
        <div id="{$_ns}" class="form-control" style="width: 100%;margin-top: 5px;"></div>
    </div>
</div>
<?php else: ?>
<input type="hidden" name="{$_field.field}" value="{$_field.value}">
<div id="{$_ns}" class="form-control help-block m-b-none" style="width: 100%;"></div>
<?php endif;?>
<script type="text/javascript">
    $.fn.FMulSelect = function(A) {
        var B = this;
        var C = A.levels || 3;
        var D = A.width;
        var E = A.height || 32;
        var F = A.data || [];
        var G = A.levelNames || [];
        var H = A.dataKeyNames;
        var I = H['id'] || 'id';
        var J = H['name'] || 'name';
        var K = H['childs'] || 'childs';
        E -= 2;
        B.addClass('FMulSelectUI').width(D).height(E).data('source', F).attr('data-levels', C);
        B.find('.FMulSelectBox').off('click').remove().end().find('.FMulSelectUI-dropdown').off('click').remove();
        var L = $('<p class="FMulSelectBox" style="padding:0;height: ' + E + 'px;line-height: ' + E + 'px;"></p>');
        var M = new Array(C).join(',').split(',');
        var N = $.map(M, function(v, k) {
            return '<span class="FMulSelectBox-items" data-id="" data-value="" data-text="" data-level="' + (k + 1) + '">请选择</span>'
        }).join('<span class="FMulSelectBox-items-split">/</span>');
        L.append(N);
        B.append(L);
        var O = $('<ul class="FMulSelectUI-dropdown FMulSelectUI-hide"></ul>');
        var P = $.map(M, function(v, k) {
            return '<li class="FMulSelectUI-dropdown-levelItems ' + (k === 0 ? '' : 'FMulSelectUI-hide') + '" data-level="' + (k + 1) + '"><p class="FMulSelectUI-dropdown-levelItems-name">' + (G[k] || '级别' + (k + 1)) + '</p><ul><li class="FMulSelectUI-nodata">无数据</li></ul></li>';
        }).join('');
        O.append(P);
        B.find('.FMulSelectUI-dropdown').remove().end().append(O);
        O.find('.FMulSelectUI-dropdown-levelItems:eq(0) ul').html('').append($.map(F, function(v, k) {
            return '<li class="FMulSelectUI-dropdown-levelItem" data-id="' + v[I] + '" data-text="' + v[J] + '" data-value="' + v['value'] + '">' + v[J] + '</li>'
        }).join('')).find('.FMulSelectUI-dropdown-levelItem').each(function(k, v) {
            $(this).data('source', F[k][K])
        });
        L.on('click', '.FMulSelectBox-items', function() {
            var Q = $(this).attr('data-level');
            O.removeClass('FMulSelectUI-hide');
            O.find('.FMulSelectUI-dropdown-levelItems').addClass('FMulSelectUI-hide').eq(Q - 1).removeClass('FMulSelectUI-hide');
            $(this).addClass('active').siblings('.FMulSelectBox-items').removeClass('active');
            var R = $('.FMulSelectUI').not('#' + B.attr('id'));
            if (R.length) {
                R.FMulSelectClear().find('.FMulSelectUI-dropdown').addClass('FMulSelectUI-hide');
            }
        });
        O.on('click', '.FMulSelectUI-dropdown-levelItem', function() {
            $(this).siblings().removeClass('active').end().addClass('active');
            var S = $(this).closest('.FMulSelectUI-dropdown-levelItems');
            var Q = S.attr('data-level');
            var U = $(this).attr('data-id');
            var V = $(this).attr('data-text');
            var F = $(this).data('source');
            var Mu = $(this).attr('data-value');
            $('input[name="{$_field.field}"]').val(Mu);
            L.find('.FMulSelectBox-items').removeClass('active').eq(Q - 1).attr('data-id', U).attr('data-text', V).attr('data-value', Mu).html(V).end().eq(Q).addClass('active').end().eq(Q - 1).nextAll('.FMulSelectBox-items').attr('data-id', '').attr('data-text', '').attr('data-value', '').html('请选择');
            if (S.next().length) {
                S.next().removeClass('FMulSelectUI-hide').siblings().addClass('FMulSelectUI-hide');
            }
            S.nextAll().find('ul').html('<li class="FMulSelectUI-nodata">无数据</li>');
            S.next().find('ul').html('').append($.map(F, function(v, k) {
                return '<li class="FMulSelectUI-dropdown-levelItem" data-id="' + v[I] + '" data-text="' + v[J] + '" data-value="' + v['value'] + '">' + v[J] + '</li>'
            }).join('') || '<li class="FMulSelectUI-nodata">无数据</li>').find('.FMulSelectUI-dropdown-levelItem').each(function(k, v) {
                $(this).data('source', F[k][K])
            });
        });
        $('body').on('click', function(e) {
            if (!$(e.target).hasClass('FMulSelectUI') && !$(e.target).closest('.FMulSelectUI').length) {
                $('.FMulSelectUI-dropdown').addClass('FMulSelectUI-hide');
                $('.FMulSelectUI').find('.FMulSelectBox-items').removeClass('active')
            }
        });
        return this
    };
    $.fn.FMulSelectGetVal = function() {
        return $.map(this.find('.FMulSelectBox-items'), function(v, k) {
            return $(v).attr('data-value');
        }).join('|');
    };
    $(function(){
        $.ajax({
            url: '{:yunurl("/api/index")}',
            type: 'POST',
            dataType: 'json',
            data: {
                api:'datadict',
                order: {
                    'sort': 'desc',
                },
                datadict: '{$_field.config.datadict}',
            },
            success:function(res){
                $('#{$_ns}').FMulSelect({
                    // width: 500,  // 宽度，默认自动
                    height: 'auto',  // 高度，默认30px
                    levels: {$_field.config.levels|default=3},   // 联动级别数量，默认 3级 ,可配置范围 1-n，理论上没有上限
                    data: res['rows'], // 数据源，json格式
                    // levelNames: ['请选择', '请选择', '请选择'],//每个级别的名称，如省市区
                    dataKeyNames: {  //配置数据源的key值 默认 id  name  child
                        "id": "id",
                        "name": "title",
                        "childs": "child"
                    }
                });
                $('#{$_ns}').FMulSelectSetVal([{$_field.value}]);
            }
        });
    });
</script>