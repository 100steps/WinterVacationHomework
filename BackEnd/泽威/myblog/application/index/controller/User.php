<?php
namespace app\index\controller;
use think\Controller;
use app\index\model\User as User0;
class User extends Controller
{
    public function index()
    {
        if (request()->isPost()){
            $log = new User0();
            $status=$log->login(input('name'),input('password'));
            if ($status==1){
                return $this->success('登录成功，正在前往！');
            }elseif($status==2){
                return $this->error('密码或者用户名错误！');
            }else{
                return $this->error('用户不存在！');
            }
        }
        $user=\think\Db::name('people')->where('id','=',input('id'))->find();
        $this->assign('user',$user);
        return $this->fetch('User/index');
    }


    public function logout()
    {
        \think\Session::clear();
        return $this->success('登出成功','index/index');
    }

    public function edit()
    {
        if (request()->isPost()){
            $data = [
                'id' => session('id'),
                'password'=>input('password')?md5(input('password')):session('password'),
                'qq'=>input('qq'),
                'say'=>input('say'),
            ];

            if ($_FILES['pic']['tmp_name'])
            {
                //获取表单上传文件 例如上传了001.jpg
                $pic = request()->file('pic');
                //移动到框架应用根目录/public/uploads/ 目录下
                $info = $pic->move(ROOT_PATH . 'public' . DS . 'static/uploads/head');
                if($info){
                    $data['pic']='/static/uploads/head/'.date('Ymd').'/'.$info->getFilename();
                }else{
                    // 上传失败获取错误信息
                    return $this->error($pic->getError());
                }
            }
            if ($_FILES['bkg']['tmp_name'])
            {
                //获取表单上传文件 例如上传了001.jpg
                $bkg = request()->file('bkg');
                //移动到框架应用根目录/public/uploads/ 目录下
                $info = $bkg->move(ROOT_PATH . 'public' . DS . 'static/uploads/background');
                if($info){
                    $data['bkg']='/static/uploads/background/'.date('Ymd').'/'.$info->getFilename();
                }else{
                    // 上传失败获取错误信息
                    return $this->error($pic->getError());
                }
            }

            $validate = \think\Loader::validate('User');
            if (!$validate->scene('edit')->check($data)) {
                return $this->error($validate->getError());
            }

            if (\think\Db::name('people')->update($data)) {
                $user=\think\Db::name('people')->where('name','=',session('name'))->find();
                \think\Session::clear();
                \think\Session::set('id',$user['id']);
                \think\Session::set('name',$user['name']);
                \think\Session::set('password',$user['password']);
                \think\Session::set('pic',$user['pic']);
                \think\Session::set('say',$user['say']);
                return $this->success('修改信息成功');
            } else {
                return $this->error('修改信息失败');
            }
            return;
        }
        $user=\think\Db::name('people')->where('id','=',input('id'))->find();
        if ($user['name']==session('name')) {
            if ($user['password'] == session('password')) {

            } else {
                return $this->error('请登陆！');
            }
        }else{
                return $this->error('请登陆！');
            }
            $this->assign('user',$user);
        return $this->fetch('User/edit');
    }

    public function register()
    {
        if (request()->isPost()){
            $data=[
                'name'=>input('username'),
                'password'=>input('password'),
                'pic'=>session('pic')?session('pic'):"static/Index/images/".rand(1, 20).".jpg"
            ];

            $validate = \think\Loader::validate('User');
            if(!$validate->check($data)){
                return $this->error($validate->getError());
            }
            if (input('password')!=input('password1')){
                $this->error('两次密码不一致');
            }
            $data['password']=md5(input('password'));

            $db=\think\Db::name('people')->insert($data);
            if($db){
                $user=\think\Db::name('people')->where('name','=',input('username'))->find();
                \think\Session::set('id',$user['id']);
                \think\Session::set('name',$user['name']);
                \think\Session::set('password',$user['password']);
                \think\Session::set('pic',$user['pic']);
                return $this->success('注册成功','index/index');
            }else{
                return $this->error('注册失败');
            }
            return ;
        }

        return $this->fetch('User/register');
    }
}
