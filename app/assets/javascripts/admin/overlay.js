var OVERLAY = (function($){
    var app = { close: 'OVERLAY:close' },
        $o,
        $c,
        $win = $(window),
        cls = 'overlay',
        closeLink = '<a href="javascript:;" class="close">x</a>',
        isVisible = false,
        tarY = 0,
        minY = 200,
        aniY = 350,
        fadeAni = 250,
        tarH = 560,
        tarW = 840;

    app.hide = function (trigger) {
        trigger = trigger || false;

        if ($c !== undefined) {
            $c.remove();
            $o.remove();
        }
        isVisible = false;
        if (trigger) { $win.on(app.close); }
    };
    app.position = function() {
        if (!isVisible) { return; }
        $c
            .css(getMargin($c.width()));
        aniContent(0);
    };
    app.show = function(html, update, h, w){
        update = update || false;
        h = h || tarH;
        w = w || tarW;
        if (update && isVisible) {
            $c.html(closeLink);
            $c
                .width(w)
                .css(getMargin(w))
                .append(html);
            $(html)
                .hide()
                .fadeIn(sh);
        } else {
            app.hide(false);
            $c = $('<div>' + closeLink + '</div>');
            $c
                .addClass(cls)
                .width(w)
                .css(getMargin(w))
                .append(html);
            show();
        }
    };
    app.showURL = function(url, h, w){
        app.hide(false);
        h = h || tarH;
        w = w || tarW;
        $c = $('<div>' + closeLink + '<iframe src="' + url + '" height="' + h + '" width="' + (w - 20) + '" frameBorder="0"></iframe></div>');
        $c
            .addClass(cls)
            .width(w)
            .css(getMargin(w));
        show();
    };
    // privates
    function aniContent(d) {
        d = d || fadeAni;
        $c
            .stop()
            .delay(d)
            .show()
            .animate({ top:getTarY() }, aniY, onShow);
    }
    function init() {
        $(window).resize(app.position);
    }
    function show() {
        if (isVisible) {
            aniContent();
        } else {
            $c.css({ top:-700 });
            $o = $('<div id="' + cls + '"></div>');
            $('body').append($o, $c);
            $o.fadeTo(fadeAni, 0.65);
            aniContent();
        }
    }
    function onShow() {
        if(isVisible) { return; }

        $o.click(app.hide);
        $c
            .find('.close')
            .off('click')
            .on('click', app.hide);
        isVisible = true;
    }
    function getMargin(w) {
        return { 'margin-left': -parseInt(w * 0.5, 10) };
    }
    function getTarY() {
        return Math.floor(Math.min(Math.max(0, $win.height() * 0.5 - $c.height() * 0.5), minY));
    }
    $(init);
    return app;
} (jQuery));
