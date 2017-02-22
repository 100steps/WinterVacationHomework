<?php
namespace app\admin\controller;
use think\Controller;
class Base extends Controller
{
    public function _initialize()
    {
        if (session('id') && session('username') && session('password')){
            $user=\think\Db::name('user')->find(session('id'));
            if ($user['password']==session('password')){

            }else{
                return $this->error('登录超时，请重新！','Log/index');
            }
        }else{
            return $this->error('请先登录！','Log/index');
        }
    }
}
