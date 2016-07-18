ctx = new ((window.AudioContext or window.webkitAudioContext))
noteStops = {}
freeNotes = {}
chordNotes = {}
playing = false
powerOn = true
contextInterval = null
wave = 'sine'

createOscillator = (freq) ->
  osc = ctx.createOscillator()
  osc.type = wave
  osc.frequency.value = freq
  osc.start ctx.currentTime
  osc

createGainNode = ->
  gainNode = ctx.createGain()
  gainNode.connect ctx.destination
  gainNode

Note = (freq) ->
  @oscillatorNode = createOscillator(freq)
  @gainNode = createGainNode()
  @oscillatorNode.connect @gainNode
  return

Note.prototype =
  start: (type) ->
    if type == 'free'
      @gainNode.gain.value = 0.3
    else if type == 'chord'
      @gainNode.gain.value = 0.1
    return
  stop: ->
    @gainNode.gain.value = 0
    return
Tones =
  'A#3': 466.16
  'B3': 493.88
  'C4': 523.25
  'C#4': 554.37
  'D4': 587.33
  'D#4': 622.25
  'E4': 659.25
  'F4': 698.46
  'F#4': 739.99
  'G4': 783.99
  'G#4': 830.61
  'A4': 880.00
  'A#4': 932.33
  'B4': 987.77
  'C5': 1046.50
  'C#5': 1108.73
  'D5': 1174.66
  'D#5': 1244.51
  'E5': 1318.51
  'F5': 1396.91
  'F#5': 1479.98
  'G5': 1567.98
keycodeToChordName =
  65: 'C'
  83: 'F'
  68: 'Bb'
  70: 'Eb'
  71: 'Ab'
  72: 'Db'
  74: 'Gb'
  75: 'B'
  76: 'E'
  59: 'A'
  44: 'D'
  90: 'Cm'
  88: 'Fm'
  67: 'Bbm'
  86: 'Ebm'
  66: 'Abm'
  78: 'Dbm'
  77: 'Gbm'
  188: 'Bm'
keycodeToNotes =
  192: [ 'A#3' ]
  9: [ 'B3' ]
  81: [ 'C4' ]
  50: [ 'C#4' ]
  87: [ 'D4' ]
  51: [ 'D#4' ]
  69: [ 'E4' ]
  82: [ 'F4' ]
  53: [ 'F#4' ]
  84: [ 'G4' ]
  54: [ 'G#4' ]
  89: [ 'A4' ]
  55: [ 'A#4' ]
  85: [ 'B4' ]
  73: [ 'C5' ]
  57: [ 'C#5' ]
  79: [ 'D5' ]
  48: [ 'D#5' ]
  80: [ 'E5' ]
  219: [ 'F5' ]
  187: [ 'F#5' ]
  221: [ 'G5' ]
  65: [
    'C4'
    'E4'
    'G4'
    'C5'
  ]
  83: [
    'C4'
    'F4'
    'A4'
    'C5'
  ]
  68: [
    'D4'
    'F4'
    'A#4'
    'D5'
  ]
  70: [
    'A#3'
    'D#4'
    'G4'
    'A#4'
  ]
  71: [
    'C4'
    'D#4'
    'G#4'
    'C5'
  ]
  72: [
    'C#4'
    'F4'
    'G#4'
    'C#5'
  ]
  74: [
    'A#3'
    'C#4'
    'F#4'
    'A#4'
  ]
  75: [
    'B3'
    'D#4'
    'F#4'
    'B4'
  ]
  76: [
    'B3'
    'E4'
    'G#4'
    'B4'
  ]
  59: [
    'C#4'
    'E4'
    'A4'
    'C#5'
  ]
  44: [
    'D4'
    'F#4'
    'A4'
    'D5'
  ]
  90: [
    'C4'
    'D#4'
    'G4'
    'C5'
  ]
  88: [
    'C4'
    'F4'
    'G#4'
    'C5'
  ]
  67: [
    'C#4'
    'F4'
    'A#4'
    'C#5'
  ]
  86: [
    'A#3'
    'D#4'
    'F#4'
    'A#4'
  ]
  66: [
    'B3'
    'D#4'
    'G#4'
    'B4'
  ]
  78: [
    'C#4'
    'E4'
    'G#4'
    'C#5'
  ]
  77: [
    'C#4'
    'F#4'
    'A4'
    'C#5'
  ]
  188: [
    'B3'
    'D4'
    'F4'
    'B4'
  ]
Chords =
  0: 'C'
  1: 'Cm'
  2: 'F'
  3: 'Fm'
  4: 'Bb'
  5: 'Bbm'
  6: 'Eb'
  7: 'Ebm'
  8: 'Ab'
  9: 'Abm'
  10: 'Db'
  11: 'Dbm'
  12: 'Gb'
  13: 'Gbm'
  14: 'B'
  15: 'Bb'
  16: 'E'
  17: 'Em'
  18: 'A'
  19: 'Am'
  20: 'D'
  21: 'Dm'
  22: 'G'
  23: 'Gm'

createKeys = (widgetWidth, widgetHeight) ->
  toneStrings = Object.keys(Tones)
  key = undefined
  width = widgetWidth / 16
  height = widgetHeight * 13 / 15
  toneStrings.forEach ((tone) ->
    key = document.createElement('div')
    key.id = tone
    key.className = 'key'
    keyStyleString = undefined
    if tone[1] == '#'
      keyStyleString = 'width: ' + width + 'px;' + 'height: ' + height + 'px;' + 'border: 1px solid green;' + 'display: inline-block;' + 'background: black;' + 'position: absolute;' + 'top: 0;' + 'width: ' + width / 2 + 'px;' + 'height: ' + height / 2 + 'px;' + 'margin-left: ' + '-' + width / 4 + 'px;'
    else
      keyStyleString = 'width: ' + width + 'px;' + 'height: ' + height + 'px;' + 'border: 1px solid green;' + 'display: inline-block;' + 'background: white;'
    key.style.cssText = keyStyleString
    key.addEventListener 'mousedown', ->
      playing = true
      playFreeKey tone
      return
    key.addEventListener 'mouseup', ->
      playing = false
      stopFreeKey tone
      return
    key.addEventListener 'mouseleave', ->
      if playing
        stopFreeKey tone
      return
    key.addEventListener 'mouseenter', ->
      if playing
        playFreeKey tone
      return
    document.getElementById('keyboard').appendChild key
    return
  ).bind(this)
  return

playFreeKey = (tone) ->
  if !freeNotes[tone] and powerOn
    key = document.getElementById(tone)
    freq = Tones[tone]
    note = new Note(freq)
    note.start 'free'
    freeNotes[tone] = note
    key.style.cssText += 'box-shadow: -1px 2px 0px 2px;'
  return

stopFreeKey = (tone) ->
  key = document.getElementById(tone)
  key.style.cssText += 'box-shadow: 0px 0px 0px 0px;'
  if freeNotes[tone]
    freeNotes[tone].stop()
    freeNotes[tone] = null
  return

playChordKey = (tone) ->
  if !chordNotes[tone] and powerOn
    key = document.getElementById(tone)
    freq = Tones[tone]
    note = new Note(freq)
    note.start 'chord'
    chordNotes[tone] = note
  return

stopChordKey = (tone) ->
  key = document.getElementById(tone)
  if chordNotes[tone]
    chordNotes[tone].stop()
    chordNotes[tone] = null
  return

pushChordButton = (chord) ->
  chordElement = document.getElementById('chord-button-' + chord)
  chordElement.style.boxShadow = '0px 0px 0px 0px'
  chordElement.style.left = '1px'
  chordElement.style.top = '1px'
  return

unpushChordButton = (chord) ->
  chordElement = document.getElementById('chord-button-' + chord)
  chordElement.style.boxShadow = '1px 1px 0px 1px'
  chordElement.style.left = '0px'
  chordElement.style.top = '0px'
  return

keyDownHandler = (e) ->
  if powerOn
    e.preventDefault()
  tones = keycodeToNotes[Number(e.keyCode)]
  if tones and tones.length == 1
    if Tones[tones[0]]
      playFreeKey tones[0]
  else if tones and tones.length > 1
    chordName = keycodeToChordName[e.keyCode]
    pushChordButton chordName
    tones.forEach (tone) ->
      if Tones[tone]
        playChordKey tone
      return
  return

keyUpHandler = (e, tones) ->
  `var tones`
  tones = keycodeToNotes[Number(e.keyCode)]
  if tones and tones.length == 1
    if Tones[tones[0]]
      stopFreeKey tones[0]
  else if tones and tones.length > 1
    chordName = keycodeToChordName[e.keyCode]
    unpushChordButton chordName
    tones.forEach (tone) ->
      if Tones[tone]
        stopChordKey tone
      return
  return

setupKeyboardElement = (widgetWidth, widgetHeight) ->
  keyboardElement = document.createElement('div')
  keyboardElement.id = 'keyboard'
  keyboardStyleString = 'display: inline-block;' + 'margin-top: ' + widgetHeight / 30 + 'px;' + 'margin-left: ' + widgetWidth / 10 + 'px;' + 'overflow: hidden;' + 'position: relative;'
  keyboardElement.style.cssText = keyboardStyleString
  document.getElementById('synth-widget').appendChild keyboardElement
  return

setupSynthWidgetElement = ->
  synthWidgetElement = document.getElementById('synth-widget')
  synthWidgetStyleString = 'background-color: brown;' + 'width: ' + synthWidgetElement.getAttribute('width') + 'px;' + 'height: ' + synthWidgetElement.getAttribute('height') + 'px;' + 'text-align: center;' + 'position: relative;' + 'overflow: hidden;'
  synthWidgetElement.style.cssText = synthWidgetStyleString
  return

setupPowerButtonElement = (widgetWidth, widgetHeight) ->
  powerButtonElement = document.createElement('div')
  powerButtonStyleString = 'width: ' + widgetWidth / 20 + 'px;' + 'height: ' + widgetHeight / 15 + 'px;' + 'background: ' + powerButtonColor() + ';' + 'position: absolute;' + 'right: ' + widgetWidth / 40 + 'px;' + 'bottom: ' + widgetHeight / 150 + 'px;' + 'box-shadow: 0px 0px 1px 1px;'
  powerButtonElement.style.cssText = powerButtonStyleString
  powerButtonElement.id = 'power-button'
  document.getElementById('synth-widget').appendChild powerButtonElement
  powerButtonElement.addEventListener 'click', flipPowerSwitch
  return

setupWaveButtons = (widgetWidth, widgetHeight) ->
  buttonPanelElement = document.createElement('div')
  buttonPanelStyleString = 'position: absolute;' + 'height: ' + widgetHeight / 15 + 'px;' + 'left: ' + widgetWidth / 10 + 'px;' + 'bottom: ' + widgetHeight / 100 + 'px;' + 'text-align: center;'
  buttonWidth = widgetWidth / 15
  buttonHeight = widgetHeight / 15
  buttonStyleString = 'width: ' + buttonWidth + 'px;' + 'height: ' + buttonHeight + 'px;' + 'margin-left: ' + widgetWidth / 40 + 'px;' + 'margin-right: ' + widgetWidth / 40 + 'px;'
  buttonPanelElement.style.cssText = buttonPanelStyleString
  buttonPanelElement.id = 'button-panel'
  document.getElementById('synth-widget').appendChild buttonPanelElement
  setupWave buttonWidth, buttonHeight, buttonStyleString, 'sine_oleix7', 'sine'
  setupWave buttonWidth, buttonHeight, buttonStyleString, 'square_i8z8xq', 'square'
  setupWave buttonWidth, buttonHeight, buttonStyleString, 'sawtooth_zzoxij', 'sawtooth'
  setupWave buttonWidth, buttonHeight, buttonStyleString, 'triangle_s1ersy', 'triangle'
  return

setupWave = (width, height, styleString, picString, type) ->
  waveElement = document.createElement('img')
  waveElement.style.cssText = styleString
  waveElement.src = 'http://res.cloudinary.com/ddhru3qpb/image/upload/w_' + width + ',h_' + height + '/' + picString + '.png'
  waveElement.id = type
  waveElement.addEventListener 'click', (e) ->
    changeWave type
    return
  document.getElementById('button-panel').appendChild waveElement
  return

setupChordButtons = (widgetWidth, widgetHeight) ->
  chordPanelElement = document.createElement('div')
  chordPanelStyleString = 'position: absolute;' + 'width: ' + widgetWidth / 10 + 'px;' + 'height: ' + widgetHeight * 13 / 15 + 'px;' + 'top: ' + widgetHeight / 60 + 'px;' + 'left: ' + widgetWidth / 160 + 'px;' + 'text-align: center;'
  chordPanelElement.style.cssText = chordPanelStyleString
  chordPanelElement.id = 'chord-panel'
  document.getElementById('synth-widget').appendChild chordPanelElement
  buttonWidth = Math.min(widgetWidth / 30, widgetHeight / 20)
  buttonHeight = buttonWidth
  chordButtonElement = undefined
  chordButtonStyleString = 'width: ' + buttonWidth + 'px;' + 'height: ' + buttonHeight + 'px;' + 'border-radius: ' + buttonWidth / 2 + 'px;' + 'background: goldenrod;' + 'display: inline-block;' + 'margin: ' + buttonWidth / 4 + 'px;' + 'margin-bottom: 0px;' + 'box-shadow: 1px 1px 0px 1px;' + 'font-size: ' + buttonWidth / 2 + 'px;' + 'line-height: ' + buttonWidth + 'px;' + 'position: relative;'
  i = 0
  while i < 24
    chordButtonElement = document.createElement('div')
    chordButtonElement.style.cssText = chordButtonStyleString
    chordButtonElement.className = 'chord-button'
    chordButtonElement.id = 'chord-button-' + Chords[i]
    chordButtonElement.innerHTML = Chords[i]
    document.getElementById('chord-panel').appendChild chordButtonElement
    i++
  return

changeWave = (type) ->
  if powerOn
    document.getElementById(wave).style.outline = '0px'
    wave = type
    document.getElementById(wave).style.outline = '1px solid yellow'
  return

powerButtonColor = ->
  if powerOn
    'green'
  else
    'red'

flipPowerSwitch = ->
  if powerOn
    turnSynthOff()
  else
    turnSynthOn()
  return

turnSynthOn = ->
  ctx = new ((window.AudioContext or window.webkitAudioContext))
  powerOn = true
  powerButtonElement = document.getElementById('power-button')
  powerButtonElement.style.cssText += 'background: green;'
  changeWave 'sine'
  return

turnSynthOff = ->
  ctx.close()
  powerOn = false
  powerButtonElement = document.getElementById('power-button')
  powerButtonElement.style.cssText += 'background: red;'
  document.getElementById(wave).style.outline = '0px'
  return

main = ->
  synthWidgetElement = document.getElementById('synth-widget')
  widgetWidth = synthWidgetElement.getAttribute('width') or 600
  widgetHeight = synthWidgetElement.getAttribute('height') or 300
  setupSynthWidgetElement()
  setupKeyboardElement widgetWidth, widgetHeight
  createKeys widgetWidth, widgetHeight
  setupPowerButtonElement widgetWidth, widgetHeight
  setupWaveButtons widgetWidth, widgetHeight
  setupChordButtons widgetWidth, widgetHeight
  turnSynthOn()
  document.addEventListener 'keydown', keyDownHandler
  document.addEventListener 'keyup', keyUpHandler
  return

main()

# ---
# generated by js2coffee 2.2.0
