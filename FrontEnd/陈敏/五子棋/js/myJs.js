var screenHeight=window.screen.height;
var myCanvas=document.getElementById("myCanvas");
context = myCanvas.getContext("2d");
var myCanvas2=document.getElementById("myCanvas2");
context2=myCanvas2.getContext("2d");
var myTime=document.getElementById("myTime");
var seconds = 0;
var minutes = 0;
var turn = 1;
var record=new Array(15);
var canvasWidth=myCanvas.width;
myCanvas.height=canvasWidth;
var boxLenght=canvasWidth/16;
for( var firstI=0;firstI<15;firstI++){
    record[firstI] = new Array(15);
    for(var firstJ=0;firstJ<15;firstJ++){
        record[firstI][firstJ]=2;
    }
}
//play:1黑0白
function drawArc(i,j,player){
    context.beginPath();
    context.arc(i*boxLenght+boxLenght,j*boxLenght+boxLenght,boxLenght*0.4,2*Math.PI,false);
    if(player){
                 context.fillStyle="black";
             }
             else{
                context.fillStyle="white";
             }
             context.closePath();
    context.fill();
}
//画棋盘
function drawBoard(){
         var i;
        for(i=boxLenght;i<boxLenght*16;i+=boxLenght){
                context.moveTo(boxLenght,i);
                context.lineTo(boxLenght*15,i);
        }
        for(i=boxLenght;i<boxLenght*16;i+=boxLenght){
                 context.moveTo(i,boxLenght);
                 context.lineTo(i,boxLenght*15);
        }
        context.stroke();

        context.beginPath();
        context.arc(boxLenght*8,boxLenght*8,2,2*Math.PI,false);
        context.stroke();

        context.beginPath();
        context.arc(boxLenght*4,boxLenght*12,2,2*Math.PI,false);
        context.stroke();

        context.beginPath();
        context.arc(boxLenght*4,boxLenght*4,2,2*Math.PI,false);
        context.stroke();

        context.beginPath();
        context.arc(boxLenght*12,boxLenght*4,2,2*Math.PI,false);
        context.stroke();

        context.beginPath();
        context.arc(boxLenght*12,boxLenght*12,2,2*Math.PI,false);
        context.stroke();

        //cs
    context.beginPath();
    showTurn();
}
//胜利方法
function judgeVictory(p){
        var m = 0; 
        var i,j,k,l;
        k = 0;
        //rows
        for(j=0;j<15;j++){
           for(i = 0;i<15;i++){
             if(record[i][j] ==p){
                m++;
                if (m == 5) {victory(p);break;}
             }
             else{m = 0}
           }
          m=0;
       }
       //cols
      for(i = 0;i<15;i++){
           for(j = 0;j<15;j++){
             if(record[i][j] ==p){
                m++;
                if (m==5) {victory(p);break;}
             }
             else{m = 0}
           }
      }
      //
       for(i = 0;i<11;i++){
           for(j = 0,k=i;j<15-i;j++,k++){
             if(record[k][j] ==p){
                m++;
                if (m==5) {victory(p);break;}
             }
             else{m = 0}
           }
      }
      //
      i = 0;
      for(j=1,k=0;j<11;j++){
          for(l = j,k = 0;l<15;k++,l++){
          if(record[k][l] ==p){
                m++;
                if (m==5) {victory(p);break;}
          }
          else{m = 0}
          }
      } 
      //
      for(i = 4,j = 0;i<15;i++){
          for(k = i ,l = j; k>-1;k--,l++){
          if(record[k][l] ==p){
                m++;
                if (m==5) {victory(p);break;}
          }
          else{m = 0}
          }
      }
      //ing
      for(i = 14,j = 1;j<11;j++){
          for(k = i,l = j;l<15;k--,l++){
          if(record[k][l] ==p){
                m++;
                if (m==5) {victory(p);break;}
          }
          else{m = 0}
          }
      }
      
}
//胜利事件
function victory(p){
        if(p){alert("胜利者：黑");}
        else{alert("胜利者：白方");}
        context.clearRect(0,0,canvasWidth,canvasWidth);
        drawBoard();
        for (var i=0;i<15;i++){
            for(var j = 0;j<15;j++){
                record[i][j]=2;
            }
        }
}
//落子
myCanvas.onclick=function(p){
            var x = p.offsetX;
            var y = p.offsetY;
             var a = Math.round(x/boxLenght);
             var b = Math.round(y/boxLenght);
             if(record[a-1][b-1] == 2){
                drawArc(a-1,b-1,turn);
                if(turn){
                    record[a-1][b-1] = 1;
                 }
                 else{
                   record[a-1][b-1] = 0;
                 }
                          turn = !turn ;
             }
             showTurn();
             judgeVictory(record[a-1][b-1]);//
}

window.onload=function(){
  drawBoard();
  if(localStorage.jsonRecord){
      var haveStorage=confirm("是否读取上次进度");
      if(haveStorage){
          read();
      }
  }
}
setInterval("addTime()",1000);

//储存进度
function save(){
    localStorage.jsonRecord=JSON.stringify(record);
    localStorage.turn=turn;

}
//读取进度
function read() {
    readRecord();
    turn=localStorage.turn;
    showTurn();
}
//
function readRecord() {
    context.clearRect(0,0,480,480);
    drawBoard();
    if(localStorage.jsonRecord) {
        var jsonRecord=JSON.parse(localStorage.jsonRecord);
        for(var i = 0;i<15;i++){
            for(var j = 0;j<15;j++){
                jsonRecord[i][j] = JSON.parse(jsonRecord[i][j]);
                if(jsonRecord[i][j]!=2){
                    drawArc(i,j,jsonRecord[i][j]);
                }
            }
        }
        record = jsonRecord.slice();
    }
    else{
        alert("没有缓存");
    }
}
//turn
function showTurn() {
    context2.beginPath();
    context2.arc(25,25,25,2*Math.PI,false);
    if(turn){
        context2.fillStyle="black";
    }else{context2.fillStyle="white";}
    context2.fill();
}
//时间
function addTime() {
    seconds++;
    if(seconds>=60){
        minutes++;
        seconds-=60;
    }
    myTime.innerHTML = minutes+":"+seconds;
}