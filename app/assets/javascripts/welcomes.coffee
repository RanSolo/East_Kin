# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  state = 'kin'
  # Here we call we check the width and height anytime it changes we call mobileCart()
  $(window).on 'resize oreintationchange', ->
    canvasResize()
    return

  $(document).scroll ->
    canvasResize()
    return

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
      @gravity = Math.random() * (0 - 20) + 0
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
welcome_messages = new Array(
    'Click more descisions and listen to some tunes',
    'Click more descisions and watch a video',
    'Have you played with the synthesizer yet?',
    'Horton hears a who?',
    'You never think twice...',
    '...a time or two it was you',
    '...a time or three it was me',
    'Have you destroyed or restarted East Kins Universe?',
    '...the river will deliver your underscore.',
    'I can read your back page, it’s written on your face',
    'You’re as bad as me...',
    "Who's sayin' what 'bout who",
    "It feels like a chain I can't break",
    "I tell my friends you’re crazy",
    "There’s better days up ahead",
    "I’ll float through lite as a feather",
    "Watch out for time and it’s toll",
    "Count your blessings, hold on tight, don’t let go",
    "Trouble's just trouble. We all get into it somehow.",
    "Flowers or...",
    "Darkness or...",
    "The sun is hanging lower...",
    "Dreams live past the horizon, then fade into the heat...",
    "Might be levelling. Might be deshevelling...",
    "The Awakening might be a rude thing.",
    "...someone steps out of the shadows...",
    "Everything is not black and white.",
    "I love you, like it or not",
    "Why do you want to start this fight?",
    "There’s stones in the air",
    "There’s always something in your way... with stuff to say",
    "Might be a good thing … might be a bad thing...",
    "Might be a first thing … might be a last thing...",
    "Might not be anything … might be a lot of things",
    "You never can tell.",
    "It was a cold and bleak night...",
    "...on a long and lonely road",
    '...the river will deliver your underscore.',
    "I felt a great disturbance in the Force, as if millions of voices suddenly cried out in terror, and were suddenly silenced. I fear something terrible has happened.",
    'Do you feel like a God?',
    'Power makes you drunk.',
    'Horton hears a who?',
    'You never think twice...',
    '...a time or two it was you',
    '...a time or three it was me',
    'You’re as bad as me...',
    "I tell my friends you’re crazy",
    "Might be levelling. Might be deshevelling",
    "Count your blessings, hold on tight, don’t let go",
    "The Awakening might be a rude thing",
    "...someone steps out of the shadows",
    "Everything is not black and white",
    "Why do you want to start this fight",
    "There’s stones in the air",
    "There’s always something in your way... with stuff to say",
    "Might be a good thing … might be a bad thing.",
    "Might be a first thing … might be a last thing..",
    "It was a cold and bleak night...",
    "...on a long and lonely road",
    'Afirmitive, Dave. I read you.',
    "I'm sorry, Dave. I'm afraid I can't do that.",
    "This Mission is too important for me to allow you jeaprodize it...",
    "I know that you and Frank were planning to disconnect me."
    "...I could see your lips move..."
    "Without your space helmet, Dave? You're gonna find that very difficult...",
    "Dave, this conversation can serve no purpose anymore, goodbye.",
    )
welcome_messages.sort ->
  0.5 - Math.random()
plugWelcome = (message) ->
  $('#tokyo').hide('slow')
  $('#life').hide('slow')
  $('#all-things').text(message)
  $('#all-things').show('slow')

ticker = (state, messages) ->

  offset = 0
  _(welcome_messages).each (item) ->
    tickerText = setTimeout (->
      plugWelcome(item)
      $('#all-things').show('slow')
      return
    ), 10000 + offset
    offset += 12000
  return

ticker('kin', welcome_messages)
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
  state = 'destroy'
  ticker('destroy', destruction_messages)
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
      gpSelected = null
      nearestD = 99999
      d = null
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
  pushParticles()
  fruitLoop()
  state = 'kin'
  ticker('restart', welcome_messages)
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
      gpSelected = null
      nearestD = 99999
      d = null
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
