<?php
namespace app\admin\controller;
class Massage extends Base
{
    public function index()
    {
        if (request()->isPost()){
            $keyword=input('keyword');
            $masgres=\think\Db::name('massage')->order('id','asc')->where('id|username|content|article','like',"%{$keyword}%")->paginate(10);
            $this->assign('masgres',$masgres);
            return $this->fetch('Massage/index');
        }
        $masgres=\think\Db::name('massage')->order('m.id','asc')->alias('m')->join('article a','a.id = m.modu','Left')->field('m.id,m.content,m.time,a.title,m.username,m.modu')->paginate(10);
        $this->assign('masgres',$masgres);
        return $this->fetch('Massage/index');
    }


    public function del()
    {
        if($id=input('id')){
            $db=\think\Db::name('massage')->delete($id);
        }else{
            $id=input('tid');
            $db=\think\Db::name('To_masg')->delete($id);
        }
        if($db){
            return $this->success('删除留言成功','Massage/index');
        }else{
            return $this->error('删除留言失败');
        }
        return;
    }

    public function To_masg_one()
    {
        $masgres=\think\Db::name('To_masg')->where('toid','=',input('id'))->where('first','=','1')->paginate(5);
            $this->assign('masgres',$masgres);
            return $this->fetch('Massage/To_masg');
    }
    public function To_masg_two()
    {

        $masgres=\think\Db::name('To_masg')->where('toid','=',input('id'))->where('first','=','0')->paginate(5);
            $this->assign('masgres',$masgres);
            return $this->fetch('Massage/To_masg');

    }

    public function reply()
    {
        if (request()->isPost()){
            $data=[
                'toid'=>input('toid'),
                'username'=>'管理员',
                'content'=>input('content'),
                'time'=>time(),
                'first'=>input('first'),
            ];

            $db=\think\Db::name('To_masg')->insert($data);
            if($db){
                return $this->success('回复成功','Massage/index');
            }else{
                return $this->error('回复失败');
            }
            return ;
        }
        $first=input('first');
        $toid=input('id');
        $this->assign('toid',$toid);
        $this->assign('first',$first);
        return $this->fetch('Massage/reply');
    }

}
