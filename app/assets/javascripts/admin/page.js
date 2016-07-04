var PAGE = (function($) {
    var app = {},
        $el = null,
        $pageType = $('#page_page_type_id'),
        $promoList = $('#promos-list'),
        $resourcesList = $('#resources-list'),
        $faqsList = $('#faqs-list'),
        on = 'on';

    app.updateGallery = function(id, img){
        var gs = $('.gallery-select').data('gallerySelect');
        gs.updateGallery(id, img);
    };
    function choose() {
        $('.chosen:visible')
            .hide()
            .chosen();
    }
    function init() {
        $('.gallery-select').gallerySelect();
        $promoList.sortable({
            axis:'y',
            handle: '.handle',
            stop:onSorted
        });
        $resourcesList.sortable({
            axis: 'y',
            handle: '.handle',
            stop:onSorted
        });
        $faqsList.sortable({
            axis: 'y',
            handle: '.handle',
            stop:onSorted
        });
        onSorted(null, $promoList);
        onSorted(null, $resourcesList);
        onSorted(null, $faqsList);
        $('form').on('nested:fieldAdded', onAdded);

        $pageType
            .change(onPageTypeChange);
        onPageTypeChange();
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
    function onPageTypeChange(e) {
        $('.phase-fields, .two-column-fields').hide();
        switch(parseInt($pageType.val(), 10)) {
            case 1: $('.two-column-fields').show(); break;
            case 2: $('.phase-fields').show(); break;
        }
        choose();
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

function UPDATE_GALLERY(id, img) {
    PAGE.updateGallery(id, img);
}