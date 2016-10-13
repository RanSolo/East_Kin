DrawingCanvas =
window.DrawingCanvas = (id) ->
  @canvas = document.getElementById(id)
  @width = @canvas.width
  @height = @canvas.height
  @ctx = @canvas.getContext('2d')
  @prevX = 0
  @prevY = 0
  @currX = 0
  @currY = 0
  @rgbString = 'yellow'
  @ctx.lineJoin = @ctx.lineCap = 'round'
  @blankImageData = @getImageData()
  @history = [
    @blankImageData
    @blankImageData
    @blankImageData
    @blankImageData
    @blankImageData
    @blankImageData
  ]
  @drawing = true
  @stamping = true
  @color = '#000'
  @size = 10
  return

main = ->
  widget.setUpDrawingWidget()
  widget.setUpDrawingCanvas()
  widget.setUpColorPickerContainer()
  widget.setUpColorPicker()
  widget.setUpColorSample()
  widget.setUpSaveImage()
  widget.setUpClearImage()
  widget.setUpScaffolding()
  widget.initializeDrawingCanvas()
  widget.initializeColorCanvas()
  return

DrawingCanvas::mouseDown = (e, color, size) ->
  @drawInitialStroke()
  @drawing = true
  return

DrawingCanvas::mouseMove = (e) ->
  @prevX = @currX
  @prevY = @currY
  @currX = e.pageX - (@canvas.getBoundingClientRect().left)
  @currY = e.pageY - (@canvas.getBoundingClientRect().top)
  if @drawing
    @drawStroke()
  else
    @preview()
  return

DrawingCanvas::mouseUp = (e) ->
  if @drawing
    @saveFrame()
  @drawing = false
  return

DrawingCanvas::mouseWheel = (e) ->
  e.preventDefault()
  if e.deltaY > 0
    @scaleUp()
  else if e.deltaY < 0
    @scaleDown()

  @mouseMove e
  return

DrawingCanvas::mouseOut = (e) ->
  if @drawing
    @saveFrame()
    @drawing = true
  else
    @drawing = false
  @setToLastFrame()

  return

DrawingCanvas::scaleUp = ->
  @size = @size * 1.1
  return

DrawingCanvas::scaleDown = ->
  @size = @size / 1.1
  return

DrawingCanvas::setToLastFrame = ->
  @clear()
  @putImageData @history[@history.length - 1]
  return

DrawingCanvas::saveFrame = ->
  @history.shift()
  @history.push @getImageData()
  return

DrawingCanvas::setColor = (color) ->
  @color = color
  return

DrawingCanvas::setSize = (size) ->
  @size = size
  return

DrawingCanvas::undo = ->
  @history.unshift @history.pop()
  @setToLastFrame()
  return

DrawingCanvas::preview = ->
  @setToLastFrame()
  @previewStroke()
  return

DrawingCanvas::previewStroke = ->
  @ctx.globalAlpha = 0.4
  @ctx.beginPath()
  @ctx.moveTo @currX + 1, @currY + 1
  @ctx.lineTo @currX, @currY
  @ctx.strokeStyle = @color
  @ctx.lineWidth = @size
  @ctx.stroke()
  @ctx.closePath()
  @ctx.globalAlpha = 1.0
  return

DrawingCanvas::drawStroke = ->
  @ctx.beginPath()
  @ctx.moveTo @prevX, @prevY
  @ctx.lineTo @currX, @currY
  @ctx.strokeStyle = @color
  @ctx.lineWidth = @size
  @ctx.stroke()
  @ctx.closePath()
  return

DrawingCanvas::drawInitialStroke = ->
  @ctx.beginPath()
  @ctx.moveTo @currX + 1, @currY + 1
  @ctx.lineTo @currX, @currY
  @ctx.strokeStyle = @color
  @ctx.lineWidth = @size
  @ctx.stroke()
  @ctx.closePath()
  return

DrawingCanvas::clear = ->
  @ctx.clearRect 0, 0, @width, @height
  return

DrawingCanvas::getPNG = ->
  @canvas.toDataURL 'image/png'

DrawingCanvas::putImageData = (imageData) ->
  @clear()
  @ctx.putImageData imageData, 0, 0
  return

DrawingCanvas::hardReset = ->
  @clear()
  @history = [
    @getImageData()
    @getImageData()
    @getImageData()
    @getImageData()
    @getImageData()
    @getImageData()
  ]
  return

DrawingCanvas::getImageData = ->
  @ctx.getImageData 0, 0, @width, @height

ColorPicker =
window.ColorPicker = (id) ->
  @colorPickerCanvas = document.getElementById(id)
  @colorPickerContext = @colorPickerCanvas.getContext('2d')
  @width = @colorPickerCanvas.width
  @height = @colorPickerCanvas.height
  pickerImg = new Image
  pickerImg.crossOrigin = 'Anonymous'
  pickerImg.src = 'http://res.cloudinary.com/ddhru3qpb/image/upload/w_' + @width + ',h_' + @height + '/color-picker-80-500_uyhcxj.png'
  pickerImg.onload = (->
    @colorPickerContext.drawImage pickerImg, 0, 0
    return
  ).bind(this)
  return

ColorPicker::pickColor = (e) ->
  x = e.clientX - (@colorPickerCanvas.getBoundingClientRect().left)
  y = e.clientY - (@colorPickerCanvas.getBoundingClientRect().top)
  imgData = @colorPickerContext.getImageData(x, y, 1, 1).data
  rgbArray = [].slice.call(imgData, 0, 3)
  @rgbString = 'rgb(' + rgbArray.join(',') + ')'
  @rgbString

ColorPicker::color = ->
  @rgbString

Widget = ->
  @drawingWidgetElement = document.getElementById('drawing-widget')
  @drawingCanvasElement = document.createElement('canvas')
  @colorPickerContainer = document.createElement('div')
  @colorPickerElement = document.createElement('canvas')
  @colorSampleElement = document.createElement('div')
  @saveImageElement = document.createElement('button')
  @saveImagePicture = document.createElement('img')
  @clearImageElement = document.createElement('button')
  @clearImagePicture = document.createElement('img')
  @widgetWidth = @drawingWidgetElement.getAttribute('width') or window.innerWidth * 9/10
  @widgetHeight = @drawingWidgetElement.getAttribute('height') or window.innerHeight
  return

Widget::setSize = (element, width, height) ->
  element.style.width = '95%'
  element.style.height = height + 'px'
  return

Widget::setUpDrawingWidget = ->
  @setSize @drawingWidgetElement, @widgetWidth, @widgetHeight
  return

Widget::setUpDrawingCanvas = ->

  @drawingCanvasElement.setAttribute 'width', @widgetWidth
  @drawingCanvasElement.setAttribute 'height', @widgetHeight
  @drawingCanvasElement.id = 'drawing-canvas'
  return

Widget::setUpColorPickerContainer = ->
  @setSize @colorPickerContainer, @widgetWidth * 1/5, @widgetHeight * 3/5
  @colorPickerContainer.style.display = 'inline-block'
  @colorPickerContainer.style.position = 'absolute'
  @colorPickerContainer.id = 'color-picker-container'
  return

Widget::setUpColorPicker = ->

  @colorPickerElement.setAttribute 'width', @widgetWidth * 1 / 10
  @colorPickerElement.setAttribute 'height', @widgetHeight *4/5
  @colorPickerElement.id = 'color-picker'
  return

Widget::setUpColorSample = ->
  @setSize @colorSampleElement, @widgetWidth * 1 / 5, @widgetHeight * 1/ 5
  @colorSampleElement.style.background = 'black'
  @colorSampleElement.style.position = 'absolute'
  @colorSampleElement.style.bottom = '-80'
  @colorSampleElement.id = 'color-sample'
  return

Widget::setUpSaveImage = ->
  @saveImageElement.style.position = 'absolute'
  @saveImageElement.style.bottom = '3px'
  @saveImageElement.style.right = '3px'
  @saveImageElement.style.padding = '2px'
  @saveImageElement.style.borderRadius = '5px'
  @saveImageElement.id = 'save-image'
  floppySize = '60px'
  @saveImagePicture.src = 'http://res.cloudinary.com/ddhru3qpb/image/upload/w_' + floppySize + ',h_' + floppySize + '/save_tkicwp.png'
  return

Widget::setUpClearImage = ->
  @clearImageElement.style.position = 'absolute'
  @clearImageElement.style.bottom = '3px'
  @clearImageElement.style.left = '3px'
  @clearImageElement.style.padding = '2px'
  @clearImageElement.style.borderRadius = '5px'
  @clearImageElement.id = 'clear-image'
  newPageSize = @widgetWidth * 1 / 25
  @clearImagePicture.src = 'http://res.cloudinary.com/ddhru3qpb/image/upload/w_' + newPageSize + ',h_' + newPageSize + '/new_eolomw.png'
  return

Widget::setUpScaffolding = ->
  @drawingWidgetElement.appendChild @drawingCanvasElement
  @drawingWidgetElement.appendChild @colorPickerContainer
  @colorPickerContainer.appendChild @colorPickerElement
  @colorPickerContainer.appendChild @colorSampleElement
  @colorSampleElement.appendChild @saveImageElement
  @saveImageElement.appendChild @saveImagePicture
  @colorSampleElement.appendChild @clearImageElement
  @clearImageElement.appendChild @clearImagePicture
  return

Widget::initializeDrawingCanvas = ->
  @drawingCanvas = new DrawingCanvas('drawing-canvas')
  @drawingCanvasElement.addEventListener 'mousedown', @drawingCanvas.mouseDown.bind(@drawingCanvas), true
  @drawingCanvasElement.addEventListener 'mouseup', @drawingCanvas.mouseUp.bind(@drawingCanvas), true
  @drawingCanvasElement.addEventListener 'mousemove', @drawingCanvas.mouseMove.bind(@drawingCanvas), true
  @drawingCanvasElement.addEventListener 'mousewheel', @drawingCanvas.mouseWheel.bind(@drawingCanvas), true
  @drawingCanvasElement.addEventListener 'mouseout', @drawingCanvas.mouseOut.bind(@drawingCanvas), true
  return

Widget::initializeColorCanvas = ->
  @colorPicker = new ColorPicker('color-picker')
  @changingColor = false
  @colorPickerElement.addEventListener 'mousedown', ((e) ->
    @changingColor = true
    newColor = @colorPicker.pickColor.bind(@colorPicker, e)()
    @drawingCanvas.setColor.bind(@drawingCanvas, newColor)()
    @colorSampleElement.style.background = newColor
    return
  ).bind(this), true
  @colorPickerElement.addEventListener 'mouseup', ((e) ->
    @changingColor = false
    return
  ).bind(this), true
  @colorPickerElement.addEventListener 'mousemove', ((e) ->
    if @changingColor
      newColor = @colorPicker.pickColor.bind(@colorPicker, e)()
      @drawingCanvas.setColor.bind(@drawingCanvas, newColor)()
      @colorSampleElement.style.background = newColor
    return
  ).bind(this), true
  @saveImageElement.addEventListener 'click', ((e) ->
    imagePNG = @drawingCanvas.getPNG.bind(@drawingCanvas)()
    window.open imagePNG
    return
  ).bind(this), true
  @clearImageElement.addEventListener 'click', ((e) ->
    imagePNG = @drawingCanvas.hardReset.bind(@drawingCanvas)()
    return
  ).bind(this), true
  return

widget = new Widget
main()
