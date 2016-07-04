var EVENTS = (function($) {
    var app = {},
        $el,
        $cal = $('#datepicker'),
        dates = [],
        on = 'on',
        date,
        initted = false,
        monthHash = {
          'January': 1,
          'February': 2,
          'March': 3,
          'April': 4,
          'May': 5,
          'June': 6,
          'July': 7,
          'August': 8,
          'September': 9,
          'October': 10,
          'November': 11,
          'December': 12
        },
        month,
        year,
        testing = false;

    // Public functions
    function init() {
      if(!$cal.length) { return; }
       date = new Date(req_date);
       var  YEAR = date.getFullYear(),
            MONTH = date.getMonth(),
            DAY = date.getDate(),
            URL = '/events.json';

        $.ajax({
            url: URL,
            type: 'GET'
        }).success(onDatesReturned);
    }

    function getByMonth(e) {
      month = monthHash[$cal.find('.ui-datepicker-month').text()];
      year = $cal.find('.ui-datepicker-year').text();

      onSelectMonth(year, month)
    }

    function onSelectMonth(y, m) {
      location.href = '/events/' + y + '/' + m;
    }

    // Private functions

    function initCalendar() {
        $cal.datepicker({
            onSelect: onSelect,
            onChangeMonthYear: onChangeMonthYear,
            beforeShowDay: onBeforeShow
        });
        $cal.datepicker('setDate', date);
        initted = true;

        $('.ui-datepicker-title').on('click', getByMonth);
    }

    function onBeforeShow(dt) {
        var m = dt.getMonth() + 1,
        d = dt.getDate(),
        mtch = (m < 10 ? '0' : '') + m + '/' + (d < 10 ? '0' : '') + d + '/' + dt.getFullYear();

        if ($.inArray(mtch, dates) > -1) {
           return [true, on]; // add a class to days that are in the dates array.
        } else {
           return [false];
        }
    }
    function onChangeMonthYear(y, m) {
        $cal.datepicker('disable');
        $.ajax({
          url: '/events.json',
          type: 'GET'
        }).success(onDatesReturned);
    }
    function onDatesReturned(r) {
        dates = r.dates; // response example: {'dates':['6/20/2011','6/21/2011']}
        if (initted) {
            $cal.datepicker('refresh');
            $cal.datepicker('enable');
            $('.ui-datepicker-title').on('click', getByMonth);
        } else {
            initCalendar();
        }
    }
    function onSelect(date, inst) {
      var sel = new Date(date);
      location.href = ['/events', sel.getFullYear(), (sel.getMonth() + 1), sel.getDate()].join('/');
    }
    // Call the init function on load
    $(init);
    return app;
} (jQuery));
