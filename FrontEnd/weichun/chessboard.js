var turn = "b";
var n = 0;  //记录落子个数
var winner = "";
var storage = [];

var arr = new Array();          
function clean(p){
	for(var i = -3; i < 24 ; i++){          
		arr[i*p] = new Array();     
		for(var j = -3; j < 24; j++){      
			arr[i*p][j*p] = ""; 
		} 
	}
}


var canvas = document.getElementById("chessboard");
//获取屏幕的宽度
var clientHeight = document.documentElement.clientHeight;
var clientWidth = document.documentElement.clientWidth;
if (clientWidth > clientHeight) {
	var p = Math.floor(clientHeight * 9 / 200);
}
else {
	var p = Math.floor(clientWidth * 9 / 200);
}

var canvasWidth = Math.floor(p * 20);
canvas.setAttribute('width',canvasWidth+'px');
canvas.setAttribute('height',canvasWidth+'px');
document.getElementById("chessboard_box").setAttribute('width',canvasWidth+'px');
document.getElementById("chessboard_box").setAttribute('height',canvasWidth+'px');

clean(p);
var cxt = canvas.getContext("2d");
//打印棋盘
function print(){
	for (var i = 0; i < 21; i++) {
		cxt.beginPath();
		cxt.moveTo(i*p ,  0 );
		cxt.lineTo(i*p , canvasWidth);
		cxt.lineTo(i*p ,  0 );
		cxt.lineTo(i*p , canvasWidth);
		cxt.moveTo( 0 , i*p);
		cxt.lineTo(canvasWidth, i*p);
		cxt.lineTo( 0 , i*p);
		cxt.lineTo(canvasWidth, i*p);
		cxt.stroke();
	}
}
print();
//落子
canvas.onclick = function(e){
 	e = e || window.event;
 	//获取坐标
 	var rect = canvas.getBoundingClientRect();   
 	var x = e.clientX - rect.left * (canvas.width / rect.width);
    var y = e.clientY - rect.top * (canvas.height / rect.height);
	var chess_x = Math.round(x/p) * p;
	var chess_y = Math.round(y/p) * p;

	if (chess_x == 0 || chess_x == canvasWidth || chess_y == 0 || chess_y == canvasWidth || arr[chess_x][chess_y] !== "" || winner !== ""){}
	else{
		if (turn == "w"){
			document.getElementById('message').innerHTML = '轮到黑方了';
			chess("white",chess_x,chess_y);
			check("white",chess_x,chess_y);
			n++;
			turn = "b";
		}
		else{
			document.getElementById('message').innerHTML = '轮到白方了';
			chess("black",chess_x,chess_y);
			check("black",chess_x,chess_y);
			n++;
			turn = "w";
		}
	} 
}
//打印棋子
function chess(s,chess_x,chess_y){	
	cxt.beginPath();
	cxt.arc(chess_x,chess_y,Math.floor(p/2),0,360,false);
	cxt.lineWidth = 1;
	if (s == "white"){
		cxt.fillStyle = "#FFF";
	}
	else if (s == "black"){
		cxt.fillStyle = "#000";
	}
	cxt.fill();
	cxt.strokeStyle = "#000";
	cxt.stroke();
	cxt.closePath();
	arr[chess_x][chess_y] = s;
	store(n,s,chess_x,chess_y);
}

//胜负判定
function check(s,x,y){
	var k=0;
	var arrx = x / p;
	var arry = y / p;
	//横
	for(var i = (arrx - 4); i < (arrx + 5); i++){
		if (arr[i*p][y] == s){
			k++;
			if (k == 5){
				win(s);
				break;
			}
		}
		else {
			k = 0;
		}
	}
	//竖
	k = 0;
	for(var j = (arry - 4); j < (arry + 5); j++){
		if (arr[x][j*p] == s){
			k++;
			if (k == 5){
				win(s);
				break;
			}
		}
		else {
			k = 0;
		}
	}
	//斜45
	k = 0;
	for(var i = -4; i < 5; i++){
		if (arr[x - (i * p)][y + (i * p)] == s){
			k++;
			if (k == 5){
				win(s);
				break;
			}
		}
		else {
			k = 0;
		}
	}
	//斜135
	k = 0;
	for(var i = -4; i < 5; i++){
		if (arr[x + (i * p)][y + (i * p)] == s){
			k++;
			if (k == 5){
				win(s);
				break;
			}
		}
		else {
			k = 0;
		}
	}
}
function win(s){
	winner = s;
	if (s == "white"){
		document.getElementById('message').innerHTML = "白方赢了!!!";
		document.getElementById('save').disabled = true;
	}
	else if (s == "black"){
		document.getElementById('message').innerHTML = "黑方赢了!!!";
		document.getElementById('save').disabled = true;
	}
}
//存储
function store(n,s,chess_x,chess_y){
	storage[n] = {
		x : chess_x,
		y : chess_y,
		who : s
	}
}
//本地存储
var save = document.getElementById("save");
var read = document.getElementById("read");
save.onclick = function(){
	localStorage.storage = JSON.stringify(storage);
	localStorage.n = n;
	localStorage.turn = turn;
}
read.onclick = function(){
	//读档
	storage = JSON.parse(localStorage.storage || JSON.stringify([]));//如果没有本地存储怎么搞？
	n = localStorage.n;
	if (isNaN(n)){
		n = 0;
	}
	turn = localStorage.turn || "b";
	//清空棋盘
	cxt.clearRect(0, 0, canvasWidth, canvasWidth);
	print();
	clean(p);

	if (turn == "w"){
		document.getElementById('message').innerHTML = '轮到白方了';
	}
	else {
		document.getElementById('message').innerHTML = '轮到黑方了';
	}
	console.log(storage);
	for (var i = 0; i < n; i++){
		arr[storage[i]["x"]][storage[i]["y"]] = storage[i]["who"];
		chess(storage[i]["who"],storage[i]["x"],storage[i]["y"]);
	}
	console.log(arr);
}
var newg = document.getElementById("new");
newg.onclick = function(){
	window.location = "五子棋.html"
}