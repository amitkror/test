var TINY_GALLERY = (function($) {
    var app = {},
        insert = $('.insert'),
        cancel = $('.cancel'),
        selectable = 'a.selectable',
        selected = 'selected',
        selection = null,
        noneSelected = "You have not selected a gallery. Please select one or click cancel to close the window.";

    function init() {
        if (TINY) {
            insert.click(onTinyInsert);
            cancel.click(onTinyClose);
        } else {
            insert.click(onInsert);
            cancel.click(onClose);
        }
        if ($(selectable).length <= 0) { return false; }
        $(selectable).click(onSelect);
    }
    function onClose(e) {
        e.preventDefault();
        window.parent.OVERLAY.hide();
    }
    function onInsert(e) {
        e.preventDefault();
        var $el = $('a.' + selected);
        if (!$el.length) { return alert(noneSelected); }
        var id = $el.attr('id'),
            img = $el.find('img').attr('src');
        //console.log('finding', 'a.' + selected, img, id);

        window.parent.UPDATE_GALLERY(id, img);
        window.parent.OVERLAY.hide();
    }
    function onSelect(e) {
        e.preventDefault();
        if (selection) { $(selection).removeClass(selected); }

        if (selection!== null && selection == this) {
            selection = null;
            return;
        }
        selection = this;
        var $t = $(this);
        if ($t.is('.' + selected)) {
            $t.removeClass(selected);
        } else {
            $t.addClass(selected);
        }
    }
    function onTinyClose(e) {
        e.preventDefault();
        tinyMCEPopup.close();
    }
    function onTinyInsert(e) {
        e.preventDefault();
        if (!$('a.' + selected).length) { return alert(noneSelected); }
        var id = $('a.' + selected).attr('id');
        tinyMCEPopup.restoreSelection();
        tinyMCEPopup.editor.execCommand('mceInsertContent', false, '%%gallery-' + id + '%%');
        tinyMCEPopup.close();
    }
    $(init);
    return app;
} (jQuery));
