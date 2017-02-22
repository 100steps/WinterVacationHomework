<?php
namespace app\admin\validate;
use think\Validate;
class Cate extends Validate
{
    protected $rule = [
        'catename'  =>  'require|max:25|unique:cate',
        'keyword' =>'require',
        'desc' =>'require',
    ];
    protected $message = [
        'catename.unique' => '栏目名称不能重复',
        'catename.require' => '栏目名称不能为空',
        'catename.max'     => '栏目名称最多不能超过25个字符',
        'keyword.require' => '关键词不能为空',
        'desc.require' => '描述不能为空',
    ];
}