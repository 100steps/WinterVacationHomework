var express = require('express');
var router = express.Router();
var User = require('../models/user.js');
var Post = require('../models/post.js');
var Findpost = require('../models/findpost.js');
var Comment = require('../models/comment.js');
var Modify = require('../models/modify.js');

router.get('/', function(req, res, next) {
	Post.get(null,function(err,posts){
		if(err){
			posts = [];
		}
		res.render('index',{
			title:'Home',
			posts:posts
		});
	});
});

router.get('/login', function(req, res, next) {
	res.render('login', { title: 'Login' });
});

router.post('/login',function(req,res){

	//console.log(req.body['username']);
	//console.log(req.body['password']);

	if(req.body['username']==""){
		req.flash('error','Error:Username cannot be empty');
		console.log('username empty');
		return res.redirect('/login');
	}
	if(req.body['password']==""){
		req.flash('error','Error:Password cannot be empty');
		console.log('password empty');
		return res.redirect('/login');
	}

	User.get(req.body.username,function(err,user){
		if(!user){
			req.flash('error','Error:user does not exist');
			return res.redirect('/login');
		}
		if(user.password!=req.body.password){
			req.flash('error','Error:Password error');
			return res.redirect('/login');
		}
		req.session.user = user;
		//console.log(req.session.user);
		req.flash('success','Success:login');
		res.redirect('/');
	});
});

router.get('/article/:title', function(req, res, next) {

	//console.log(req.params.title);

	Findpost.article(req.params.title,function(err,doc){
		if(!doc){
			req.flash('error','Error:Article is not defind');
			return res.redirect('/');
		}
		Comment.get(req.params.title,function(err,comments){
			if(err){
				comments = [];
			}
			res.render('article',{
				title:req.params.title,
				time:doc.time,
				post:doc.post,
				comments:comments
			});
		});
	});
});
router.post('/article/:title',function(req, res, next){
	if(req.body['comment']==""){
		console.log('comment empty');
		req.flash('error','Error:Comment cannot be empty');
		return res.redirect('/article/'+req.body['title']);
	}
	if(req.body['username']==""){
		console.log('username empty');
		req.flash('error','Error:Login please');
		return res.redirect('/article/'+req.body['title']);
	}
	console.log(req.body['comment']);
	console.log(req.body.title);
	var newComment = new Comment(req.body.username,req.body.title,req.body.comment);
	newComment.save(function(err){
		if (err) {
			req.flash('error', err);
			return res.redirect('/register');
		}
		req.flash('success','Success:Comment was pushed');
		console.log('comment success');
		res.redirect('/article/'+req.body['title']);
	});
});

router.get('/register', function(req, res, next) {
	res.render('register', { title: 'Register' });
});

router.post("/register", function(req, res) {

	console.log(req.body['password']);
	console.log(req.body['apassword']);

	if(req.body['username']==""){
		req.flash('error','Error:Username cannot be empty');
		console.log('username empty');
		return res.redirect('/register');
	}
	if(req.body['password']==""){
		req.flash('error','Error:password cannot be empty');
		console.log('password empty');
		return res.redirect('/register');
	}
	if(req.body['apassword']==""){
		req.flash('error','Error:password-repeat cannot be empty');
		console.log('apassword empty');
		return res.redirect('/register');
	}
	if(req.body['email']==""){
		req.flash('error','Error:email cannot be empty');
		console.log('email empty');
		return res.redirect('/register');
	}
	if(req.body['apassword'] != req.body['password']){
		req.flash('error', 'Error:Two password input inconsistent');
		console.log('password atypism');
		return res.redirect('/register');
	}

	var newUser = new User({
		name: req.body.username,
		password: req.body.password,
		email: req.body.email
	});
	//检查用户名是否已经存在*/
	User.get(newUser.name, function(err, user) {
		if (user) {
			err = 'Username already exists.';
		}
		if (err) {
			req.flash('error', err);
			return res.redirect('/register');
		}

		newUser.save(function(err) {
			if (err) {
				req.flash('error', err);
				return res.redirect('/register');
			}
			req.session.user = newUser;
			req.flash('success', req.session.user.name+'register successfully');
			console.log('register success');
			res.redirect('/');
		});
	});
});

router.get('/about', function(req, res, next) {
	res.render('about', { title: 'About' });
});

router.get('/post', function(req, res, next) {
	res.render('post', { title: 'POST' });
});

router.post("/post",function(req,res){
	var currentUser = req.session.user;
	var post = new Post(currentUser.name,req.body.title,req.body.introduce,req.body.post);
	post.save(function(err){
		if(err){
			req.flash('error',err);
			return res.redirect('/post');
		}

		req.flash('success','Success:Post');
		console.log(currentUser);
		res.redirect('/');
	});
});

router.get('/backstageH', function(req, res, next){
	Post.get(req.session.user.name,function(err,posts){
		if(err){
			posts = [];
		}
		res.render('backstageH',{
			title:'backstage',
			posts:posts
		});
	});
});

router.get('/backstageS', function(req, res, next){
	res.render('backstageS', {title: 'backstage'});
});

router.post('/backstageS',function(req,res, nex){
	if(req.body['backstage-password'] == ""){
		console.log('password empty');
		req.flash('error','Error:Password cannot be empty');
		return res.redirect('/backstageS/');
	}
	console.log(req.body['backstage-password']);
	Modify.modify(req.session.user.name,req.body['backstage-password'],function(err,callback) {
		if (err) {
			req.flash('error', err);
			return res.redirect('/backstageS');
		}
		req.flash('success', 'Success:Password was modify');
		console.log('modify success');
		res.redirect('/backstageS');
	});
});

router.get("/logout",function(req,res){
	req.session.user = null;
	req.flash('success','Success: Logout');
	res.redirect('/');
});

module.exports = router;
