<?php
namespace app\admin\controller;
class Article extends Base
{
    public function index()
    {
        if (request()->isPost()){
            $keyword=input('keyword');
            $articleres=\think\Db::name('article')->order('a.id','desc')->where('id|title|desc|keyword|content|time','like',"%{$keyword}%")->paginate(10);
            $this->assign('articleres',$articleres);
            return $this->fetch();
        }
        $articleres=\think\Db::name('article')->order('a.id','desc')->alias('a')->join('cate c','c.id = a.cateid','Left')->field('a.id,a.title,a.pic,c.catename,a.time,a.click')->paginate(10);
        $this->assign('articleres',$articleres);
        return $this->fetch('Article/index');
    }

    public function add()
    {
        if (request()->isPost()){
            $data=[
                'title'=>input('title'),
                'keyword'=>input('keyword'),
                'content'=>input('content'),
                'desc'=>input('desc'),
                'cateid'=>input('cateid'),
                'time'=>time(),
            ];

            if ($_FILES['pic']['tmp_name'])
            {
                //获取表单上传文件 例如上传了001.jpg
                $pic = request()->file('pic');
                //移动到框架应用根目录/public/uploads/ 目录下
                  $info = $pic->move(ROOT_PATH . 'public' . DS . 'static/uploads');
                if($info){
                    $data['pic']='/static/uploads/'.date('Ymd').'/'.$info->getFilename();
                }else{
                    // 上传失败获取错误信息
                    return $this->error($pic->getError());
                }
            }

            $validate = \think\Loader::validate('article');
            if(!$validate->check($data)){
                return $this->error($validate->getError());
            }

            $db=\think\Db::name('article')->insert($data);
            if($db){
                return $this->success('添加文章成功','index');
            }else{
                return $this->error('添加文章失败');
            }
            return ;
        }

        $cateres=\think\Db::name('cate')->select();
        $this->assign('cateres',$cateres);
        return $this->fetch('Article/add');
    }

    public function del()
    {
        $id=input('id');
        $db=\think\Db::name('article')->delete($id);
        if($db){
            return $this->success('删除文章成功','index');
        }else{
            return $this->error('删除文章失败');
        }
        return;
    }
    public function edit()
    {
        if (request()->isPost()) {
            $data = [
                'id' => input('id'),
                'title'=>input('title'),
                'keyword'=>input('keyword'),
                'content'=>input('content'),
                'desc'=>input('desc'),
                'cateid'=>input('cateid'),
            ];

            if ($_FILES['pic']['tmp_name'])
            {
                //获取表单上传文件 例如上传了001.jpg
                $pic = request()->file('pic');
                //移动到框架应用根目录/public/uploads/ 目录下
                $info = $pic->move(ROOT_PATH . 'public' . DS . 'static/uploads');
                if($info){
                    $data['pic']='/static/uploads/'.date('Ymd').'/'.$info->getFilename();
                }else{
                    // 上传失败获取错误信息
                    return $this->error($pic->getError());
                }
            }

            $validate = \think\Loader::validate('article');
            if (!$validate->check($data)) {
                return $this->error($validate->getError());
            }

            if (\think\Db::name('article')->update($data)) {
                return $this->success('修改文章成功', 'index');
            } else {
                return $this->error('修改文章失败');
            }
            return;
        }
        $id=input('id');
        $article=\think\Db::name('article')->find($id);
        $this->assign('article',$article);
        $cateres=\think\Db::name('cate')->select();
        $this->assign('cateres',$cateres);
        return $this->fetch('Article/edit');
    }

}
