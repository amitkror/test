var SCHOLARSHIP_SUBMISSION = (function($) {

    $.fn.pop = function() {
        var top = this.get(-1);
        this.splice(this.length-1,1);
        return top;
    };

    $.fn.shift = function() {
        var bottom = this.get(0);
        this.splice(0,1);
        return bottom;
    };

    var app = {},
        $el,
        $imgs = [];

    // Public functions
    function init() {
        $imgs = $('.img');
        if ($imgs.length > 0) {
            load();
        } else {
            initScroll();
        }
    }
    function initScroll() {
        $('.scrolling-content').tinyscrollbar();
        Modernizr.load('http://s7.addthis.com/js/250/addthis_widget.js#pubid=ra-503676452e9c1b7a');
    }
    function load() {
        if ($imgs.length > 0) {
            var i = $imgs.pop(),
                img = new Image();
            img.onload = load;
            img.src = $(i).attr('src');
        } else {
            initScroll();
        }
    }
    $(init);
    return app;
} (jQuery));