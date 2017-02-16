var mongodb = require("./db");

function Modify(username,newpassword){
	this.username = username;
	this.newpassword = newpassword;
}

module.exports = Modify;

Modify.modify = function modify(callback){
	var user = {
		username: this.username,
		newpassword: this.newpassword
	};

	mongodb.open(function(err,db){
		if(err){
			return callback(err);
		}
		//��ȡusers����
		db.collection('users',function(err,collection){
			if(err){
				mongodb.close();
				return callback(err);
			}
			//���ݿ����
			collection.save({name:user.username},{$set:{"password":user.newpassword}});
			mongodb.close();
			return callback('error');
		});
	});
};