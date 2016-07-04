var FAQ = (function($) {
    var app = {},
        $el,
        $msg = $('#interior-search-form .msg');

    // Public functions
    function init() {
        $('#faq-query').autocomplete({
            minLength: 2,
            source: FAQ_SOURCE,
            select: onSelect,
            close: onClose,
            response: onResponse
        });
    }
    function onClose(e, ui) {
        $('#faq-query').val('');
    }
    function onResponse(evt, ui) {
        
        if (ui.content.length === 0) {
            $msg.text('No results found.');
        } else {
            $msg.text('');
        }
    }
    function onSelect(e, ui) {
        $el = $('#' + ui.item.value);
        
        if (!$el.hasClass('on')) { $el.click(); }

        $('html,body').animate({ scrollTop: $el.offset().top - 50}, 250);
    }
    $(init);
    return app;
} (jQuery));
