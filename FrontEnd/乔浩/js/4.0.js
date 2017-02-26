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

var pc1 = document .getElementById("c1")
var mctx = pc1.getContext("2d")
var img2 = new Image()
img2.src="img/4.1.jpg"
mctx.drawImage(img2,0,0)
mctx.font="25px YouYuan"
mctx.fillText("创始人",300,45)
mctx.fillText("陈晓华,吴晓丹,郭蕾",210,80)
mctx.fillText("这是一种苹果，假如有100个人，",70,120)
mctx.fillText("每个人都贡献出自己的那个，一个人就得到了99个。",70,160)

var pc2 = document .getElementById("c2")
var mctx2 = pc2.getContext("2d")
var img3 = new Image()
img3.src="img/4.2.jpg"
mctx2.drawImage(img3,0,0)
mctx2.font="25px Microsoft YaHei"
mctx2.fillText("百步梯技术部是百步梯研发中心下的一个部门，负责",85,80)
mctx2.fillText("百步梯网站的开发与维护以及为百步梯各部门提供技术支",35,115)
mctx2.fillText("持，同时聚集华工北校网络技术爱好者，以不断提升技术",35,150)
mctx2.fillText("部网络技术水平为目标。目前除了主题活动网站及官网的",35,185)
mctx2.fillText("开发和维护外，技术部还负责开发了“百步梯波板糖”微",35,220)
mctx2.fillText("信服务号、百步梯投票系统以及波板糖校巴定位APP、华",35,255)
mctx2.fillText("工地图APP等多款手机APP为广大学生提供校园服务。",35,290)

var pc3 = document .getElementById("c3")
var mctx3 = pc3.getContext("2d")
var img4 = new Image()
img4.src="img/4.1.jpg"
mctx3.drawImage(img4,0,0)
mctx3.font="18px YouYuan"
mctx3.fillText("精神>>技术",40,50)
mctx3.fillText("互联网精神 = {开放, 平等, 协作, 分享} ",40,80)
mctx3.fillText("更重要的：热爱，自由",40,110)

$(document).ready(function(){
  $("#c1").fadeIn(1000)
  $("#c3").fadeIn(1000,function(){
    $("#c2").slideDown()
  })
})
