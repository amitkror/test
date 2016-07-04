//= require ../libs/nested_form
//= require ../libs/chosen.jquery.min
//= require ../libs/jquery-ui-1.9.0.custom.min
//= require ../libs/tiny_mce/jquery.tinymce
//= require ../libs/bootstrap.dropdown
//= require ./gallery_select
//= require ./check_list
//= require ./overlay

var ADMIN = (function($){
    var app = {},
        on = 'on',
        $el;

    app.tiny_mce_settings = {
        // General options
        full : {
            script_url: '/assets/libs/tiny_mce/tiny_mce.js',
            theme: "advanced",
            skin: "bbox",
            inlinepopups_skin: "bbox",
            mode: "specific_textareas",
            editor_selector: "mceEditor",
            height: "350px",
            width: "600px",
            plugins: "media,tabfocus,inlinepopups,paste,safari,table,fullscreen,imageselect,galleryselect,xhtmlxtras",
            // Theme options
            theme_advanced_buttons1: "bold,italic,underline,styleselect,formatselect,|,bullist,numlist,hr,outdent,indent,blockquote,cite,|,link,unlink,anchor,imageselect,media,fullscreen",
            theme_advanced_buttons2: "justifyleft,justifyright,|,table,delete_table,row_props,cell_props,delete_col,col_after,col_before,delete_row,row_after,row_before,split_cells,merge_cells,|,selectall,pastetext,pasteword,charmap,|,undo,redo,cleanup,removeformat",
            theme_advanced_buttons3: "",
            theme_advanced_toolbar_location: "top",
            theme_advanced_toolbar_align: "left",
            theme_advanced_statusbar_location: "bottom",
            theme_advanced_resizing: true,
            theme_advanced_resize_horizontal: "",
            theme_advanced_blockformats: "p,h2,h3,h4,h5,h6,pre",
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
                "-blockquote,-table[border=0|cellspacing|cellpadding|width|height]," +
                "-tr[rowspan|width|height|align|valign],tbody,thead,tfoot," +
                "#td[colspan|rowspan|width|height|align|valign],#th[colspan|rowspan|width|height|align|valign]," +
                "-span,-h1,-h2,-h3,-h4,-h5,-h6,hr," +
                "object[classid|width|height|codebase|*],param[name|value|_value],embed[type|width|height|src|*],script[src|type]," +
                "iframe[scrolling|width|height|frameborder|src|allowfullscreen|*]",
            relative_urls: false
        },
        limited : {
            script_url: '/assets/libs/tiny_mce/tiny_mce.js',
            theme: "advanced",
            skin: "bbox",
            inlinepopups_skin: "bbox",
            mode: "specific_textareas",
            editor_selector: "mceEditor",
            height: "350px",
            width: "600px",
            plugins: "media,tabfocus,inlinepopups,paste,safari,table,fullscreen,imageselect,galleryselect,xhtmlxtras",
            // Theme options
            theme_advanced_buttons1: "bold,italic,link,unlink",
            theme_advanced_buttons2: "removeformat",
            theme_advanced_buttons3: "",
            theme_advanced_toolbar_location: "top",
            theme_advanced_toolbar_align: "left",
            theme_advanced_statusbar_location: "bottom",
            theme_advanced_resizing: true,
            theme_advanced_resize_horizontal: "",
            theme_advanced_blockformats: "p,h2,h3,h4,h5,h6,pre",
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
                "#p," +
                "-span",
            relative_urls: false
        }
    };

    function init() {
        var id;

        $('.date').datepicker({ dateFormat: 'yy-mm-dd' });

        $('.chosen:visible')
            .hide()
            .chosen();

        $('.check-list').checkList();

        $('form.status input').click(updateStatus);
        $('fieldset legend').click(toggleFieldSet);

        $('.permalink').bind('keyup unfocus blur update', onPermalinkKeyUp);

        $('textarea.tinymce:not(.limited)').each(function createTinyMCE(){
            $el = $(this);
            id = $el.attr('id');
            $el.tinymce(app.tiny_mce_settings.full);
            $el.after('<ul class="editor-toggles"><li><a class="on" href="#" data-id="' + id + '" data-type="visual">Visual</a></li><li><a href="#" data-id="' + id + '" data-type="html">HTML</a></li></ul>');
        });
        $('textarea.tinymce.limited').each(function createTinyMCE(){
            $el = $(this);
            id = $el.attr('id');
            $el.tinymce(app.tiny_mce_settings.limited);
            $el.after('<ul class="editor-toggles"><li><a class="on" href="#" data-id="' + id + '" data-type="visual">Visual</a></li><li><a href="#" data-id="' + id + '" data-type="html">HTML</a></li></ul>');
        });
        $('.editor-toggles a').click(onToggleEditor);

        $('.edit-chosen').live('click', onEditChosen);
    }
    /* TINYMCE funcs */
    function onToggleEditor(e) {
        e.preventDefault();
        $el = $(e.currentTarget);
        $el.parent().parent().find('a').toggleClass(on);

        if ($el.data('type') === 'html') {
            removeEditor($el.data('id'));
        } else {
            addEditor($el.data('id'));
        }
    }
    function addEditor(id) {
        if (tinyMCE.get(id)) { return; }
        $('#html' + id).removeClass(on);
        $('#visual' + id).addClass(on);
        tinyMCE.execCommand('mceAddControl', false, id);
    }
    function removeEditor(id) {
        var ed = tinyMCE.get(id);
        if (!ed) { return; }
        $('#visual' + id).removeClass(on);
        $('#html' + id).addClass(on);
        $('#' + id).height($(ed.contentAreaContainer).height() + 76);
        tinyMCE.execCommand('mceRemoveControl', false, id);
    }
    function updateStatus(e) {
        $el = $(e.currentTarget);
        $el.closest('form').submit();
        var cls = $el.closest('li').attr('class').replace(/status-[\d]/, '');
        $el.closest('li').attr('class', cls).addClass('status-'+$el.val());
    }
    // other app funcs
    function onEditChosen(e){
        e.preventDefault();
        var $el = $(this).parent().find('select'),
            id = $el.val();
        window.open($el.data('url') + '/' + id + '/edit', $el.data('url') + id);
    }
    function toggleFieldSet(e) {
        $(e.currentTarget).parent().toggleClass(on);
    }
    function onLimitInteger(e) {
        $(this).val($(this).val().replace(/[^-\d]/g, ""));
    }
    function onPermalinkKeyUp(e) {
        $el = $(e.currentTarget);
        var val = $el.val();
        if (val.match(/[^-\d\w]/)) {
            $el.val(val.replace(/[^-\d\w]/g, ""));
        }
    }
    $(init);
    return app;
} (jQuery));
