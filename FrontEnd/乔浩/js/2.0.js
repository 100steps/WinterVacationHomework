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
grd3.addColorStop(0,"black")
grd3.addColorStop(0.5,"white")
grd3.addColorStop(1,"black")
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

$(document).ready(function(){
  $("#myDiv1").slideDown("slow",
  function() { $("#myDiv2").slideDown("slow",
    function(){$("#myDiv3").slideDown("slow",
      function(){$("#myDiv4").slideDown("slow")}
    )}
  )}
  )
})
