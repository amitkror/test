
var RESOURCE_SUGGESTION = (function($) {
    var app = {},
        $el,
        defaultText = 'Max size is 5MB. Only PDF, DOC, and PPT files are accepted.';

    // Private functions
    function init() {
        $('#resource_suggestion_attachment').customFile({
            callback: onCustomFile,
            status: true,
            text: 'Upload File',
            root: 'p',
            startStatus: defaultText
        });
    }
    function onCustomFile (e) {
        $el = $('.custom-file-feedback');
        if ($el.text() === "") {
            $el.text(defaultText);
        }
    }
    $(init);
    return app;
} (jQuery));
