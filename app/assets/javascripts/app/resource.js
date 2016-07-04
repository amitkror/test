
var RESOURCE = (function($) {
    var app = {},
        $el,
        map;

    // Private functions
    function init() {
        if (typeof LAT === 'undefined') { return; }
        var options = {
            zoom: 14,
            center: new google.maps.LatLng(LAT, LONG),
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            disableDefaultUI: true
        };
        map = new google.maps.Map(document.getElementById("map"), options);
        var marker = new google.maps.Marker({
            position: options.center,
            title:TITLE,
            map: map,
            animation: true,
            flat: false,
            optimized: false,
            icon: '/assets/icons/map.png'
        });
    }
    $(init);
    return app;
} (jQuery));
