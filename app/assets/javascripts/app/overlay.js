/*
Call the plugin with $('jquery-selector').cloverlay({});
*/

(function($) {
    var CLOverlay = function(el, opts) {
        //Defaults are below
        var settings = $.extend({}, $.fn.cloverlay.defaults, opts),
            $win = $(window),
            $c,
            $o,
            hash = false,
            height = 0,
            width = 0,
            minY = 200,
            tries = 0;

        // private methods
        function init() {
            $(el).click(show);
        }
        function noShow(e){
            if (hash) {
                window.location.hash = '!';
                hash = false;
            }
            $o.remove();
            $c.remove();
        }
        function show(e) {
            e.preventDefault();
            var $el = $(this);
            height = $el.data('height') || 400;
            width = $el.data('width') || 500;

            if ($el.data('url') !== undefined && $el.data('url') !== '') {
                hash = true;
                window.location.hash = $el.data('url');
            }

            if ($win.width() < width + 40) {
                window.location = $el.attr('href');
                return;
            }
            $o = $('<div/>');
            $o
                .addClass('overlay')
                .click(noShow);

            $c = $('<div/>');
            var src = $(this).prop('href');
            $c
                .css({ top: -height - 20 })
                .addClass('overlay-content')
                .html('<a href="javascript:;" class="close ico-cancel"></a><iframe src="' + src + '?over=true" width="' + width + '" height="' + height + '" frameBorder="0" scrolling="no"></iframe>');

            $('body').append($o, $c);

            $c
                .find('a.close')
                .click(noShow);

            $o.show();
            ani();
        }
        function ani() {
            var w = $c.width();
            if (w <= 10) {
                ++tries;
                if (tries < 20) {
                    requestTimeout(ani, 500);
                }
                return;
            }
            $c
                .css(getMargin(w))
                .show()
                .animate({ top:getTarY() }, 250);
        }
        function getMargin(w) {
            return { 'margin-left': -parseInt(w * 0.5, 10) };
        }
        function getTarY() {
            return Math.floor(Math.min(Math.max(0, $win.height() * 0.5 - $c.height() * 0.5), minY));
        }
        init();
    };
    $.fn.cloverlay = function(options) {
        return this.each(function(idx, el) {
            var $el = $(this), key = 'cloverlay';
            if ($el.data(key)) { return; }
            var cloverlay = new CLOverlay(this, options);
            $el.data(key, cloverlay);
        });
    };
    // default settings
    $.fn.cloverlay.defaults = {  };
})(jQuery);

var OVRLY = (function($) {
    return {
        cleanup: function() {
            $('.overlay,.overlay-content').remove();
        }
    };
} (jQuery));
