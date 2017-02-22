<?php
namespace app\admin\validate;
use think\Validate;
class User extends Validate
{
    protected $rule = [
        'username'  =>  'require|max:15|unique:user',
        'password' =>'require|max:15|min:3',
    ];
    protected $message = [
        'username.unique' => '用户名不能重复',
        'user.require' => '用户名不能为空',
        'username.max'     => '用户名最多不能超过25个字符',
        'password.require' => '密码不能为空',
        'password.max' => '密码不能多于15个字符',
        'password.min' => '密码不能少于3个字符',
    ];
    protected $scene = [
        'edit'  =>  ['password'],
    ];
}