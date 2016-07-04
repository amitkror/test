
var FOLDERS = (function($) {
    var app = {},
        $el,
        selector = '.folder',
        speed = 'fast';

    // Private functions
    function init() {
        $('.cancel').live('click', closeForm);
        $('.change').live('click', openForm);
        $('.delete a.delete').live('click', confirmDelete);
    }
    function openForm(e) {
        e.preventDefault();
        $el = $(this);
        $el
            .parent()
            .slideUp(speed);
        $el
            .closest(selector)
            .find('form.edit')
            .slideDown(speed);
    }
    function closeForm(e) {
        e.preventDefault();
        app.close($(this).closest(selector));
    }
    function confirmDelete(e) {
        e.preventDefault();
        $el = $(this);
        $el
            .parent().parent()
            .slideUp(speed);
        $el
            .closest(selector)
            .find('form.destroy')
            .slideDown(speed);
    }
    app.close = function($targ) {
        $targ
            .find('form')
            .slideUp(speed);
        $targ
            .find('.details')
            .slideDown(speed);
    };
    $(init);
    return app;
} (jQuery));
