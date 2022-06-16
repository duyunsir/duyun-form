{php}$namespace = ns();{/php}
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
    <link href="{$Public}css/bootstrap.min.css?v=3.4.1" rel="stylesheet">
    <link href="{$Public}css/style.min.css?v=4.0.0" rel="stylesheet">
    <link rel="stylesheet" href="{$Public}fontawesome/css/all.min.css"/>
    <!-- <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>-->
    <link href="{$Public}css/animate.min.css" rel="stylesheet">
    <script src="{$Public}js/jquery.min.js?v=2.1.4"></script>
    <script>
        window.onerror=function(){return true;}/*忽略js报错*/
        Yunspace.register("YunCms.{$namespace}");
        Yun = YunCms.{$namespace };
    </script>
    <script src="{$Public}js/bootstrap.min.js?v=3.3.5"></script>
    <script src="{$Public}js/content.min.js?v=1.0.0"></script>
    <script src="{$Public}js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="{$Public}js/plugins/layer/layer.js"></script>
    <script src="{$Public}js/yuncms.js?v=1.1.0"></script>
    <!-- <script src="{$Public}js/plugins/sweetalert/sweetalert.min.js"></script> -->
    <!-- <script src="{$Public}js/plugins/party/party.min.js"></script> -->
    <script>
  //    party.settings.debug = false;
        // document.body.addEventListener("click", function (e) {
        //     e.preventDefault();
        //     party.confetti(e);
        // });
        // document.body.addEventListener("contextmenu", function (e) {
        //     e.preventDefault();
        //     party.sparkles(e);
        // });
    </script>