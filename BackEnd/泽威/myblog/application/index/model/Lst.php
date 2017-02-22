<?php
namespace app\index\model;

use think\Model;

class Lst extends Model
{
    public function get_num($a,$b,$c){
        $result=array();
       foreach ($a as $k=>$v){
           $num=0;
           foreach ($b as $k0=>$v0){
               if ($v['modu']==$v0['modu']){
                   $num++;
               }
           }
           $result['$k']=$num;
       }
       var_dump($result);die;
    }
}

?>