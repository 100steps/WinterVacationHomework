<?php
namespace app\admin\controller;
class Cate extends Base
{
    public function index()
    {
        if (request()->isPost()){
            $keyword=input('keyword');
            $cateres=\think\Db::name('cate')->order('id','asc')->where('id|catename|desc|keyword','like',"%{$keyword}%")->paginate(10);
            $this->assign('cateres',$cateres);
            return $this->fetch('Cate/index');
        }
        $cateres=\think\Db::name('cate')->order('id','asc')->paginate(10);
        $this->assign('cateres',$cateres);
        return $this->fetch('Cate/index');
    }

    public function add()
    {
        if (request()->isPost()){
            $data=[
                'catename'=>input('catename'),
                'type'=>input('type')?input('type'):0,
                'keyword'=>input('keyword'),
                'desc'=>input('desc'),
            ];

            $validate = \think\Loader::validate('cate');
            if(!$validate->check($data)){
                return $this->error($validate->getError());
            }

            $db=\think\Db::name('cate')->insert($data);
            if($db){
                return $this->success('添加栏目成功','Cate/index');
            }else{
                return $this->error('添加栏目失败');
            }
            return ;
        }
        return $this->fetch('Cate/add');
    }

    public function del()
    {
        $id=input('id');
        $db=\think\Db::name('cate')->delete($id);
        if($db){
            return $this->success('删除栏目成功','Cate/index');
        }else{
            return $this->error('删除栏目失败');
        }
        return;
    }
    public function edit()
    {
        if (request()->isPost()) {
            $data = [
                'id' => input('id'),
                'catename' => input('catename'),
                'keyword' => input('keyword'),
                'desc' => input('desc'),
                'type'=>input('type')?input('type'):0,
            ];
            $validate = \think\Loader::validate('cate');
            if (!$validate->check($data)) {
                return $this->error($validate->getError());
            }

            if (\think\Db::name('cate')->update($data)) {
                return $this->success('修改栏目成功', 'Cate/index');
            } else {
                return $this->error('修改栏目失败');
            }
            return;
        }
        $id=input('id');
        $cate=\think\Db::name('cate')->find($id);
        $this->assign('cate',$cate);
        return $this->fetch('Cate/edit');
    }

}
