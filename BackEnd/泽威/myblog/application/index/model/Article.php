<?php
namespace app\index\model;

use think\Model;

class Article extends Model
{
    public function next($now){
        $next=\think\Db::name('article')->where('id','>',$now)->field('id')->find();
        if ($next){
            return $next;
        }else{
            return 0;
        }
    }
    public function last($now){
        $last=\think\Db::name('article')->where('id','<',$now)->field('id')->find();
        if ($last){
            return $last;
        }else{
            return 0;
        }
    }
    public function related($keyword){
        $arr=explode('，',$keyword);
        $result=array();
        foreach($arr as $k=>$v){
            $search=\think\Db::name('article')->where('keyword','like',"%{$v}%")->field('id,title,time')->select();
            $result=array_merge($search,$result);
        }
        foreach ($result as $k=>$v){
            $result[$k]=implode('，|，',$v);
        }
        $result=array_unique($result);
        foreach ($result as $k=>$v){
            $result[$k]=explode('，|，',$v);
        }
        return $result;
    }
}

?>