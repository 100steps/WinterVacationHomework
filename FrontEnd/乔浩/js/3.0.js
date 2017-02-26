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
grd2.addColorStop(0,"black")
grd2.addColorStop(0.5,"white")
grd2.addColorStop(1,"black")
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

var c1 = document.getElementById("cv1")
var myctx1 = c1.getContext("2d")
var img2 = new Image()
img2.src="img/e1.jpg"
myctx1.drawImage(img2,0,0)

var c2 = document.getElementById("cv2")
var myctx2 = c2.getContext("2d")
var img3 = new Image()
img3.src = "img/e2.jpg"
myctx2.drawImage(img3,16,0)

var c3 = document.getElementById("cv3")
var myctx3 = c3.getContext("2d")
var img4 = new Image()
img4.src = "img/e3.jpg"
myctx3.drawImage(img4,0,0)

var c4 = document.getElementById("cv4")
var myctx4 = c4.getContext("2d")
var img4 = new Image()
img4.src = "img/e4.jpg"
myctx4.drawImage(img4,30,80)
myctx4.font="20px YouYuan "
myctx4.fillText("校巴定位，让出行更便捷",30,50)
var img5 = new Image()
img5.src = "img/e5.png"
myctx4.drawImage(img5,320,80)
myctx4.fillText("每日一文，让生活更新鲜",320,50)
var img6 = new Image()
img6.src = "img/e6.jpg"
myctx4.drawImage(img6,630,55)
myctx4.fillText("波板糖",700,330)
myctx4.fillText("给校园生活加个糖!!",650,360)

var c5 = document.getElementById("cv5")
var myctx5 = c5.getContext("2d")
var img7 = new Image()
img7.src = "img/e7.jpg"
myctx5.drawImage(img7,0,0)
myctx5.font=" 15px FZShuTi  "
myctx5.fillText("虽然两人没说过话，也不认识",500,110)
myctx5.fillText("但是通过歌声,真的有种互相治愈的感觉，真的很奇妙",500,140)
myctx5.fillText("有些时候我们需要治愈不是情绪不好",500,170)
myctx5.fillText("仅仅是享受和陌生人产生共鸣的时刻",500,200)
myctx5.fillText("仅仅是喜爱人与人之间莫名其妙的缘分际遇",500,230)
myctx5.fillText("可能治愈系的意义就在这吧",500,260)
myctx5.fillText("你用你无趣的时间唱一首歌，恰好给别人带来一点有趣",500,290)
myctx5.fillText("治愈系",500,320)
myctx5.fillText("用声音温暖了这一段时光。",500,350)

var c6 = document.getElementById("cv6")
var myctx6 = c6.getContext("2d")
var img8 = new Image()
img8.src="img/e8.jpg"
myctx6.drawImage(img8,0,0)
myctx6.fillStyle="white"
myctx6.font="15px FZYaoti "
myctx6.fillText("人生最遗憾的莫过于轻易放弃不该放弃",10,30)
myctx6.fillText("的东西,固执的坚持了不该坚持的；而你",10,50)
myctx6.fillText("却打算轻易的放弃一段感情而固守矜持吗？",10,70)
myctx6.fillText("还犹豫什么，赶紧大胆说出你的爱吧！",10,90)
myctx6.fillText("临近毕业，才想起自己还没想暗恋的他表白",10,150)
myctx6.fillText("过；临近毕业，才惊醒自己没有为班级",10,170)
myctx6.fillText("做出足够的贡献；临近毕业，才了解自己",10,190)
myctx6.fillText("没有几个知心朋友；临近毕业，才回忆自",10,210)
myctx6.fillText("己的大学生活是在打机中度过的；临近毕",10,230)
myctx6.fillText("毕业……我遗憾过，就不想让你再同样遗憾",10,250)
myctx6.fillText("真诚邀请你写下在华工最遗憾的事",10,270)
myctx6.fillText("你盼，或者不盼它，毕业日期就",10,330)
myctx6.fillText("定在那里,不快不慢里；不快不",10,350)
myctx6.fillText("慢:你等，或者不等他（她），恋",10,370)
myctx6.fillText("人就在那里，不即不离;你写，或",10,390)
myctx6.fillText("者不写它，最后的话就在你心里，不",10,410)
myctx6.fillText("增不减。写下最后想说的话，然后，让",10,440)
myctx6.fillText("记忆定格：默然ˇ回忆 寂静ˇ悲喜。",10,460)

$(document).ready(function(){
  var mychar1 = document.getElementById("cv4")
  var mychar2 = document.getElementById("cv5")
  var mychar3 = document.getElementById("cv6")

  $("#cv1").click(function(){
   $("#cv4").fadeIn("slow")
   mychar2.style.display = "none"
   mychar3.style.display = "none"
 })

  $("#cv2").click(function(){
    $("#cv5").fadeIn("slow")

      mychar1.style.display = "none"
      mychar3.style.display = "none"
      mychar2.style.border ="solid cc3366"

  })

  $("#cv3").click(function(){
    $("#cv6").fadeIn("slow")
      mychar1.style.display = "none"
      mychar3.style.border = "solid 66cc33"
      mychar2.style.display = "none"


  })
  $("#m").fadeIn()
})
