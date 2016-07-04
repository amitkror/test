(function($) {
    var Slideshow = function(el, opts) {
        var app = {};
        //Defaults are below
        var settings = $.extend({}, $.fn.slideshow.defaults, opts),
            $el = $(el),
            $nav = $el.find('nav'),
            $cur = null,
            interval = {},
            cur = 0,
            on = 'on',
            sel = 'article',
            tot = 0,
            tries = 0;

        // private methods
        function init() {
            tot = $el.find(sel).length;
            $nav
                .find('a')
                .each(function(idx, a){
                    $(a)
                        .data('idx', idx)
                        .click(onById);
                });
            
            $cur = $el.find(sel + ':first');
            show();
            
            if (tot < 1) {
                $el.remove();
            } else if (tot > 1) {
                if (settings.auto) {
                    interval = requestInterval(onNext, settings.speed || 5000);
                }
                $nav.css({ marginLeft:-$nav.width() * 0.5 });
            }
        }
        function onById(e) {
            e.preventDefault();
            clearRequestInterval(interval);
            cur = $(this).data('idx');
            show();
        }
        function onNext() {
            ++cur;
            if (cur === tot) {
              cur = 0;
            }
            show();
        }
        function show() {
            var targ = $cur;
            $cur.
                stop()
                .fadeTo(150, 0, function(){
                    targ.hide();
                });

            $cur = $el.find(sel + ':nth-child(' + (cur + 1) + ')');
            
            if ($cur.width() <= 10) {
                ++tries;
                if (tries < 20) {
                    requestTimeout(show, 500);
                }
                return;
            }
            $cur
                .stop()
                .show()
                .fadeTo(250, 1);
            $nav
                .find('.' + on)
                .removeClass(on);
            $nav
                .find('li:nth-child(' + (cur + 1) + ') a')
                .addClass(on);
        }
        init();
    };
    $.fn.slideshow = function() {
        return this.each(function(idx, el) {
            var $el = $(this),
                key = 'slideshow';
            if ($el.data(key)) { return; }
            var slideshow = new Slideshow(this, {
                auto:$el.data('auto') === true,
                speed:$el.data('speed')
            });
            $el.data(key, slideshow);
        });
    };
    // default settings
    $.fn.slideshow.defaults = {
        auto:true,
        speed:6000
    };
})(jQuery);