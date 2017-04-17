# // This is a manifest file that'll be compiled into application.js, which will include all the files
# // listed below.
# //
# // Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# // or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
# //
# // It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# // compiled file.
# //
# // Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# // about supported directives.
# //
#= require jquery
#= require jquery_ujs
#= require jquery.turbolinks
#= require jquery.knob
#= require bootstrap-sprockets
#= require moment
#= require fullcalendar
#= require lodash
#= require widget
#= require widget2
#= require welcomes
#= require flipclock.min
#= require bootstrap-datetimepicker
#= require turbolinks
#= require init
#= require app.chart
$ ->
  $('[data-toggle="popover"]').popover({
    template:  '<div class="popover" role="tooltip">
                  <div class="popover-arrow"></div>
                  <h3 class="popover-title"></h3>
                  <div class="popover-content"></div>
                </div>',
    trigger: 'hover',
    container: 'body'})
  return
