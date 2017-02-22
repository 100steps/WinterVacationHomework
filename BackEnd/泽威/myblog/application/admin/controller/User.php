<?php
namespace app\admin\controller;
class User extends Base
{
    public function index()
    {
        if (request()->isPost()){
            $keyword=input('keyword');
            $userres=\think\Db::name('user')->order('id','asc')->where('id|username','like',"%{$keyword}%")->paginate(10);
            $this->assign('userres',$userres);
            return $this->fetch('User/index');
        }
        $userres=\think\Db::name('user')->order('id','asc')->paginate(10);
        $this->assign('userres',$userres);
        return $this->fetch('User/index');
    }

    public function add()
    {
        if (request()->isPost()){
            $data=[
                'username'=>input('username'),
                'password'=>input('password'),
            ];

            $validate = \think\Loader::validate('User');
            if(!$validate->check($data)){
                return $this->error($validate->getError());
            }
            $data['password']=md5(input('password'));

            $db=\think\Db::name('user')->insert($data);
            if($db){
                return $this->success('添加管理员成功','User/index');
            }else{
                return $this->error('添加管理员失败');
            }
            return ;
        }

        return $this->fetch('User/add');
    }

    public function del()
    {
        $id=input('id');
        $db=\think\Db::name('user')->delete($id);
        if($db){
            return $this->success('删除管理员密码成功','User/index');
        }else{
            return $this->error('删除管理员密码失败');
        }
        return;
    }

    public function edit()
    {
        if (request()->isPost()) {
            if (input('password') == ''){
                return $this->success('修改管理员成功', 'User/index');
            }

            $data = [
                'id' => input('id'),
                'password'=>input('password'),
            ];

            $validate = \think\Loader::validate('user');
            if (!$validate->scene('edit')->check($data)) {
                return $this->error($validate->getError());
            }
            $data['password']=md5(input('password'));

            if (\think\Db::name('user')->update($data)) {
                return $this->success('修改管理员成功', 'User/index');
            } else {
                return $this->error('修改管理员失败');
            }
            return;
        }
        $id=input('id');
        $user=\think\Db::name('user')->find($id);
        $this->assign('user',$user);
        return $this->fetch('User/edit');
    }
}
