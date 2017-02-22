<?php
namespace app\admin\model;

use think\Model;

class Log extends Model
{
    public function login($username,$password){
        $user=\think\Db::name('user')->where('username','=',$username)->find();
        if ($user){
           if ($user['password']==md5($password)){
               \think\Session::set('id',$user['id']);
               \think\Session::set('username',$user['username']);
               \think\Session::set('password',$user['password']);
               return 1;
           }else{
               return 2;
           }
        }else{
            return 3;
        }
    }
}