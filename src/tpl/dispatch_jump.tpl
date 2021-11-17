<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <title>YunSaas云端管理系统</title>

    <meta name="keywords" content="YunSaas云端管理系统">
    <meta name="description" content="YunSaas云端管理系统">
    <link rel="shortcut icon" href="/favicon.ico">
    <link href="/static/resource/css/bootstrap.min.css?v=3.3.5" rel="stylesheet">
    <link href="/static/resource/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="/static/resource/css/animate.min.css" rel="stylesheet">
    <link href="/static/resource/css/style.min.css?v=4.0.0" rel="stylesheet">
</head>

<body class="gray-bg">
    <div class="middle-box text-center animated fadeInDown">
        <?php switch ($code) {?>
            <?php case 1:?>
            <h1><i class="fa fa-smile-o" aria-hidden="true"></i></h1>
            <?php break;?>
            <?php case 0:?>
            <h1><i class="fa fa-frown-o" aria-hidden="true"></i></h1>
            <?php break;?>
        <?php } ?>
        <h3 class="font-bold"><?php echo(strip_tags($msg));?></h3>
        <div class="error-desc">
            感谢使用本系统，具体业务可联系工程师
            <br/>工程师QQ或微信：987772927
            <?php if(!empty($url)):?>
            <br/>页面自动 <a id="href" onclick="jump()">跳转</a> 等待时间： <b id="wait"><?php echo($wait);?></b>
            <script type="text/javascript">
                (function(){
                    var wait = document.getElementById('wait');
                    var interval = setInterval(function(){
                        var time = --wait.innerHTML;
                        if(time <= 0) {
                            top.location.href = "<?php echo($url);?>";
                            clearInterval(interval);
                        };
                    }, 1000);
                })();
                function jump() {
                    top.location.href = "<?php echo($url);?>";
                }
            </script>
            <?php endif;?>
            <!-- <br/><a href="index-2.html" class="btn btn-primary m-t">主页</a> -->
        </div>
    </div>
    <script src="/static/resource/js/jquery.min.js?v=2.1.4"></script>
    <script src="/static/resource/js/bootstrap.min.js?v=3.3.6"></script>
</body>
</html>

