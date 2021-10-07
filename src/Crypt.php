<?php
/**
 * +----------------------------------------------------------------------
 * | 加解密
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
use phpseclib\Crypt\DES;
class Crypt
{

    public static function encode($data, $key='yuncms', $expire = 0)
    {
        $Crypt = new DES();
        $Crypt->setKey(md5($key));
        // if ((int)$expire) {
        //     $expire = (int)$expire + time();
        //     $data = $expire . '_' . serialize($data);
        // }else{
            $data = '0_' . serialize($data);
        // }
        return str_replace('+', 'Yuncms', base64_encode($Crypt->encrypt($data)));
    }

    public static function decode($data, $key='yuncms')
    {
        $Crypt = new DES();
        $Crypt->setKey(md5($key));
        $str = $Crypt->decrypt(base64_decode(str_replace('Yuncms', '+', $data))?:0);
        $pos = mb_strpos($str, '_');
        $expire = (int)mb_substr($str, 0, $pos);
        if ($expire == 0 || $expire > time()) {
            return unserialize(mb_substr($str, $pos + 1));
        }
        return false;
    }

}