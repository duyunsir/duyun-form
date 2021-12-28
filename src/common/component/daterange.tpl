<!-- 时间区间 -->
<link rel="stylesheet" type="text/css" href="{$Public}css/plugins/daterangepicker/daterangepicker.css"/>
<style type="text/css">.daterangepicker .ranges ul {width: 100px;}</style>
<div class="input-group date">
    <span class="input-group-addon" style="width: 8%;padding: 8px 12px;"><i class="fa fa-calendar"></i></span>
    <input style="margin-top: 0;" type="text" class="form-control help-block m-b-none" name="{$_field.field}" id="{$_ns}" value="{$_field.value}" {if condition='$_field.config.disabled eq 1'} disabled {/if} {if condition='$_field.config.readonly eq 1'} readonly {/if}{if condition='$_field.config.required eq 1'} required {/if}>
</div>
<script type="text/javascript" src="{$Public}js/plugins/daterangepicker/moment.min.js"></script>
<script type="text/javascript" src="{$Public}js/plugins/daterangepicker/daterangepicker.js"></script>
<script>
    $(function () {
        var picker = {
            locale: {
                "format": 'YYYY-MM-DD',
                "separator": " 到 ",
                "applyLabel": "确定",
                "cancelLabel": "取消",
                "fromLabel": "起始时间",
                "toLabel": "结束时间'",
                "customRangeLabel": "自定义",
                "weekLabel": "W",
                "daysOfWeek": ["日", "一", "二", "三", "四", "五", "六"],
                "monthNames": ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
                "firstDay": 1
            },
            ranges: {
                '今日': [moment(), moment()],
                '昨日': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                '最近7日': [moment().subtract(6, 'days'), moment()],
                '最近30日': [moment().subtract(29, 'days'), moment()],
                '本月': [moment().startOf('month'), moment().endOf('month')],
                '上月': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month')
                    .endOf('month')
                ]
            },
            alwaysShowCalendars: true,
            startDate: moment().startOf('month'),
            endDate: moment().endOf('month'),
            opens: "right",
        }
        switch({$_field.config.timeparameter|default=0}){
            case 1:
                picker.locale.format = 'YYYY-MM-DD hh:mm';
                picker.timePicker = true;
                break;
        }
        $('#{$_ns}').daterangepicker(picker, function (start, end, label) {
            console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
        });
    })
</script>