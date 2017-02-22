<?php
namespace app\index\validate;
use think\Validate;
class User extends Validate
{
    protected $rule = [
        'name'  =>  'require|unique:people|max:25',
        'password' =>'require',
    ];
    protected $message = [
        'name.require' => '用户名不能为空',
        'name.max'     => '用户名不能多于25个字符',
        'name.unique'     => '用户名已存在',
        'password.require' => '密码不能为空',
    ];
    protected $scene = [
        'edit'  =>  ['password'],
    ];
}