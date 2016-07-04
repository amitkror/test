var CSS3 = (function($) {
    var app = {},
        $el;

    // Public functions
    function init() {
        $('#login, #signup')
            .mouseenter(onLoginOver)
            .mouseleave(onLoginLeave);
        
        $('.block.hover')
            .mouseenter(onBlockOver)
            .mouseleave(onBlockOut)
            .find('span').hide();
    }
    function onBlockOver(e){
        $(this).find('span, .harrow').stop().fadeTo(150, 1);
    }
    function onBlockOut(e){
        $(this).find('span, .harrow').stop().fadeTo(150, 0);
    }
    function onLoginOver(e) {
        $(this).find('form').show();
    }
    function onLoginLeave(e) {
        $(this).find('form').hide();
    }
    $(init);
    return app;
} (jQuery));
