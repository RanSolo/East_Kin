# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # Here we call we check the width and height anytime it changes we call mobileCart()
  $(window).on 'load resize', ->
    canvasResize()
    return
  $(window).on "orientationchange", ->
    canvasResize()
    return

  $(document).scroll ->
    mobileCart()
    return
# shows the mobile cart only when the width is below 760px and above 750 in height.

  $('#restart-universe').click -> restartUniverse()
  $('#blow-up-universe').click -> blowUpUniverse()
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

### ---- SETTINGS ---- ###

randomizeParticle = ->
  groupDecider = Math.abs(Math.floor(Math.random() * (0 - 6)) + 0)
  if groupDecider < 1
    return 7
  if groupDecider < 2
    return 25
  if groupDecider < 3
    return 200
  if groupDecider < 4
    return 500
  else
    return 750

PARTICLE_NUMBERS = randomizeParticle()
GRAVITY_POINT_NUMBERS = Math.abs(Math.floor(Math.random() * (0 - 100)) + 0)
PARTICULE_SPEED = 0.8
VELOCITY = 1
COLORS = [
  '#F2F3AE'
  '#ECFF8B'
  '#FFFCF9'
  '#E0F2E9'
  '#FCD9EE'
  'purple'
  'aqua'
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
  n = Math.abs(Math.floor(Math.random() * (0 - 32)) + 0)
  GravityPoint = (x, y) ->
    _classCallCheck this, GravityPoint
    @x = x
    @y = y
    if n > 0
      @gravity = 0
    if n > 1
      @gravity = Math.random() * (0 - .2) + 0

    if n > 4  && n < 8
      @gravity = 200

    if n > 7  && n < 11
      @gravity = 400

    if n > 10 && n < 14
      @gravity = 600

    if n > 13 && n < 17
      @gravity = 800

    if n > 16  && n < 29
      @gravity = 1000

    if n > 28 && n < 32
      @gravity = 2000


  GravityPoint::render = ->
    context.beginPath()
    context.strokeStyle = '#4F5AF2'
    context.lineWidth =
    context.arc @x, @y, @gravity, 0, Math.PI * 1
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
canvas.id = 'canvas'
canvas.width = windowWidth
canvas.height = windowHeight
context = canvas.getContext('2d')
document.body.appendChild canvas

pushParticles = ->
  Math.sqr = (a) ->
    a * a

  Math.randomF = (min, max) ->
    `var i`
    Math.random() * (max - min) + min

  ### ---- START ---- ###

  particles = []
  gPoints = []
  i = 0
  while i < PARTICLE_NUMBERS
    particles.push new Particle(Math.randomF(0, windowWidth), Math.randomF(0, windowHeight))
    i++
  i = 0
  while i < GRAVITY_POINT_NUMBERS
    gPoints.push new GravityPoint(Math.randomF(windowWidth * .01, windowWidth - (windowWidth * .01)), Math.randomF(windowHeight * .01, windowHeight - (windowHeight * .01)))
    i++
pushParticles()


fruitLoop()
canvasResize = ->
  oldCanvas = document.getElementById('canvas')
  document.body.removeChild(oldCanvas)

  windowWidth = window.innerWidth
  windowHeight = window.innerHeight
  canvas = document.createElement('canvas')
  canvas.id = 'canvas'
  canvas.width = windowWidth
  canvas.height = windowHeight
  context = canvas.getContext('2d')
  document.body.appendChild canvas

blowUpUniverse = ()->
  context.clearRect(0, 0, canvas.width, canvas.height)
  atomic_bomb =  document.getElementById('atomic-bomb')
  atomic_bomb.volume = 0.2
  $('#atomic-bomb').trigger('play')

  $('#tokyo').show()
  $('#life').hide()
  $('#all-things').hide()
  @gravity = 1000

  getDist = (x1, y1, x2, y2) ->
    Math.sqrt Math.sqr(y2 - y1) + Math.sqr(x2 - x1)

  ### ---- SETTINGS ---- ###
  PARTICLE_NUMBERS = 1000
  GRAVITY_POINT_NUMBERS = 1

  PARTICULE_SPEED = .3
  VELOCITY = 1
  COLORS = [
    '#F2F3AE'
    '#ECFF8B'
    '#FFFCF9'
    '#E0F2E9'
    '#FCD9EE'
    '#F2F3AE'
    '#ECFF8B'
    '#FFFCF9'
    '#E0F2E9'
    '#FCD9EE'
    '#F2F3AE'
    '#ECFF8B'
    '#FFFCF9'
    '#E0F2E9'
    '#FCD9EE'
    'orange'
    'orange'
    'red'
    'blue'
    'purple'
    'red'
    'black'
    'green'
  ]

  ### ---- Particle ---- ###

  Particle = do ->
    `var Particle`

    Particle = (x, y) ->
      _classCallCheck this, Particle
      @x = x
      @y = y
      @vel = 3
      @vel =
        x: @vel
        y: @vel
        max: 2
      @train = []
      @color = COLORS[Math.floor(Math.random() * COLORS.length)]
      return

    Particle::render = ->
      context.beginPath()
      context.strokeStyle = @color
      context.lineWidth = .1
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
      if @train.length > 100
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
      @gravity = 3000

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


  pushParticles()

restartUniverse = ->
  context.clearRect(0, 0, canvas.width, canvas.height)
  space_ship =  document.getElementById('space-ship')
  space_ship.volume = 0.1
  $('#space-ship').trigger('play')
  $('#tokyo').hide()
  $('#all-things').hide()
  $('#life').show()
  @gravity = 0

  getDist = (x1, y1, x2, y2) ->
    Math.sqrt Math.sqr(y2 - y1) + Math.sqr(x2 - x1)

  ### ---- SETTINGS ---- ###

  PARTICLE_NUMBERS = randomizeParticle()
  GRAVITY_POINT_NUMBERS = Math.abs(Math.floor(Math.random() * (2 - 100)) + 0)

  PARTICULE_SPEED = Math.abs((Math.random() * (0 - 5)) + 0)
  VELOCITY =  Math.abs((Math.random() * (0.5 - 1)) + 0)
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
      @vel = 3
      @vel =
        x: @vel
        y: @vel
        max: 2
      @train = []
      @color = COLORS[Math.floor(Math.random() * COLORS.length)]
      return

    Particle::render = ->
      context.beginPath()
      context.strokeStyle = @color

      context.lineWidth = .1
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
      if @train.length > 100
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
    n = Math.abs(Math.floor(Math.random() * (0 - 12)) + 0)
    GravityPoint = (x, y) ->
      _classCallCheck this, GravityPoint
      @x = x
      @y = y
      if n > 0
        @gravity = 1
      if n > 2
        @gravity = 5
      if n > 3
        @gravity = 7
      if n > 4
        @gravity = 750
      if n > 6
        @gravity = 1000
      if n > 8
        @gravity = 10000

# 1 10 3000



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

  pushParticles()
