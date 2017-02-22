<?php
namespace app\index\model;
use think\Model;
class User extends Model
{
    public function login($name,$password){
        $user=\think\Db::name('people')->where('name','=',$name)->find();
        if ($user){
           if ($user['password']==md5($password)){
               \think\Session::set('id',$user['id']);
               \think\Session::set('name',$user['name']);
               \think\Session::set('password',$user['password']);
               \think\Session::set('say',$user['say']);
               \think\Session::set('pic',$user['pic']);
               return 1;
           }else{
               return 2;
           }
        }else{
            return 3;
        }
    }
}