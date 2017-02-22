<?php
namespace app\index\controller;
use think\Controller;
class Index extends Controller
{
    public function index()
    {
        $cateres=\think\Db::name('cate')->order('id','asc')->select();
        $this->assign('cateres',$cateres);
        $tags=\think\Db::name('tags')->order('id','asc')->select();
        $this->assign('tags',$tags);
        $link=\think\Db::name('link')->order('id','desc')->select();
        $this->assign('link',$link);
        $articleres=\think\Db::name('article')
            ->alias('a')->join('cate c','c.id = a.cateid','Left')
            ->field('a.id,a.title,a.pic,c.catename,a.time,a.click,a.desc,a.keyword')
            ->order('time','desc')
            ->paginate(5);
        $this->assign('articleres',$articleres);
        $massage=\think\Db::name('massage')->order('time','desc')->select();
        $this->assign('massage',$massage);
        $to_masg=\think\Db::name('to_masg')->order('time','desc')->select();
        $this->assign('to_masg',$to_masg);
        return $this->fetch('Index/index');

    }
}
