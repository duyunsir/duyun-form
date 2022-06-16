{include file="../vendor/duyun/yunsaas/src/common/header.tpl" /}
</head>
<body class="gray-bg">
    <div class="middle-box text-center animate__animated animate__fadeInDown">
        <?php switch ($code) {?>
            <?php case 1:?>
            <h1><i class="far fa-smile"></i></h1>
            <?php break;?>
            <?php case 0 || 401:?>
            <h1><i class="far fa-frown"></i></h1>
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

