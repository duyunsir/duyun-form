<?php
/**
 * +----------------------------------------------------------------------
 * | 数据库配置
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
use think\facade\Cache;
use think\facade\Env;
use think\facade\Db;
class DbConfig
{

    public static function get($name)
    {
        static $config;
        if (!$config) $config = self::config();
        $name = strtolower($name);
        return self::get_point_value($config, $name);
    }
    public static function config($refresh = false)
    {
        if ($refresh || !$config = Cache::get(env('app_key',str_replace(['http://','https://','.'],'',request()->domain())).'config')) {
            $config = self::build();
            Cache::set(env('app_key',str_replace(['http://','https://','.'],'',request()->domain())).'config', $config);
        }
        return $config;
    }

    private static function build()
    {
        $confcates = Db::name('configcate')->where('name !=""')->column('name', 'id');
        $tmp = Db::name('config')->where(array('status' => array('eq', 1)))->order('sort desc')->column('category_id,pid,name,value,render', 'id');
        $confs = array();
        foreach ($tmp as $key => $value) {
            $value['value'] = self::render_str(htmlspecialchars_decode($value['value']));
            $confs[$value['category_id']][] = $value;
        }
        $res = [];
        foreach ($confcates as $k => $v) {
            if (isset($confs[$k])) {
                $res[strtolower($v)] = self::config_level_merge(0, $confs[$k]);
            }
        }
        return $res;
    }

    private static function render_str($data)
    {
        preg_match_all('/{{([\s\S]*?)}}/', $data, $mat);
        $unfunc = ['phpinfo', 'eval', 'file_put_contents', 'exec', 'shell_exec', 'system', 'proc_open', 'popen', 'curl_exec', 'curl_multi_exec', 'parse_ini_file', 'show_source', 'think', 'yuncms', 'vendor'];
        foreach ($mat[1] as $key => $value) {
            $flag = false;
            foreach ($unfunc as $k => $fun) {
                if (false !== stripos($value, $fun)) {
                    $flag = true;
                }
            }
            if (!$flag) {
                eval('$__m = ' . $value . ';');
                $data = str_replace($mat[0][$key], $__m, $data);
            }
        }
        return $data;
    }

    // 配置文件递归
    private static function config_level_merge(int $pid = 0, array $config = [])
    {
        $data = array();
        foreach ($config as $key => $value) {
            if ($value['pid'] == $pid) {
                unset($config[$key]);
                if ($tmp = self::config_level_merge($value['id'], $config)) {
                    $data[strtolower($value['name'])] = $tmp;
                } else {
                    $data[strtolower($value['name'])] = self::render_config($value['value'], $value['render']);
                }
            }
        }
        return $data ?: '';
    }

    // 根据类型解析配置文档
    private static function render_config($data, $render)
    {
        switch ($render) {
            case 'string':
                $tmp = $data;
                break;
            case 'number':
                $tmp = (int)$data;
                break;
            case 'bool':
                $tmp = (boolean)$data;
                break;
            case 'float':
                $tmp = (float)$data;
                break;
            case 'item':
                $tmp = explode("\r\n", $data);
                break;
            case 'json':
                $tmp = json_decode(preg_replace("/\/\*[\s\S]+?\*\//", "", $data), true);
                break;
            case 'ini':
                $tmp = parse_ini_string($data);
                break;
            case 'yaml':
                $tmp = yaml_parse($data);
                break;
            case 'xml':
                $tmp = (array)simplexml_load_string($data);
                break;

            default:
                $tmp = '';
                break;
        }
        return $tmp;
    }

    // 获取数组中点语法的值
    private static function get_point_value(array $data = [], string $str = '')
    {
        $pos = strpos($str, '.');
        if (false === $pos) {
            return isset($data[$str]) ? $data[$str] : false;
        } else {
            $key = mb_substr($str, 0, $pos);
            if (isset($data[$key])) {
                return self::get_point_value($data[$key], mb_substr($str, $pos + 1));
            } else {
                return false;
            }
        }
    }

}