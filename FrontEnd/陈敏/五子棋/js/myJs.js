var myCanvas=document.getElementById("myCanvas");
context = myCanvas.getContext("2d");
var turn = 1;
var record=new Array(15);
var i,j;
for(i=0;i<15;i++){
    record[i] = new Array(15);
    for(j=0;j<15;j++){
        record[i][j]=2;
    }
}

function drawArc(i,j,player){
    context.beginPath();
    context.arc(i*30,j*30,12.5,2*Math.PI,false);
    if(player){
                 context.fillStyle="black";
             }
             else{
                context.fillStyle="white";
             }
             context.closePath();
    context.fill();
}

function drawBoard(){
         var i;
        for(i=30;i<480;i+=30){
                context.moveTo(30,i);
                context.lineTo(450,i);
        }
        for(i=30;i<480;i+=30){
                 context.moveTo(i,30);
                 context.lineTo(i,450);
        }
        context.stroke();

        context.beginPath();
        context.arc(240,240,2,2*Math.PI,false);
        context.stroke();

        context.beginPath();
        context.arc(120,360,2,2*Math.PI,false);
        context.stroke();

        context.beginPath();
        context.arc(120,120,2,2*Math.PI,false);
        context.stroke();

        context.beginPath();
        context.arc(360,120,2,2*Math.PI,false);
        context.stroke();

        context.beginPath();
        context.arc(360,360,2,2*Math.PI,false);
        context.stroke();
}

function judgeVictory(p){
        var m = 0; 
        var i,j,k,l;
        k = 0;
        //rows
        for(j=0;j<15;j++){
           for(i = 0;i<15;i++){
             if(record[i][j] ==p){
                m++;
                if (m == 5) {victory(p);}
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
                if (m==5) {victory(p);}
             }
             else{m = 0}
           }
      }
      //
       for(i = 0;i<11;i++){
           for(j = 0,k=i;j<15-i;j++,k++){
             if(record[k][j] ==p){
                m++;
                if (m==5) {victory(p);}
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
                if (m==5) {victory(p);}
          }
          else{m = 0}
          }
      } 
      //
      for(i = 4,j = 0;i<15;i++){
          for(k = i ,l = j; k>-1;k--,l++){
          if(record[k][l] ==p){
                m++;
                if (m==5) {victory(p);}
          }
          else{m = 0}
          }
      }
      //ing
      for(i = 14,j = 1;j<11;j++){
          for(k = i,l = j;l<15;k--,l++){
          if(record[k][l] ==p){
                m++;
                if (m==5) {victory(p);}
          }
          else{m = 0}
          }
      }
      
}

function victory(p){
        if(p){alert("Black wins");}
        else{alert("White wins");}
}

myCanvas.onclick=function(p){
            var x = p.offsetX;
            var y = p.offsetY;
             var a = Math.round(x/30);
             var b = Math.round(y/30);
             if(record[a-1][b-1] == 2){
                drawArc(a,b,turn);      
                if(turn){
                    record[a-1][b-1] = 1;
                 }
                 else{
        record[a-1][b-1] = 0;
                 }
                          turn = !turn ;
             }
             judgeVictory(record[a-1][b-1]);//
}

window.onload=function(){
  drawBoard();
}

//ing
function save(){
      alert("haha");
      var m,n;
      localStorage.record = new Array(15);
      for(m = 0; m<15;m++){
            localStorage.record[m] =new Array(15);
            for(n = 0 ; n<15;n++){
                 localStorage.record[m][n] =record[m][n];
            }
            alert(localStorage.record[m][n]);
      }
}