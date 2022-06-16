<?php
/**
 * +----------------------------------------------------------------------
 * | 万能表单
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
use think\facade\View;
trait Common
{
    use Forms;
    /**
     * [clear 删除目录下文件及目录]
     * @param  [type] $path [目录路径]
     * @return [type]       [description]
     */
    protected function clear(string $path, bool $rmdir): void
    {
        $files = is_dir($path) ? scandir($path) : [];
        foreach ($files as $file) {
            if ('.' != $file && '..' != $file && is_dir($path . $file)) {
                $this->clear($path . $file .DIRECTORY_SEPARATOR,true);
                if ($rmdir) @rmdir($path . $file.DIRECTORY_SEPARATOR);
            } elseif ('.gitignore' != $file && is_file($path . $file)) {
                unlink($path . $file);
            }
        }
    }
    /**
     * [modeldata 获取模型数据]
     * @return array 数据数组
     */
    protected function modeldata(array $input)
    {
        $method  = (isset($input['method']) && !empty($input['method']))?$input['method']:'getPaginate';
        $app  = (isset($input['app']) && !empty($input['app']))?$input['app']:$this->request::app();
        $model = '\\app\\'.trim(str_replace('/', '\\', $app)).'\\model\\' . trim($input['model']??'');
        if (!class_exists($model)) $this->error('参数错误');
        $result = $model::$method(searchcriteria($input['where']??[]), $this->request::post('rows/d',20), $input['order']??[]);
        if(isset($result['data']) && !empty($result['data'])){
            $result['rows'] = $result['data'];
            unset($result['data']);
        }
        return $result;
    }
    /**
     * [fetchform 表单输出]
     * @param  array  $data   表单字段数组
     * @param  array  $config 配置信息
     * @return object         对象
     */
    protected function fetchform($data = [], array $config = [])
    {
        $form = $this->getform($data, $config);
        $form['_data'] = $data;
        $this->assign($form);
        return View::fetch(yun_decrypt('Z64kDdP6ip0gy8BLrUw9ILwEAl6ELRwQgmSrnedHTcGxNhljA6v/MpTbbDgIT32ldA8lB0nNcb8='));
    }
    /**
     * [yunadd 通用添加]
     * @param  array  $config 配置信息
     * @param  array  $input  参数
     * @return [type]         [description]
     */
    protected function yunadd($config = [] ,$input = [])
    {
        if ($this->request::isPost()) {
            $config['module'] = isset($config['module']) ? $config['module'] : $this->request::app();
            $config['model'] = isset($config['model']) ? $config['model'] : ucfirst(getApp($this->request::pathinfo()));
            $model = '\app\\'.$config['module'].'\model\\' . $config['model'];
            if (!class_exists($model)) $this->error('参数错误');
            $validate = 'app\\'.$config['module'].'\validate\\' . $config['model'];
            if (!class_exists($validate)) $this->error('参数错误');
            $result = $this->validate($input, $validate.'.'.$config['validate_scene']??'add');
            if (true === $result) {
                return $model::addPost($model,$input,$config);
            }
        }
    }
    /**
     * [yunedit 通用编辑]
     * @param  array  $config 配置信息
     * @param  array  $input  参数
     * @param  boolean $back  是否返回ID
     * @return [type]          [description]
     */
    protected function yunedit($config = [],$input = [], $back = false)
    {
        $id = isset($config['id']) ? $config['id'] : input('id');
        $config['module'] = isset($config['module']) ? $config['module'] : $this->request::app();
        $config['model'] = isset($config['model']) ? $config['model'] : ucfirst(getApp($this->request::pathinfo()));
        $model = '\app\\'.$config['module'].'\model\\' . $config['model'];
        if (!class_exists($model)) $this->error('参数错误');
        $data = $model::getOne([['id','=',$id]]);
        if ($this->request::isGet()) {
            return $this->fetchform($data,$config);
        } else if ($this->request::isPost()) {
            if (true != session('user.super_admin') && $data['locked']) $this->error('锁定的数据可解锁后修改！');
            $input = (empty($input)) ? $this->request::post() : $input ;
            $validate = 'app\\'.$config['module'].'\validate\\' . $config['model'];
            if (!class_exists($validate)) $this->error('参数错误');
            $result = $this->validate($input, $validate.'.'.$config['validate_scene']??'edit');
            if (true === $result) {
                $config['id'] = $id;
                return $model::editPost($model,$input,$config);
            }
        }
    }

    /**
     * [yundel 通用关联删除]
     * @param  array  $config [配置]
     * @param  array  $data   [参数]
     * @return [type]         [description]
     */
    protected function yundel($data = [],$config = [])
    {
        if (isset($data['ids'])) $ids = explode(',', $data['ids']);
        if ($ids) {
            $config['module'] = isset($config['module']) ? $config['module'] : $this->request::app();
            $config['model'] = isset($config['model']) ? $config['model'] : ucfirst(getApp($this->request::pathinfo()));
            $model = '\app\\'.$config['module'].'\model\\' . $config['model'];
            if (!class_exists($model)) $this->error('参数错误');
            $res = $model::del($model,$ids,$config);
            if (false !== $res) $this->success('删除成功！');
        }
        $this->error('删除失败,数据可能被锁定！');
    }

    /**
     * [yunstatus 通用审核]
     * @param  array  $config [description]
     * @return [type]         [description]
     */
    protected function yunstatus($config = [])
    {
        if (!isset($config['ids'])) $this->error('参数错误！');
        if (!isset($config['value'])) $this->error('参数错误！');
        $ids = explode(',', $config['ids']);
        $value = (int)$config['value'];
        if (empty($ids)) $this->error('请选择要 操作 的数据！');
        $this->yunfield($ids, 'status', $value, $config);
    }

    /**
     * [yunsort 通用排序]
     * @param  array  $config 配置参数
     * @return [type]         [description]
     */
    protected function yunsort($config = [])
    {
        if (!isset($config['ids'])) $this->error('参数错误！');
        if (!isset($config['value'])) $this->error('参数错误！');
        $ids = explode(',', $config['ids']);
        $value = (int)$config['value'];
        if (empty($ids)) $this->error('请选择要 操作 的数据！');
        $this->yunfield($ids, 'sort', $value, $config);
    }
    /**
     * [yunlock 通用锁定]
     * @param  array  $config 配置参数
     * @return [type]         [description]
     */
    protected function yunlock($config = [])
    {
        if (!isset($config['ids'])) $this->error('参数错误！');
        if (!isset($config['value'])) $this->error('参数错误！');
        $ids = explode(',', $config['ids']);
        $value = (int)$config['value'];
        if (empty($ids)) $this->error('请选择要 操作 的数据！');
        $this->yunfield($ids, 'locked', $value, $config);
    }
    /**
     * 此方法数组与单项都可以操作
     * @param  $ids array 提交的id
     * @param  $field  表字段
     * @param  $value  字段值
     */
    protected function yunfield($ids, $field, $value, $config = [])
    {
        $config['module'] = isset($config['module']) ? $config['module'] : $this->request::app();
        $config['model'] = isset($config['model']) ? $config['model'] : ucfirst(getApp($this->request::pathinfo()));
        $model = '\app\\'.$config['module'].'\model\\' . $config['model'];
        if (!class_exists($model)) $this->error('参数错误');
        $where = [['id','in', $ids]];
        /*排除锁定项  超级管理员不限制*/
        if (!session('user.super_admin') && $field!='locked') $where[] = ['locked','=',0];
        $num = $model::where($where)->update([$field => $value]);
        if (0 === $num) $this->error('操作失败,可能无权限或数据被锁定！');
        if ($num>0) $this->success('操作成功！');
    }
    /**
     * [__call 空控制器]
     * @param  [string] $method [方法]
     * @param  [array] $args   [参数]
     * @return [type]         [description]
     */
    public function __call($method, $args)
    {
        switch ($method) {
            case 'add':
                if ($this->request::isGet()) {
                    return $this->fetchform();
                } elseif ($this->request::isPost()) {
                    return $this->yunadd();
                }
                break;

            case 'edit':
                return $this->yunedit(['validate_scene' => 'edit']);
                break;

            // 排序
            case 'resort':
                if ($this->request::isGet()) {
                    // $this -> fetchform();
                } elseif ($this->request::isPost()) {
                    return $this->yunsort($args);
                }
                break;

            // 删除
            case 'delete':
                return $this->yundel($args);
                break;

            // 审核
            case 'status':
                return $this->yunstatus($args);
                break;

            // 锁定
            case 'lock':
                return $this->yunlock($args);
                break;

            default:
                $this->error('错误请求！');
                break;
        }
    }

    private function get_point_value($data = [], string $str = '')
    {
        $pos = strpos($str, '.');
        if (false === $pos) {
            return isset($data[$str]) ? $data[$str] : false;
        } else {
            $key = mb_substr($str, 0, $pos);
            if (isset($data[$key])) {
                return $this->get_point_value($data[$key], mb_substr($str, $pos + 1));
            } else {
                return false;
            }
        }
    }
    /**
     * 用于下拉列表,返回一个array，每一个层级前面递增一个-
     * 作者 qq:987772927
     * @param  unknown 种子
     * @param  number 起始父id
     */
    public function selectTree($param,$title = 'text', $pid = 0, $lvl = 0)
    {

        static $res = [];
        foreach ($param as $key => $vo) {
            if ($pid == $vo['pid']) {
                foreach (explode(',', $title) as $key => $value) {
                    if (isset($vo[$value])) {
                        $vo[$value] = str_repeat('&nbsp;&nbsp;&nbsp;&nbsp;', $lvl) . '&nbsp;&nbsp;&nbsp;&nbsp;┣' . $vo[$value];
                    }
                }
                $res[] = $vo;
                $temp = $lvl + 1;
                $this->selectTree($param,$title,$vo['id'], $temp);
            }
        }
        return $res;
    }
    /**
     * [ArrTree 将数据按照所属关系封装 tree树形结构 ]
     * @param array  $data [数组]
     * @param string  $field  [要获取的字段值]
     * @param integer  $pid  [description]
     * @param integer $deep [description]
    */
    public function ArrTree($data,$field = 'id',$pid=1,$deep=0) {
        $tree=[];
        foreach ($data as $row) {
           if($row['pid']==$pid){
                $tree[]=[
                    'id' => $row['id'],
                    'pid' => $row['pid'],
                    'title' => $row['title'],
                    'value' => $row[$field],
                    'child' => $this->ArrTree($data,$field,$row['id'],$deep+1),
                    'deep' => $deep,
                ];
           }
        }
        return $tree;
    }
    public function Keywords($tit='',$con='',$nu='15')
    {
        $ch = curl_init();
        $url = 'http://apis.baidu.com/xlongwei/open/keywords';
        $header = array(
            'Content-Type:application/x-www-form-urlencoded',
            'apikey: a0a437f18d30966bb475b94f5c0c5bc6',
        );
        $data = "title=".$tit."&content=".$con."&num=".$nu;
        // 添加apikey到header
        curl_setopt($ch, CURLOPT_HTTPHEADER  , $header);
        // 添加参数
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        // 执行HTTP请求
        curl_setopt($ch , CURLOPT_URL , $url);
        $res = curl_exec($ch);

        return($res);
    }
}
