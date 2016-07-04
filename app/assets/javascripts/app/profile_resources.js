//= require ../libs/nested_form
//= require ../libs/tiny_mce/jquery.tinymce

var PROFILE_RESOURCES = (function($){
    var app = {},
        on = 'on',
        $assetsList = $('#assets-list'),
        $resourceType = $('#resource_type_id'),
        $el;

    app.tiny_mce_settings = {
        // General options
        script_url: '/assets/libs/tiny_mce/tiny_mce.js',
        theme: "advanced",
        skin: "bbox",
        inlinepopups_skin: "bbox",
        mode: "specific_textareas",
        editor_selector: "mceEditor",
        height: "250px",
        width: "512px",
        plugins: "media,tabfocus,inlinepopups,paste,safari,table,fullscreen,imageselect,galleryselect,xhtmlxtras",
        // Theme options
        theme_advanced_buttons1: "styleselect,bold,italic,underline,bullist,|,link,unlink,|,selectall,pastetext,pasteword,charmap,|,undo,redo,cleanup,removeformat,fullscreen,|,code",
        theme_advanced_buttons2: "",
        theme_advanced_buttons3: "",
        theme_advanced_toolbar_location: "top",
        theme_advanced_toolbar_align: "left",
        theme_advanced_statusbar_location: "bottom",
        theme_advanced_resizing: true,
        theme_advanced_resize_horizontal: "",
        theme_advanced_blockformats: "p",
        tab_focus: ':prev,:next',
        button_tile_map: true,
        paste_create_linebreaks: false,
        paste_create_paragraphs: true,
        paste_auto_cleanup_on_paste: true,
        paste_convert_middot_lists: true,
        paste_convert_headers_to_strong: false,
        paste_remove_spans: true,
        paste_remove_styles: true,
        paste_strip_class_attributes: "all",
        paste_use_dialog: false,
        content_css: "/assets/tinymce.css",
        valid_elements : "@[id|class|style|title],a[rel|href|target|title|class],strong/b,em/i,strike,u," +
            "#p,-ol,-ul,-li,br,img[src|alt=|title|width|height],cite[title|id],-sub,-sup," +
            "-span,-h1,-h2,-h3,-h4,-h5,-h6,hr,",
        relative_urls: false
    };
    
    function init() {
        var id;

        $('textarea.tinymce').each(function createTinyMCE(){
            $(this).tinymce(app.tiny_mce_settings);
        });
        $assetsList.sortable({
            stop:onSorted
        });
        onSorted(null, $assetsList);
        
        $(window).on('nested:fieldAdded', onAdded);
        
        $resourceType.change(onTypeChange);
        onTypeChange();

        $('#resource_logo').customFile({
            callback: onCustomFile,
            status: true,
            text: 'Upload File',
            root: 'p'
        });
    }
    function onAdded(e) {
        // move the form around to where we want it.
        // $promoList.append(e.field);
        $el = $($(e.field)
                    .parent()
                    .data('target'));
        $el.append(e.field);
        onSorted(null, $el);
    }
    function onCustomFile (e) {
        $el = $('.custom-file-feedback');
        if ($el.text() === "") {
            $el.text(defaultText);
        }
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
    function onTypeChange(e) {
        $('.program-fields').hide();
        var id = parseInt($resourceType.val(), 10);
        if (id === 1) {
            $('.program-fields').show();
        }
    }
    $(init);
    return app;
} (jQuery));
