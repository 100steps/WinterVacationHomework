<?php
namespace app\admin\validate;
use think\Validate;
class Article extends Validate
{
    protected $rule = [
        'title'  =>  'require|max:40|unique:article',
        'keyword' =>'require',
        'desc' =>'require',
        'content' =>'require|min:20',
    ];
    protected $message = [
        'title.unique' => '标题不能重复',
        'title.require' => '标题不能为空',
        'title.max'     => '标题不能多于40个字符',
        'keyword.require' => '关键词不能为空',
        'desc.require' => '描述不能为空',
        'content.require' => '内容不能为空',
        'content.min' => '内容不能低于20个字符',
    ];
}