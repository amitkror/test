ADMIN.tiny_mce_settings = {
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
    theme_advanced_buttons1: "bold,italic,underline,bullist,|,link,unlink,|,selectall,pastetext,pasteword,charmap,|,undo,redo,cleanup,removeformat,fullscreen,|,code",
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
    content_css: "/assets/admin/tinymce.css",
    valid_elements : "@[id|class|style|title],a[rel|href|target|title|class],strong/b,em/i,strike,u," +
        "#p,-ol,-ul,-li,br,img[src|alt=|title|width|height],cite[title|id],-sub,-sup," +
        "-span,-h1,-h2,-h3,-h4,-h5,-h6,hr,",
    relative_urls: false
};


var PROMOS = (function($) {
    var app = {},
        $dd = $('#promo_instance_promo_id'),
        $color = $('#color'),
        $copy = $('#copy'),
        $img = $('.image'),
        $link = $('#link'),
        $twint = $('#twint'),
        $misc = $('#misc'),
        copy = 'promo_instance_copy',
        init_tiny = false;

    function init() {

        $dd
            .chosen()
            .change(onPromoChange)
            .change();
    }
    function onPromoChange(e) {
        $color.hide();
        $copy.hide();
        $img.hide();
        $link.hide();
        $twint.hide();
        $misc.hide();
        switch($dd.val()) {
            case "1":
                //$copy.hide();
                $img.show();
                $link.show();
                removeEditor();
            break;
            case "2":
                $img.show();
                $link.show();
                $copy.show();
                $misc.show();
                $twint.show();
                addEditor();
            break;
            case "3":
                $copy.show();
                //$img.hide();
                //$link.hide();
                addEditor();
            break;
            case "4":
                $copy.show();
                //$img.hide();
                //$link.hide();
                removeEditor();
            break;
            case "5":
                $copy.show();
                $twint.show();
                //$img.hide();
                $link.show();
                $misc.show();
                removeEditor();
            break;
            case "6":
                //$copy.hide();
                //$twint.hide();
                //$img.hide();
                $link.show();
                //$misc.hide();
                removeEditor();
            break;
            case "7":
                $copy.show();
                $twint.show();
                $img.show();
                $link.show();
                $misc.show();
                removeEditor();
            break;
            case "12":
                $color.show();
                $img.show();
                $link.show();
                $misc.show();
                removeEditor();
                $copy.show();
            break;
        }
    }
    function addEditor() {
        if (!init_tiny) {
            $('#' + copy).tinymce(ADMIN.tiny_mce_settings);
            init_tiny = true;
        } else {
            if (tinyMCE.get(copy)) { return; }
            tinyMCE.execCommand('mceAddControl', false, copy);
        }
    }
    function removeEditor() {
        if (!init_tiny || !window.tinyMCE) { return; }
        var ed = tinyMCE.get(copy);
        if (!ed) { return; }
        tinyMCE.execCommand('mceRemoveControl', false, copy);
    }
    $(init);
    return app;
} (jQuery));
