var SITE_SETTINGS = (function($) {
    var app = {},
        $fileList = $('#files-list'),
        $promoList = $('#promos-list'),
        $publicFolderList = $('#public-folders-list'),
        $quickLinkList = $('#quick-links-list'),
        $el;

    function init() {
        $fileList.sortable({
            axis:'y',
            stop:onSorted
        });
        $promoList.sortable({
            axis:'y',
            stop:onSorted
        });
        $publicFolderList.sortable({
            axis:'y',
            stop:onSorted
        });
        $quickLinkList.sortable({
            axis:'y',
            stop:onSorted
        });
        onSorted(null, $fileList);
        onSorted(null, $promoList);
        $(window).on('nested:fieldAdded', onAdded);
    }
    function choose() {
        $('.chosen:visible')
            .hide()
            .chosen();
    }
    function onAdded(e) {
        // move the form around to where we want it.
        // $promoList.append(e.field);
        $el = $($(e.field)
                    .parent()
                    .data('target'));
        $el.append(e.field);
        choose();
        onSorted(null, $el);
    }
    function onSorted(e, ui) {
        // if 'e' is passed in, it's from a sortable event
        var targ = e === null ? ui : $(e.target);
        targ.find('> li').each(function(idx, e){
            $(this)
                .find('.order')
                .val(idx);
        });
    }
    $(init);
    return app;
} (jQuery));
