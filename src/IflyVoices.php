<?php
/**
 * +----------------------------------------------------------------------
 * | 科大讯飞语音合成
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
 * 语音合成 WebAPI 接口调用示例 接口文档（必看）：https://doc.xfyun.cn/msc_android/%E8%AF%AD%E9%9F%B3%E5%90%88%E6%88%90.html
 * webapi 合成服务参考帖子：http://bbs.xfyun.cn/forum.php?mod=viewthread&tid=38997&extra=
 * webapi是单次只支持1000个字节，具体看您的编码格式，计算一下具体支持多少文字
 * 合成发音人自动添加获取测试权限使用方法：登陆开放平台https://www.xfyun.cn/后--我的应用（必须为webapi类型应用）--添加在线语音合成（已添加的不用添加）--发音人管理---添加发音人--测试代码里需修改发音人参数 
 *（Very Important）创建完webapi应用添加合成服务之后一定要设置ip白名单，找到控制台--我的应用--设置ip白名单，如何设置参考：http://bbs.xfyun.cn/forum.php?mod=viewthread&tid=41891
 * 错误码链接：https://www.xfyun.cn/document/error-code （code返回错误码时必看）
 * @author iflytek
 * 
 */
declare (strict_types = 1);

namespace duyun\yunsaas;

class IflyVoices 
{

	public static function tocurl($url, $header, $content){
		$ch = curl_init();
		if(substr($url,0,5)=='https'){
			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // 跳过证书检查
			curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, true);  // 从证书中检查SSL加密算法是否存在
		}
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($content));
		$response = curl_exec($ch);
		$error=curl_error($ch);
		//var_dump($error);
		if($error){
			die($error);
		}
		$header = curl_getinfo($ch);

		curl_close($ch);
		$data = array('header' => $header,'body' => $response);
		return $data;
	}
	/**
	 * [createvoice 合成语音]
	 * @param  [type] $a [生成路径]
	 * @param  [type] $b [传入文字内容]
	 * @return [type]    [description]
	 */
	public static function createvoice($a,$b='你好！世界') {
		// 合成webapi接口地址
		$url = 'http://api.xfyun.cn/v1/service/v1/tts';
		// 应用ID 必须为webapi类型应用，并开通语音合成服务,参考帖子如何创建一个webapi应用 http://bbs.xfyun.cn/forum.php?mod=viewthread&tid=36481
		$appid = '5ae5cd19';
		// 接口密钥 （webapi类型应用开通合成服务后，控制台--我的应用---语音合成---相应服务的apikey）
		$apikey = '3c9fc1fc043b17e03d2e73f9832d474c';
		// 音频编码（raw合成的音频格式pcm、wav,lame合成的音频格式MP3）发音人（控制台应用对应服务添加发音人之后查看参数）
		$param = array (
			'aue' => 'lame',
			'voice_name' => 'xiaoyan',/*xiaoyan*/
		);
		// 组装http请求头
		$time = (string)time();
		$xparam = base64_encode(json_encode(($param)));
		$checksum = md5($apikey.$time.$xparam);
		$header = array(
			'X-CurTime:'.$time,
			'X-Param:'.$xparam,
			'X-Appid:'.$appid,
			'X-CheckSum:'.$checksum,
			'X-Real-Ip:127.0.0.1',
			'Content-Type:application/x-www-form-urlencoded; charset=utf-8'
		);
		$content = array(
			'text' => $b,// webapi是单次只支持1000个字节，具体看您的编码格式，计算一下具体支持多少文字）
		);
		$response = self::tocurl($url, $header, $content);
		$header = $response['header'];
		if($header['content_type'] == 'audio/mpeg'){
			$filename = $a.'xfyuyin.mp3';
			$res = file_put_contents($filename, $response['body']);
		}else{
			$filename = $a.'xfyuyin.wav';
			$res = file_put_contents($filename, $response['body']);
		}
		return $filename;
	}
}