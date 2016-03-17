# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
_classCallCheck = (instance, Constructor) ->
  if !(instance instanceof Constructor)
    throw new TypeError('Cannot call a class as a function')
  return

### ---- Functions ----###

fruitLoop = ->
  context.clearRect 0, 0, canvas.width, canvas.height
  gPoints.map (g, index) ->
    g.render()
    return
  particles.map (p, index) ->
    p.update gPoints
    p.render()
    return
  requestAnimationFrame fruitLoop
  return

getDist = (x1, y1, x2, y2) ->
  Math.sqrt Math.sqr(y2 - y1) + Math.sqr(x2 - x1)

window.setTimeout (->
  $('.first .outerLetter.current').addClass 'gone'
  # $('.letter-container').slideUp 'slow'
  return
), 10000
window.setTimeout (->
  $('.second .outerLetter.current').addClass 'gone'
  return
), 4000
window.setTimeout (->
  $('.third .outerLetter.current').addClass 'gone'
  return
), 5000
window.setTimeout (->
  $('.fourth .outerLetter.current').addClass 'gone'
  return
), 6000
window.setTimeout (->
  $('.fifth .outerLetter.current').addClass 'gone'
  return
), 7000
'use strict'

### ---- SETTINGS ---- ###

PARTICLE_NUMBERS = 500
GRAVITY_POINT_NUMBERS = Math.abs(Math.floor(Math.random() * (0 - 15)) + 0)

PARTICULE_SPEED = 0.9
VELOCITY = .90
COLORS = [
  '#F2F3AE'
  '#ECFF8B'
  '#FFFCF9'
  '#E0F2E9'
  '#FCD9EE'
]

### ---- Particle ---- ###

Particle = do ->
  `var Particle`

  Particle = (x, y) ->
    _classCallCheck this, Particle
    @x = x
    @y = y
    @vel = Math.randomF(-4, 4)
    @vel =
      x: @vel
      y: @vel
      max: Math.randomF(2, 10)
    @train = []
    @color = COLORS[Math.floor(Math.random() * COLORS.length)]
    return

  Particle::render = ->
    context.beginPath()
    context.strokeStyle = @color
    context.lineWidth = 1
    context.moveTo @train[0].x, @train[0].y
    i = @train.length - 1
    i
    while i > 0
      context.lineTo @train[i].x, @train[i].y
      i--
    context.stroke()
    return

  Particle::update = (gPoints) ->
    force = @getForceOfNearestGravityPoint()
    @vel.x += force.x
    @vel.y += force.y
    @x += @vel.x * PARTICULE_SPEED
    @y += @vel.y * PARTICULE_SPEED
    if Math.abs(@vel.x) > @vel.max
      @vel.x *= VELOCITY
    if Math.abs(@vel.y) > @vel.max
      @vel.y *= VELOCITY
    #trains
    @train.push
      x: @x
      y: @y
    if @train.length > 10
      @train.splice 0, 1
    return

  Particle::getForceOfNearestGravityPoint = ->
    _this = this
    gpSelected = undefined
    nearestD = 99999
    d = undefined
    gPoints.map (gp) ->
      d = getDist(gp.x, gp.y, _this.x, _this.y)
      if nearestD > d
        nearestD = d
        gpSelected = gp
      return
    gpSelected.getForceDirection @x, @y, nearestD

  Particle

### ---- GravityPoint ---- ###

GravityPoint = do ->
  `var GravityPoint`
  n = Math.abs(Math.floor(Math.random() * (0 - 30)) + 0)
  GravityPoint = (x, y) ->
    _classCallCheck this, GravityPoint
    @x = x
    @y = y
    if n > 0
      @gravity = 0
    if n > 2
      @gravity = Math.abs(Math.random() * (0 - .1) + 0)

    if n > 7  && n < 13
      @gravity = 200

    if n > 13  && n < 19
      @gravity = 500

    if n > 18 && n < 24
      @gravity = 800

    if n > 23 && n < 27
      @gravity = 1200

    if n > 26  && n < 29
      @gravity = 3000

    if n > 28 && n < 32
      @gravity = 0


  GravityPoint::render = ->
    context.beginPath()
    context.strokeStyle = '#4F5AF2'
    context.lineWidth = 2
    context.arc @x, @y, @gravity, 0, Math.PI * 2
    context.stroke()
    return

  GravityPoint::getForceDirection = (x, y, dist) ->
    F = @gravity / dist
    {
      x: (@x - x) * .5 * F
      y: (@y - y) * .5 * F
    }

  GravityPoint

Math.sqr = (a) ->
  a * a

Math.randomF = (min, max) ->
  `var i`
  Math.random() * (max - min) + min

### ---- START ---- ###

particles = []
gPoints = []
windowWidth = window.innerWidth
windowHeight = window.innerHeight
canvas = document.createElement('canvas')
context = canvas.getContext('2d')
canvas.id = 'canvas'
canvas.width = window.innerWidth
canvas.height = window.innerHeight
document.body.appendChild canvas
i = 0
while i < PARTICLE_NUMBERS
  particles.push new Particle(Math.randomF(0, windowWidth), Math.randomF(0, windowHeight))
  i++
i = 0
while i < GRAVITY_POINT_NUMBERS
  gPoints.push new GravityPoint(Math.randomF(windowWidth * .01, windowWidth - (windowWidth * .01)), Math.randomF(windowHeight * .01, windowHeight - (windowHeight * .01)))
  i++
fruitLoop()
# gPoints.push new GravityPoint(Math.randomF(windowWidth * .5, windowWidth - (windowWidth * .5)), Math.randomF(windowHeight * .5, windowHeight - (windowHeight * .5)))
