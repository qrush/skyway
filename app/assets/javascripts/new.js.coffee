#= require jquery
#= require jquery_ujs
#= require turbolinks

# Based on http://codepen.io/GiorgioMalvone/pen/CfeAa
# http://creativejs.com/resources/requestanimationframe/
window.requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame ||
                              window.webkitRequestAnimationFrame || window.oRequestAnimationFrame

canvas = document.getElementById("canvas")
ctx = canvas.getContext("2d")
canvas.width = window.innerWidth
canvas.height = window.innerHeight

drawLines = ->
  canvas.width = window.innerWidth
  canvas.height = window.innerHeight

  for i in [0.5..canvas.width] by 15
    ctx.moveTo(i, Math.floor(Math.random()*canvas.height))
    ctx.lineTo(i, Math.floor(Math.random()*canvas.width))

  random = Math.floor(Math.random()*10)
  ctx.lineWidth = 5
  ctx.strokeStyle = "rgba(144, 144, #{144 + random}, 0.04)"
  ctx.stroke()

fps = 1
draw = (timestamp) ->
  setTimeout ->
    requestAnimationFrame(draw)
    drawLines()
  , 1000 / fps

$ ->
  requestAnimationFrame(draw)
  $("#canvas").fadeIn(16000)
