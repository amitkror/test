//= require jquery_ujs
//= require ./bookmarks
//= require ./bootstrapfile
//= require ./new_design
//= require ./overlay
//= require ./slideshow
//= require ./blog
//= require ./responsive
//= require ../libs/log
//= require ../libs/request_interval
//= require ../libs/jquery.custom-check
//= require ../libs/jquery.custom-select
//= require ../libs/jquery.rollovers
//= require ../libs/jquery.sticky-float
//= require ../libs/jquery.toggler
//= require ../libs/jquery.smartresize
//= require ../libs/tooltip
//= require zeroclipboard

var APP = (function($) {
    var app = {
            LOADER: 'small-loader'
        },
        $el,
        $win = $(window),
        $back = $('#back-to-top'),
        on = 'on',
        backShowing = false,
        top = 0,
        tarTop = 0,
        translateSrc = '//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit';

    function init() {
        $('a[href=#]').attr('href', 'javascript:;');

        // Open links starting with "http(s)://" in a new window unless they're targeted at this host.
        $("a[href^=http]").click(open);

        // Set up the global ajax
        $.ajaxSetup({ cache: false, error: function errorLog(x, e) { log(x, e); }, type: 'POST' });

        if (!Modernizr.input.placeholder) { placeholder(); }

        yepnope([{
            test:Modernizr.csstransitions,
            nope:'/assets/app/css3.js'
        }]);

        // Header, layout, and footer events
        $('#translate').click(onTranslate);
        $("#login form")
            .bind("ajax:error", onLoginError);
        $('#login a:first')
            .mouseenter(onFormEnter);
        $('.remember').change(onRememberMe);
        blocks();
        emails();

        // Call our plugins
        $('input.custom').customCheck();

        $('select.custom-select').customSelect();

        $('.ovly').cloverlay();

        $('.tip').tooltip();

        $('#slideshow').slideshow();

        // set up any FAQs
        if ($('#faqs').length > 0) {

            $('#faqs .faq').click(onFAQ);

            var id = window.location.hash.split('?faq=').join('');

            if (id !== "#?" && $(id).length > 0) {
                $(id).click();
            }
        }
        // Set up the back button if it exists
        if ($back.length > 0){
            $back.click(backToTop);
            $back.stickyfloat({ duration:0, stickToBottom:true, offsetY:30 });
            $win.scroll(app.scrollsies);
            tarTop = $($back.data('target')).offset().top - 50;
        }

        $('.with-rollover').rollovers();
        //
        //
        // Set up the ajax stuff to share folders via ajax-filled popups.
        APP.shareFolders();
        //
    }
    //
    // Following block is all for folder sharing dialogs
    //
    app.shareFolders = function(){
        // alert('yup');
        if (typeof(FolderShare) !== 'undefined' && FolderShare == true){
            // alert(FolderShare);
            //
            $('body').append('<div id="folder-share-mask" class="fpopup"><div class="overlay-content window" id="feature-folder-popup"></div></div>');
            // console.log(FolderID);
            // $('#popup-folder-share-trigger').click();

            $('#popup-folder-share-trigger').click(openSharePopup);

            $('#feature-folder-popup a.close').click(APP.closePopup);
            $('.fpopup').click(APP.closePopup);
            $('div#feature-folder-popup').click(function(e) {
                e.stopPropagation();
            });
        }
    }
    app.closePopup = function(){
        $('#feature-folder-popup').empty();
        $('#folder-share-mask').removeClass('open');
        $('body').css('overflow','auto');
        APP.fillSharePopup(FolderID);
    }
    app.fillSharePopup = function(FolderID){
        // $('#folder-share-mask').addClass('open');

        $.get("/profile/folder_recommendations/new?folderID="+FolderID);//Sorry no way around it
        // $.ajax({
        //   url: "/profile/folder_recommendations/new",
        //   data: data,
        //   success: success,
        //   dataType: dataType
        // });
    }
    function openSharePopup(){
        $('#folder-share-mask').addClass('open');
        $('body').css('overflow', 'hidden');
    }
    //
    //
    //
    function blocks() {
        $('.col-1 .block.hover').each(function(){
            var $el = $(this).find('img');
            if ($el.width() < 10) {
                setTimeout(blocks, 500);
                return;
            }
            $el.css({ 'margin-left': -($el.width() - 212) * 0.5 });
        });

        $('.block.hover').each(function(){
            var $block = $(this).find('img');
            if ($block.height() < 10) {
                setTimeout(blocks, 500);
                return;
            }
            $(this)
                .find('span')
                .css({ height: $block.outerHeight() + 28 });

        });
    }
    function backToTop(e) {
        e.preventDefault();
        $el = $(this);
        var targ = $($el.data('target'));
        $('html,body').animate({ scrollTop: targ.offset().top - 50 }, 250);
    }
    function onFAQ(e) {
        e.preventDefault();
        $el = $(this);
        if (!$el.hasClass(on)) {
            window.location.hash = "?faq=" + $el.attr('id');
            //document.cookie = 'faq=' + $el.attr('id');
        } else {
            window.location.hash = "?";
        }
        $(this)
            .next()
            .slideToggle('fast');
        $(this).toggleClass(on);
    }
    // header, layout, and footer
    function onFormEnter(e){
        if (Modernizr.input.placeholder) {
            $(this)
                .parent()
                .find('input:visible')[0]
                .focus();
        }
    }
    function onLoginError(e, d, st, xhr) {
        $('#login-error')
            .text(d.responseText)
            .fadeTo(250, 1);
    }
    function onRememberMe(e) {
        $el = $(this)
            .parent()
            .parent()
            .find('#remember-msg');

        if ($(this).is(':checked')) {
            $el.fadeTo(240, 1);
        } else {
            $el.slideUp('fast');
        }
    }
    function onTranslate(e) {
        e.preventDefault();
        $(this).replaceWith('<p id="' + APP.LOADER + '"><img src="/assets/loader-small.gif" alt="loading" title="loading" /></p>');

        Modernizr.load([
            {
                load: translateSrc,
                complete: function () {
                    $('#google_translate_element').show();
                }
            }
        ]);
    }
    // helper funcs
    function emails() {
        $('.e').each(function(idx, el){
            $el = $(this);
            var e = $el.text().split('//').join('.').split('/').join('@');
            $el.after('<a href="mailto:' + e + '">' + e + '</a>');
            $el.remove();
        });
    }
    function open(e) {
        e.preventDefault();
        var href = this.getAttribute("href");
        if (window.location.host !== href.split('/')[2]) {
            window.open(href);
        } else {
            window.location = href;
        }
    }
    function placeholder() {
        var attr = 'placeholder';
        $('html').addClass('no-' + attr);
        $('input[' + attr + '!=""]').each(function(idx, el){
            $el = $(el);
            var d = $el.attr(attr);
            if (d === undefined || $el.attr('type') == "password") { return; }
            $el
                .focus(function onFocus() {
                    $(this).removeClass(attr);
                    if (this.value === d) { this.value = ''; }
                })
                .blur(function onBlur() {
                    if ($.trim(this.value) === '') {
                        $(this).addClass(attr);
                        this.value = d;
                    }
                }).blur();
        });
    }
    app.scrollsies = function (e) {
        if ($win.scrollTop() > tarTop){
            $back.addClass(on);
        } else {
            $back.removeClass(on);
        }
    };
    // Call the init function on load
    $(init);
    return app;
} (jQuery));

/* Google analytics */
var gaact = 'UA-34634149-1',
    _gaq=[['_setAccount',gaact],['_trackPageview']];

(function(d,t){
    var g=d.createElement(t),
        s=d.getElementsByTagName(t)[0];
    g.type = 'text/javascript';
    g.async = true;
    g.src = ('https:' == d.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
    s.parentNode.insertBefore(g,s);
}(document,'script'));

/* Google translate */
function googleTranslateElementInit() {
    $('#' + APP.LOADER).remove();

    new google.translate.TranslateElement({
            pageLanguage: 'en',
            layout: google.translate.TranslateElement.InlineLayout.SIMPLE,
            gaTrack: true,
            gaId: gaact
        },
        'google_translate_element');
}

var DOWNLOADS = (function($) {
    var app = {},
        $el;

    function init() {
        var types = [
            //{ ext:'id', evt:'By Id' },
            { ext:'jpg', evt:'Image' },
            { ext:'jpeg', evt:'Image' },
            { ext:'png', evt:'Image' },
            { ext:'gif', evt:'Image' },
            { ext:'pdf', evt:'PDF' },
            { ext:'ppt', evt:'PowerPoint' },
            { ext:'pptx', evt:'PowerPoint' },
            { ext:'xls', evt:'Excel' },
            { ext:'xlsx', evt:'Excel' },
            { ext:'doc', evt:'Word Document' },
            { ext:'docx', evt:'Word Document' },
            { ext:'zip', evt:'Zip Files' }
        ];

        for (var i = 0; i< types.length; ++i) {
            track(types[i]);
        }
    }

    function track(obj){
        $('a[href$=".' + obj.ext + '"]').click(function(){
            //console.log(obj.evt, this.href);
            _gaq.push(['_trackEvent', 'Download', obj.evt, this.href]);
        });
    }

    // Call the init function on load
    $(init);
    return app;
} (jQuery));


var TRACK = (function($) {
    var app = {},
        $el;

    function init() {
        var tracks = [
            { sel:'#signup button', name:'newuser', text:'sign up hover button' },
            { sel:'.bookmark', name:'loggedin', text:'saved resource' },
            { sel:'.helpful a', name:'loggedin', text:'helpful resource' },
            { sel: '#new_folder_email button', name:'loggedin', text:'folder emailed' },
            { sel: '.faq', name:'site action', text:'FAQ clicked' },
            { sel: '.external', name:'site action', text:'external resource' }
        ];

        for (var i = 0; i < tracks.length; ++i) {
            track(tracks[i]);
        }
    }

    function track(obj){
        //console.log('track', obj.sel, obj.name, obj.text);
        $(obj.sel).click(function(){
            //console.log('track it', obj.name, obj.text);
            _gaq.push(['_trackEvent', obj.name, obj.text, obj.text]);
        });
    }

    // Call the init function on load
    $(init);
    return app;
} (jQuery));
