var c = document.getElementById("myCanvas")
var ctx = c.getContext("2d")
var img= new Image()
img.src="img/head.jpg"
ctx.drawImage(img,290,0)
ctx.font="50px Arial "
ctx.fillText("welcome to 100steps",555,75)


var d = document.getElementById("myCanvas2")
var ctx2 = d.getContext("2d")
var grd1 = ctx2.createLinearGradient(0,0,255,50)
grd1.addColorStop(0,"white")
grd1.addColorStop(0.5,"black")
grd1.addColorStop(1,"white")
ctx2.fillStyle=grd1
ctx2.fillRect(0,0,255,50)
ctx2.strokeStyle="white"
ctx2.font="20px STkaiti "
ctx2.strokeText("部门介绍",90,30)


var e = document.getElementById("myCanvas3")
var ctx3 = e.getContext("2d")
var grd2 = ctx3.createLinearGradient(0,0,255,50)
grd2.addColorStop(0,"white")
grd2.addColorStop(0.5,"black")
grd2.addColorStop(1,"white")
ctx3.fillStyle=grd2
ctx3.fillRect(0,0,255,50)
ctx3.strokeStyle="white"
ctx3.font="20px STkaiti "
ctx3.strokeText("项目展示",90,30)

var f = document.getElementById("myCanvas4")
var ctx4 = f.getContext("2d")
var grd3 = ctx4.createLinearGradient(0,0,255,50)
grd3.addColorStop(0,"white")
grd3.addColorStop(0.5,"black")
grd3.addColorStop(1,"white")
ctx4.fillStyle=grd3
ctx4.fillRect(0,0,255,50)
ctx4.strokeStyle="white"
ctx4.font="20px STkaiti "
ctx4.strokeText("关于招新",90,30)

var g = document.getElementById("myCanvas5")
var ctx5 = g.getContext("2d")
var grd4 = ctx5.createLinearGradient(0,0,255,50)
grd4.addColorStop(0,"white")
grd4.addColorStop(0.5,"black")
grd4.addColorStop(1,"white")
ctx5.fillStyle=grd4
ctx5.fillRect(0,0,255,50)
ctx5.strokeStyle="white"
ctx5.font="20px STkaiti "
ctx5.strokeText("加入我们",90,30)

var f = document.getElementById("myCanvas6")
var ctx6 = f.getContext("2d")
var img2 = new Image()
img2.src="img/body3.jpg"
ctx6.drawImage(img2,250,0)
ctx6.strokeStyle="white"
ctx6.font="20px STxingkai"
ctx6.strokeText("如果你对计算机很有兴趣",20,30)
ctx6.strokeText("如果你想做一名程序猿",20,90)
ctx6.strokeText("或者你沉迷于攻破难题",20,150)
ctx6.strokeText("那么请加入我们",20,210)
ctx6.strokeText("这里",20,270)
ctx6.strokeText("有你想要的",20,330)

var g = document.getElementById("myCanvas7")
var ctx7 = g.getContext("2d")
var grd5 = ctx7.createRadialGradient(0,0,5,800,80,80)
grd5.addColorStop(0,"white")
grd5.addColorStop(1,"black")
ctx7.fillStyle=grd5
ctx7.fillRect(0,0,800,80)
ctx7.font="30px YouYuan"
ctx7.strokeText("欢迎加入百步梯技术部",270,50)

function k3(){
  windows.location.href="/2.html"
}
