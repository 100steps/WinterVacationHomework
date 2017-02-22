<?php
namespace app\admin\validate;
use think\Validate;
class Link extends Validate
{
    protected $rule = [
        'title'  =>  'require|max:25|unique:link',
        'desc' =>'require',
        'url' =>'url',
    ];
    protected $message = [
        'title.unique' => '友情链接不能重复',
        'title.require' => '友情链接不能为空',
        'title.max'     => '友情链接名称最多不能超过25个字符',
        'desc.require' => '链接描述不能为空',
        'url.url' => '链接网址不正确',
    ];
}