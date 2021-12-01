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
use think\facade\Route;
use think\helper\Str;
trait Forms
{
    /**
     * [getform 返回表单]
     * @param  array  $data   字段数据信息
     * @param  array  $config 配置信息
     * @return array|json     返回生成的表单数据
     */
    protected function getform($data = [], array $config = [])
    {
        $res = [];
        $Model = yun_decrypt('95PLmxbJPISzSx9DTspi0pPCXD0afkKOtyPkC/e8fIWlcFBU3SJq5w==');
        $config['formname'] = $config['formname'] ?? str_replace(['/','\\'],'_', implode('',array_slice(explode('.', $this->request::pathinfo()), 0, 1)));
        $config['action'] = $config['action'] ?? implode('',array_slice(explode('.', $this->request::pathinfo()), 0, 1));
        $_where = [['status','=',1],['name','=',$config['formname']]];
        if ($form = $Model::getOne($_where)) {
            $groups = [];$extensions = [];
            foreach ($this->ArrTree(\app\backstage\model\Datadict::getList([['category_id','=',4],['status','=',1]]),'value',0) as $e => $u) $extensions[$u['value']] = implode(',', array_column($u['child'], 'value'))?:yun_decrypt('9eGPYYuncmsYWAqd89FMGziadLkwRmLeeWZzt');
            $_fields = $Model::getList([['status','=',1],['category_id','=', $form['id']]]);
            foreach ($_fields as $key => $value) {
                // 字段配置
                $tmp = [
                    'id'=>$value['id'],
                    'config'=>$value['config'],
                    'title'=>$value['title'],
                    'remark'=>$value['remark'],
                    'type'=>substr($value['type'], 5)
                ];
                // 字段名称
                if ($value['subtable'] && $value['extfield']) {
                    $tmp['field'] = $value['subtable'] . '[' . $value['extfield'] . ']' . '[' . $value['name'] . ']';
                } elseif ($value['extfield']) {
                    $tmp['field'] = $value['extfield'] . '[' . $value['name'] . ']';
                } elseif ($value['subtable']) {
                    $tmp['field'] = $value['subtable'] . '[' . $value['name'] . ']';
                } else {
                    $tmp['field'] = $value['name'];
                }
                // 字段值
                switch ($value['defaultvaluetype']){
                    case '0':
                        $tmp['value'] = $value['defaultvalue'];
                        break;

                    case '1':
                        $tmp['value'] = input($value['defaultvalue']);
                        break;

                    case '2':
                        $tmp['value'] = config($value['defaultvalue']);
                        break;

                    case '3':
                        if ($value['subtable'] && $value['extfield']) {
                            $_value = $data[$value['subtable']][$value['extfield']];
                        } elseif ($value['extfield']) {
                            $_value = $data[$value['extfield']];
                        } elseif ($value['subtable']) {
                            $_value = $data[$value['subtable']];
                        } else {
                            $_value = $data;
                        }
                        $tmp['value'] = $this->get_point_value($_value, $value['defaultvalue']);
                        break;
                    default:
                        $tmp['value'] = $value['defaultvalue'];
                        break;
                }
                if('files' == $tmp['type'] && isset($tmp['config']['accept']) && isset($extensions[$tmp['config']['accept']])){
                    $tmp['config']['extensions'] = $extensions[$tmp['config']['accept']];
                    switch (DbConfig::get('system.upload_storage')){
                        case 'local':
                            $tmp['config']['uploadUrl'] = yunurl("/upload/index");
                            $tmp['config']['formData'] = json_encode([
                                'token' => '',
                                'fid' => $tmp['id'],
                                'uploadtype' => DbConfig::get('system.upload_storage'),
                            ]);
                            $tmp['config']['chunked'] = 'true';
                            break;
                        case 'qiniu':
                            try {
                                $Qn = new \Qiniu\Config();
                                $Qn->useHTTPS = ('https' == $this->request::scheme())?true:false;
                                $tmp['config']['uploadUrl'] = $Qn->getUpHost(config('filesystem.disks.qiniu.accessKey'),config('filesystem.disks.qiniu.bucket'));
                                $tmp['config']['formData'] = json_encode([
                                    'token' => (new \Qiniu\Auth(config('filesystem.disks.qiniu.accessKey'), config('filesystem.disks.qiniu.secretKey')))->uploadToken(config('filesystem.disks.qiniu.bucket')),
                                    'fid' => $tmp['id'],
                                    'uploadtype' => DbConfig::get('system.upload_storage'),
                                ]);
                                $tmp['config']['chunked'] = 'true';
                            }catch(\Exception $e) {
                                $this->error('请配置七牛云上传信息');
                            }
                            break;
                        case 'alioss':
                            if (!config('filesystem.disks.alioss.bucket') || !config('filesystem.disks.alioss.endpoint')) $this->error('请配置阿里云上传信息');
                            $dir = str_replace('\\', '/', config('filesystem.disks.alioss.dir'));
                            $expire = 60;  //设置该policy超时时间是10s. 即这个policy过了这个有效时间，将不能访问。
                            $end = time()+ 8*3600 + $expire;
                            // $callbackUrl为上传回调服务器的URL，请将下面的IP和Port配置为您自己的真实URL信息。
                            $callback_param = [
                                'callbackUrl'       => $this->request::domain().'/manage/alioss',
                                'callbackBody'      => 'filename=${object}&id=${x:id}&name=${x:name}&uploadtype=alioss&etag=${etag}&size=${size}&type=${mimeType}&height=${imageInfo.height}&width=${imageInfo.width}',
                                'callbackBodyType'  => "application/x-www-form-urlencoded"
                            ];
                            $conditions = [
                                [0 => 'content-length-range', 1 => 0, 2 => ($tmp['config']['max_size']??4)*1024*1024],/*最大文件大小.用户可以自己设置*/
                                [0 => 'starts-with', 1 => '$key', 2 => $dir],/*表示用户上传的数据，必须是以$dir开始，不然上传会失败，这一步不是必须项，只是为了安全起见，防止用户通过policy上传到别人的目录。*/
                            ];
                            $policy = ['expiration' => str_replace('+00:00', '.000Z', gmdate(DATE_ATOM, $end)), 'conditions' => $conditions];
                            $tmp['config']['uploadUrl'] = 'https://'.config('filesystem.disks.alioss.bucket').'.'.config('filesystem.disks.alioss.endpoint');
                            $tmp['config']['formData'] = json_encode([
                                'token'         => '',
                                'fid'           => $tmp['id'],
                                'uploadtype'    => DbConfig::get('system.upload_storage'),
                                'key'           => $dir.date('YmdHis').md5(Str::random($length = 16)),
                                'policy'        => base64_encode(json_encode($policy)),
                                'OSSAccessKeyId'=> config('filesystem.disks.alioss.access_id'),
                                'callback'      => base64_encode(json_encode($callback_param)),
                                'signature'     => base64_encode(hash_hmac('sha1', base64_encode(json_encode($policy)), config('filesystem.disks.alioss.access_key'), true))
                            ]);
                            break;
                    }
                }
                $groups[$value['group']][$value['id']] = $tmp;
            }
            $Ext = yun_decrypt('mJanpJRT6eYuncmsWqtfiIqTHPayiqkjgFKdIEkUvrZIDtHqkSWoeM8o4t8Pgog4SRk8J');
            // 扩展字段
            if (isset($config['ext_id']) && $config['ext_id']) {
                $_where = [['category_id','=', $config['ext_id']],['status','=', 1],];
                if ($extfields = $Ext::getList($_where,true,['sort' => 'desc','id' => 'asc'])) {
                    // $extgroups = [];
                    foreach ($extfields as $key => $extfield) {
                        // 字段配置
                        $tmp = [
                            'id'=>$extfield['id'],
                            'config'=>$extfield['config'],
                            'title'=>$extfield['title'],
                            'remark'=>$extfield['remark'],
                            'type'=>substr($extfield['type'], 5)
                        ];
                        // 字段名称
                        if (isset($config['ext_table']) && $config['ext_table']) {
                            $tmp['field'] = $config['ext_table'] . '[ext]' . '[' . $extfield['name'] . ']';
                        } else {
                            $tmp['field'] = 'ext[' . $extfield['name'] . ']';
                        }
                        // 字段值
                        $tmp['value'] = '';
                        if ($data) {
                            if (isset($config['ext_table']) && $config['ext_table']) {
                                $_value = $data[$config['ext_table']]['ext'];
                                $tmp['value'] = isset($_value[$extfield['name']]) ? $_value[$extfield['name']] : $extfield['value'];
                            } elseif (isset($data['ext'])) {
                                $_value = $data['ext'];
                                $tmp['value'] = isset($_value[$extfield['name']]) ? $_value[$extfield['name']] : $extfield['value'];
                            }
                        }
                        if('files' == $tmp['type'] && isset($tmp['config']['accept']) && isset($extensions[$tmp['config']['accept']])){
                            $Resources = \app\backstage\model\Resources::getList([['id','=',$tmp['value']]],['id','url','type','storage']);
                            $tmp['value'] = (!$Resources)?[]:$Resources->toArray();
                            $tmp['config']['extensions'] = $extensions[$tmp['config']['accept']];
                            switch (DbConfig::get('system.upload_storage')){
                                case 'local':
                                    $tmp['config']['uploadUrl'] = yunurl("/upload/index");
                                    $tmp['config']['formData'] = json_encode([
                                        'token' => '',
                                        'fid' => $tmp['id'],
                                        'uploadtype' => DbConfig::get('system.upload_storage'),
                                    ]);
                                    $tmp['config']['chunked'] = 'true';
                                    break;
                                case 'qiniu':
                                    try {
                                        $Qn = new \Qiniu\Config();
                                        $Qn->useHTTPS = ('https' == $this->request::scheme())?true:false;
                                        $tmp['config']['uploadUrl'] = $Qn->getUpHost(config('filesystem.disks.qiniu.accessKey'),config('filesystem.disks.qiniu.bucket'));
                                        $tmp['config']['formData'] = json_encode([
                                            'token' => (new \Qiniu\Auth(config('filesystem.disks.qiniu.accessKey'), config('filesystem.disks.qiniu.secretKey')))->uploadToken(config('filesystem.disks.qiniu.bucket')),
                                            'fid' => $tmp['id'],
                                            'uploadtype' => DbConfig::get('system.upload_storage'),
                                        ]);
                                        $tmp['config']['chunked'] = 'true';
                                    }catch(\Exception $e) {
                                        $this->error('请配置七牛云上传信息');
                                    }
                                    break;
                                case 'alioss':
                                    if (!config('filesystem.disks.alioss.bucket') || !config('filesystem.disks.alioss.endpoint')) $this->error('请配置阿里云上传信息');
                                    $dir = str_replace('\\', '/', config('filesystem.disks.alioss.dir'));
                                    $expire = 60;  //设置该policy超时时间是10s. 即这个policy过了这个有效时间，将不能访问。
                                    $end = time()+ 8*3600 + $expire;
                                    // $callbackUrl为上传回调服务器的URL，请将下面的IP和Port配置为您自己的真实URL信息。
                                    $callback_param = [
                                        'callbackUrl'       => $this->request::domain().'/manage/alioss',
                                        'callbackBody'      => 'filename=${object}&id=${x:id}&name=${x:name}&uploadtype=alioss&etag=${etag}&size=${size}&type=${mimeType}&height=${imageInfo.height}&width=${imageInfo.width}',
                                        'callbackBodyType'  => "application/x-www-form-urlencoded"
                                    ];
                                    $conditions = [
                                        [0 => 'content-length-range', 1 => 0, 2 => ($tmp['config']['max_size']??4)*1024*1024],/*最大文件大小.用户可以自己设置*/
                                        [0 => 'starts-with', 1 => '$key', 2 => $dir],/*表示用户上传的数据，必须是以$dir开始，不然上传会失败，这一步不是必须项，只是为了安全起见，防止用户通过policy上传到别人的目录。*/
                                    ];
                                    $policy = ['expiration' => str_replace('+00:00', '.000Z', gmdate(DATE_ATOM, $end)), 'conditions' => $conditions];
                                    $tmp['config']['uploadUrl'] = 'https://'.config('filesystem.disks.alioss.bucket').'.'.config('filesystem.disks.alioss.endpoint');
                                    $tmp['config']['formData'] = json_encode([
                                        'token'         => '',
                                        'fid'           => $tmp['id'],
                                        'uploadtype'    => DbConfig::get('system.upload_storage'),
                                        'key'           => $dir.date('YmdHis').md5(Str::random($length = 16)),
                                        'policy'        => base64_encode(json_encode($policy)),
                                        'OSSAccessKeyId'=> config('filesystem.disks.alioss.access_id'),
                                        'callback'      => base64_encode(json_encode($callback_param)),
                                        'signature'     => base64_encode(hash_hmac('sha1', base64_encode(json_encode($policy)), config('filesystem.disks.alioss.access_key'), true))
                                    ]);
                                    break;
                            }
                        }
                        $groups[$extfield['group']][$extfield['id']] = $tmp;
                    }
                    // $res['_extgroups'] = $extgroups;
                }
            } elseif (isset($config['single_ext_id']) && $config['single_ext_id']) {
                $_where = ['single_id' => ['eq', $config['single_ext_id']],'status' => ['eq', 1],];
                if ($extfields = $Ext::where($_where)->order('sort desc,id asc')->select()) {
                    // $extgroups = [];
                    foreach ($extfields as $key => $extfield) {
                        // 字段配置
                        $tmp = [
                            'id'=>$extfield['id'],
                            'config'=>$extfield['config'],
                            'title'=>$extfield['title'],
                            'remark'=>$extfield['remark'],
                            'type'=>substr($extfield['type'], 5)
                        ];
                        // 字段名称
                        if (isset($config['ext_table']) && $config['ext_table']) {
                            $tmp['field'] = $config['ext_table'] . '[ext]' . '[' . $extfield['name'] . ']';
                        } else {
                            $tmp['field'] = 'ext[' . $extfield['name'] . ']';
                        }
                        // 字段值
                        $tmp['value'] = '';
                        if ($data) {
                            if (isset($config['ext_table']) && $config['ext_table']) {
                                $_value = $data[$config['ext_table']]['ext'];
                                $tmp['value'] = isset($_value[$extfield['name']]) ? $_value[$extfield['name']] : $extfield['value'];
                            } elseif (isset($data['ext'])) {
                                $_value = $data['ext'];
                                $tmp['value'] = isset($_value[$extfield['name']]) ? $_value[$extfield['name']] : $extfield['value'];
                            }
                        }
                        $groups[$extfield['group']][$extfield['id']] = $tmp;
                    }
                    // $res['_extgroups'] = $extgroups;
                }
            }
            $form['action'] = (string) Route::buildUrl($config['action']);
            $form['formtime'] = time();
            $res['_form'] = $form;
            $res['_groups'] = $groups;
            if (input('__modal') == 1) {
                $res['__modal'] = 1;
            } else {
                $res['__modal'] = 0;
            }
            $res['namespace'] = ns();
            return $res;
        } else {
            $this->error('表单不存在或者配置错误！');
        }
    }
}
