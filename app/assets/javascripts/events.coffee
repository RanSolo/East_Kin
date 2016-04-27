# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  calendar = $("#calendar")
  venueName = $('.venue-name')
  # page is now ready, initialize the calendar...
  $('.datetimepicker').datetimepicker()
  $('.datetimepicker').datetimepicker
    useCurrent: false
  $('#datetimepicker6').on 'dp.change', (e) ->
    $('#datetimepicker7').data('DateTimePicker').minDate e.date
    return
  $('#datetimepicker7').on 'dp.change', (e) ->
    $('#datetimepicker6').data('DateTimePicker').maxDate e.date
    return
  $('#calendar').fullCalendar
    events:
      url:'/events.json'
      textColor: "white"
    selectable: true
    eventRender: (event, element, view) ->
      element.prepend(event.start_time)
      element.append(event.artist)
