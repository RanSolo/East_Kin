class App.Chart
  constructor: (@el) ->
    # intialize some stuff

  render: ->
    # do some stuff

$(document).on "turbolinks:load", ->
  chart = new App.Chart $("#restart-universe")
  chart.render()
