<?php
/**
 * +----------------------------------------------------------------------
 * | 位置信息
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

class Position
{

    // 位置信息
    protected static $positions = [];

    public static function add($position)
    {
        if (!self::$positions) {
            array_push(self::$positions, ['title' => '首页', 'url' => url('index/index/index')]);
        }
        array_push(self::$positions, $position);
    }

    public static function get()
    {
        if (!self::$positions) {
            array_push(self::$positions, ['title' => '首页', 'url' => url('index/index/index')]);
        }
        return self::$positions;
    }

    public static function getLast()
    {
        if (!self::$positions) {
            array_push(self::$positions, ['title' => '首页', 'url' => url('index/index/index')]);
        }
        return end(self::$positions);
    }

}