<?php
namespace app\index\controller;
use think\Controller;
class Lst extends Controller
{
    public function index()
    {

        $cateres=\think\Db::name('cate')->order('id','asc')->select();
        $this->assign('cateres',$cateres);
        $articleres=\think\Db::name('article')
            ->alias('a')->join('cate c','c.id = a.cateid','Left')
            ->field('a.id,a.title,a.pic,c.catename,a.time,a.click,a.desc,a.keyword')
            ->order('time','desc')
            ->where('cateid',input('cateid'))
            ->paginate(5);
        $this->assign('articleres',$articleres);
        $massage=\think\Db::name('massage')->order('time','desc')->select();
        $this->assign('massage',$massage);
        $to_masg=\think\Db::name('to_masg')->order('time','desc')->select();
        $this->assign('to_masg',$to_masg);
        return $this->fetch('Lst/list');

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
                    'pic'=>session('pic')?session('pic'):"static/index/images/".rand(1, 20).".jpg"
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
                    'pic'=>session('pic')?session('pic'):"static/Index/images/".rand(1, 20).".jpg"
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
        $cateres=\think\Db::name('cate')->order('id','asc')->select();
        $this->assign('cateres',$cateres);
        $massage=\think\Db::name('massage')->where('modu',0)->order('time','desc')->paginate(10);
        $to_masg=\think\Db::name('to_masg')
            ->where('modu',0)
            ->order('time','asc')
            ->select();
        $this->assign('massage',$massage);
        $this->assign('to_masg',$to_masg);
        $tags=\think\Db::name('tags')->order('id','asc')->select();
        $this->assign('tags',$tags);
        return $this->fetch('Lst/book');
    }


}
