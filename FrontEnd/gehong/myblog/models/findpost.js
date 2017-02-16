var mongodb = require("./db");

function Findpost(title,post,time){
    this.title = title;
    this.post = post;
    this.time = time;
}

module.exports = Findpost;

Findpost.article = function article(title,callback){
    mongodb.open(function(err,db){
        if(err){
            return callback(err);
        }
        //读取posts集合
        db.collection('posts',function(err,collection){
            if(err){
                mongodb.close();
                return callback(err);
            }
            //查找title
            collection.findOne({title:title},function(err,doc){
                mongodb.close();
                if(doc){
                    callback(err,doc);
                }
                else{
                    callback(err,null);
                }
            });
        });
    });
};

Findpost.Delete = function Delete(title,callback){
    mongodb.open(function(err,db){
        if(err){
            return callback(err);
        }
        db.collection('posts',function(err,collection){
            if(err){
                mongodb.close();
                return callback(err);
            }
            //删除
            collection.remove({title:title},function(err,result){
                mongodb.close();
                if(err){
                    return callback(err);
                }
                callback(result);
            })
        });
    });
};
