(function() {
  $(function() {
    var calendar, venueName;
    calendar = $("#calendar");
    venueName = $('.venue-name');
    $('.datetimepicker').datetimepicker();
    $('.datetimepicker').datetimepicker({
      useCurrent: false
    });
    $('#datetimepicker6').on('dp.change', function(e) {
      $('#datetimepicker7').data('DateTimePicker').minDate(e.date);
    });
    $('#datetimepicker7').on('dp.change', function(e) {
      $('#datetimepicker6').data('DateTimePicker').maxDate(e.date);
    });
    return $('#calendar').fullCalendar({
      events: {
        url: '/events.json',
        textColor: "white"
      },
      selectable: true,
      eventRender: function(event, element, view) {
        element.prepend(event.start_time);
        return element.append(event.artist);
      }
    });
  });

}).call(this);
