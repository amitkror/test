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