<?php
namespace app\index\validate;
use think\Validate;
class Reply extends Validate
{
    protected $rule = [
        'username'  =>  'require|max:25',
        'content' =>'require|max:1000',
    ];
    protected $message = [
        'username.require' => '名称不能为空',
        'username.max'     => '名称不能多于25个字符',
        'content.require' => '内容不能为空',
        'content.max'     => '内容不能多于1000个字符',
    ];
}