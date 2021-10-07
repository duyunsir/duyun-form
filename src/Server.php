<?php
/**
 * +----------------------------------------------------------------------
 * | 服务
 * +----------------------------------------------------------------------
 *                      _ooOoo_
 *                     o8888888o            | AUTHOR: 杜云
 *                     88" . "88            | EMAIL: 987772927@qq.com
 *                     (| -_- |)            | QQ: 987772927
 *                     O\  =  /O            | WECHAT: duyun202011
 *                  ____/`---'\____
 *                .'  \\|     |//  `.
 *               /  \\|||  :  |||//  \
 *              /  _||||| -:- |||||-  \
 *              |   | \\\  -  /// |   |
 *              | \_|  ''\-/''  |   |
 *              \  .-\__  `-`  ___/-. /
 *            ___`. .'  /-.-\  `. . __
 *         ."" '<  `.___\_<|>_/___.'  >'"".
 *        | | :  `- \`.;`\ _ /`;.`/ - ` : | |
 *        \  \ `-.   \_ __\ /__ _/   .-` /  /
 *   ======`-.____`-.___\_____/___.-`____.-'======
 *                      `=-='
 * +----------------------------------------------------------------------
 */
declare (strict_types = 1);

namespace duyun\yunsaas;
use DbConfig;
use think\Config;
class Server
{

    private static $config;

    // 初始化
    public static function init()
    {
        return self::$config = DbConfig::get('system.');
    }

    public static function api($name, $param)
    {
        !empty(self::$config) || self::init();
        $config = self::$config;
        $param['api'] = $name;
        $salt = md5(substr(Config::get('safe_code'), 6) . time());
        $param['_auth'] = json_encode([
            'appid' => $config['appid'],
            'salt' => $salt,
            'authstr' => md5($config['appsecret'] . $salt),
            'from' => request()->root(true),
        ]);
        $res = Curl::post('https://yuncms.yunmeitiweb.com/server/api/index', $param);
        $res = json_decode($res, true);
        return $res;
    }
}