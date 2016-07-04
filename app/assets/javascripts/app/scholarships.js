
var SCHOLARSHIP = (function($) {
    var app = {},
        $el,
        defaultText = 'Max size is 10MB.';

    app.updateVoted = function(id, voted) {
        $('#submission-' + id).toggleClass('on', voted);
    };

    // Private functions
    function init() {
        if (isMobileBrowser()) {
            $('.scholarship-upload-hint').hide();
            $('.scholarship-upload-hint-mobile').show();
            return;
        }

        $('#scholarship_submission_document').customFile({
            callback: onCustomFile,
            status: true,
            text: 'Upload File',
            root: 'p',
            startStatus: defaultText
        });

        if (window.location.hash !== '') {
            $(window.location.hash).click();
        }
    }
    function onCustomFile (e) {
        $el = $('.custom-file-feedback');
        if ($el.text() === "") {
            $el.text(defaultText);
        }
    }
    function isMobileBrowser() {
        //http://stackoverflow.com/questions/3514784/what-is-the-best-way-to-detect-a-handheld-device-in-jquery
        return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
    }
    $(init);
    return app;
} (jQuery));
