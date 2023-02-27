(function() {
  App.Chart = (function() {
    function Chart(el) {
      this.el = el;
    }

    Chart.prototype.render = function() {};

    return Chart;

  })();

  $(document).on("turbolinks:load", function() {
    var chart;
    chart = new App.Chart($("#restart-universe"));
    return chart.render();
  });

}).call(this);
