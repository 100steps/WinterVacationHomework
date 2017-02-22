<?php
namespace app\admin\controller;
use think\Controller;
use app\admin\model\Log as Log0;
class Log extends Controller
{
    public function index()
    {
        if (request()->isPost()){
            $log = new Log0();
            $status=$log->login(input('username'),input('password'));
            if ($status==1){
                return $this->success('登录成功，正在前往！','Index/index');
            }elseif($status==2){
                return $this->error('密码或者用户名错误！');
            }else{
                return $this->error('用户不存在！');
            }
        }
        return $this->fetch('Log/index');
    }
    public function logout()
    {
        \think\Session::clear();
        return $this->success('登出成功','Log/index');
    }
}
