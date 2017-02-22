<?php
namespace app\index\controller;
use think\Controller;
class Search extends Controller
{
    public function index()
    {
        $cateres=\think\Db::name('cate')->order('id','asc')->select();
        $this->assign('cateres',$cateres);
        $tags=\think\Db::name('tags')->order('id','asc')->select();
        $this->assign('tags',$tags);
        $keyword=input('edtSearch');
        $articleres=\think\Db::name('article')
            ->where('a.id|a.title|a.desc|a.keyword|a.content','like',"%{$keyword}%")
            ->order('time','desc')
            ->alias('a')->join('cate c','c.id = a.cateid','Left')
            ->field('a.id,a.title,a.pic,c.catename,a.time,a.click,a.desc,a.keyword')
            ->paginate(5);

        $this->assign('articleres',$articleres);
        $this->assign('keyword',$keyword);
        return $this->fetch('Search/search');
    }
}
