#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require perlin

# Based on http://codepen.io/GiorgioMalvone/pen/CfeAa
# http://creativejs.com/resources/requestanimationframe/
window.requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame ||
                              window.webkitRequestAnimationFrame || window.oRequestAnimationFrame

canvas = document.getElementById("canvas")
ctx = canvas.getContext("2d")
canvas.width = window.innerWidth
canvas.height = window.innerHeight

drawLines = (timestamp) ->
  canvas.width = window.innerWidth
  canvas.height = window.innerHeight

  for i in [0.5..canvas.width] by 15
    start = Math.abs(Math.floor(noise.simplex2(i, timestamp) * canvas.height))
    end = Math.abs(Math.floor(noise.simplex2(i, timestamp) * canvas.width))
    ctx.moveTo(i, start)
    ctx.lineTo(i, end)

  ctx.lineCap = "round"
  ctx.lineWidth = 5
  ctx.strokeStyle = "rgba(144, 144, 144, 0.04)"
  ctx.stroke()

fps = 0.5
draw = (timestamp) ->
  setTimeout ->
    requestAnimationFrame(draw)
    drawLines(timestamp)
  , 1000 / fps

$ ->
  noise.seed(Math.random())
  drawLines(0)
  requestAnimationFrame(draw)

  $('#js-mobile-menu').on 'click', (e) ->
    e.preventDefault()
    menu = $('#navigation-menu')
    menu.slideToggle ->
      if menu.is(':hidden')
        menu.removeAttr('style')
