<?php
namespace app\admin\validate;
use think\Validate;
class Tags extends Validate
{
    protected $rule = [
        'title'  =>  'require|max:5|unique:tags',

    ];
    protected $message = [
        'title.unique' => '标签名称不能重复',
        'title.require' => '标签不能为空',
        'title.max' => '标签名称不能大于5个字符',
    ];
}