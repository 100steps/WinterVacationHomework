<?php
namespace app\admin\controller;
class Link extends Base
{
    public function index()
    {
        if (request()->isPost()){
            $keyword=input('keyword');
            $linkres=\think\Db::name('link')->order('id','asc')->where('id|title|desc','like',"%{$keyword}%")->paginate(10);
            $this->assign('linkres',$linkres);
            return $this->fetch();
        }
        $linkres=\think\Db::name('link')->paginate(10);
        $this->assign('linkres',$linkres);
        return $this->fetch('Link/index');
    }

    public function add()
    {
        if (request()->isPost()){
            $data=[
                'title'=>input('title'),
                'desc'=>input('desc'),
                'url'=>input('url'),
            ];

            $validate = \think\Loader::validate('link');
            if(!$validate->check($data)){
                return $this->error($validate->getError());
            }

            $db=\think\Db::name('link')->insert($data);
            if($db){
                return $this->success('添加链接成功','Link/index');
            }else{
                return $this->error('添加链接失败');
            }
            return ;
        }

        return $this->fetch('Link/add');
    }

    public function del()
    {
        $id=input('id');
        $db=\think\Db::name('link')->delete($id);
        if($db){
            return $this->success('删除链接成功','Link/index');
        }else{
            return $this->error('删除链接失败');
        }
        return;
    }

    public function edit()
    {
        if (request()->isPost()) {
            $data = [
                'id' => input('id'),
                'title'=>input('title'),
                'desc'=>input('desc'),
                'url'=>input('url'),
            ];

            $validate = \think\Loader::validate('link');
            if (!$validate->check($data)) {
                return $this->error($validate->getError());
            }

            if (\think\Db::name('link')->update($data)) {
                return $this->success('修改链接成功', 'Link/index');
            } else {
                return $this->error('修改链接失败');
            }
            return;
        }
        $id=input('id');
        $link=\think\Db::name('link')->find($id);
        $this->assign('link',$link);
        return $this->fetch('Link/edit');
    }
}
