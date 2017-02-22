<?php
namespace app\admin\controller;
class Tags extends Base
{
    public function index()
    {
        if (request()->isPost()){
            $keyword=input('keyword');
            $tags=\think\Db::name('link')->order('id','asc')->where('id|title','like',"%{$keyword}%")->paginate(10);
            $this->assign('tags',$tags);
            return $this->fetch('Tags/index');
        }
        $tags=\think\Db::name('tags')->order('id','asc')->paginate(10);
        $this->assign('tags',$tags);
        return $this->fetch('Tags/index');
    }

    public function add()
    {
        if (request()->isPost()){
            $data=[
                'title'=>input('name'),
            ];

            $validate = \think\Loader::validate('Tags');
            if(!$validate->check($data)){
                return $this->error($validate->getError());
            }

            $db=\think\Db::name('tags')->insert($data);
            if($db){
                return $this->success('添加标签成功','Tags/index');
            }else{
                return $this->error('添加标签失败');
            }
            return ;
        }

        return $this->fetch('Tags/add');
    }

    public function del()
    {
        $id=input('id');
        $db=\think\Db::name('tags')->delete($id);
        if($db){
            return $this->success('删除标签成功','Tags/index');
        }else{
            return $this->error('删除标签失败');
        }
        return;
    }

    public function edit()
    {
        if (request()->isPost()) {
            $data = [
                'id' => input('id'),
                'title'=>input('name'),
            ];
            $validate = \think\Loader::validate('tags');
            if (!$validate->check($data)) {
                return $this->error($validate->getError());
            }

            if (\think\Db::name('tags')->update($data)) {
                return $this->success('修改标签成功', 'Tags/index');
            } else {

                return $this->error('修改标签失败');
            }
            return;
        }
        $id=input('id');
        $tags=\think\Db::name('tags')->find($id);
        $this->assign('tags',$tags);
        return $this->fetch('Tags/edit');
    }
}
