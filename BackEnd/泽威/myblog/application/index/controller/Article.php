<?php
namespace app\index\controller;
use think\Controller;
use app\index\model\Article as Article0;
class Article extends Controller
{
    public function index()
    {
        $cateres=\think\Db::name('cate')->order('id','asc')->select();
        $this->assign('cateres',$cateres);
        db('article')->where('id', input('articleid'))->setInc('click');
        $article=\think\Db::name('article')
            ->where('a.id','=',input('articleid'))
            ->alias('a')->join('cate c','c.id = a.cateid','Left')
            ->field('a.id,a.title,a.pic,c.catename,a.time,a.click,a.desc,a.keyword,a.content')
            ->find();
        $this->assign('article',$article);
        $cla=new Article0();
        $this->assign('related',$cla->related($article['keyword']));
        $next=$cla->next(input('articleid'));
        $last=$cla->last(input('articleid'));
        $this->assign('next',$next);
        $this->assign('last',$last);

        $massage=\think\Db::name('massage')->where('modu',input('articleid'))->order('time','desc')->paginate(10);
        $to_masg=\think\Db::name('to_masg')
            ->where('modu',input('articleid'))
            ->order('time','asc')
            ->select();
        $this->assign('massage',$massage);
        $this->assign('to_masg',$to_masg);


        return $this->fetch('Article/article');

    }

    public function reply(){

        if (request()->isPost()){
            if (input('ini_id')){
                $data = [
                    'ini_id' => input('ini_id'),
                    'toid' => input('toid'),
                    'first' => input('first'),
                    'time' => time(),
                    'content' => input('content'),
                    'username' => input('name'),
                    'modu' => input('modu'),
                    'userid' => session('id')?session('id'):0,
                    'pic'=>session('pic')?session('pic'):"static/Index/images/".rand(1, 20).".jpg"
                ];
                $validate = \think\Loader::validate('Reply');
                if (!$validate->check($data)) {
                    return $this->error($validate->getError());
                }
                $db = \think\Db::name('to_masg')->insert($data);
            }else {

                $data = [
                    'time' => time(),
                    'content' => input('content'),
                    'username' => input('name'),
                    'modu' => input('modu'),
                    'userid' => session('id')?session('id'):0,
                    'pic'=>session('pic')?session('pic'):"static/index/images/".rand(1, 20).".jpg"
                ];
                $validate = \think\Loader::validate('Reply');
                if (!$validate->check($data)) {
                    return $this->error($validate->getError());
                }
                $db = \think\Db::name('massage')->insert($data);
            }
            if($db){
                return $this->success('回复成功');
            }else{
                return $this->error('回复失败');
            }
            return ;
        }

    }

}
