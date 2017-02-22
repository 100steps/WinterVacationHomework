<?php
namespace app\index\controller;
use think\Controller;
class Tags extends Controller
{
    public function index()
    {
        $cateres=\think\Db::name('cate')->order('id','asc')->select();
        $this->assign('cateres',$cateres);
        $keyword=input('keyword');
        $articleres=\think\Db::name('article')
            ->alias('a')->join('cate c','c.id = a.cateid','Left')
            ->field('a.id,a.title,a.pic,c.catename,a.time,a.click,a.desc,a.keyword')
            ->order('time','desc')
            ->where('a.keyword','like',"%{$keyword}%")
            ->paginate(5);
        $this->assign('articleres',$articleres);
        $massage=\think\Db::name('massage')->order('time','desc')->select();
        $this->assign('massage',$massage);
        return $this->fetch('Tags/tags');

    }
}
