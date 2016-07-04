/*
Call the plugin with $('jquery-selector').gallerySelect({  });
*/

(function($) {
    var GallerySelect = function(el, opts) {
        //Defaults are below
        var settings = $.extend({}, $.fn.gallerySelect.defaults, opts),
            $id,
            $image,
            $remove,
            on = 'on';

        this.updateGallery = function (id, img) {
            onGalleryRemove();
            $id.val(id);
            $image.append('<img src="' + img + '" />');
            $remove.addClass(on);
        };
        // private methods
        function init(){
            var $el = $(el);
            $id = $el.find('input[type=hidden]');
            $image = $el.find('.image');
            $remove = $el.find('.remove-gallery');

            $el.find('.select').click(onGallerySelect);
            $remove.click(onGalleryRemove);
        }
        function onGalleryRemove(e) {
            if(e !== undefined) { e.preventDefault(); }
            $image.children().remove();
            $id.val('');
            $remove.removeClass(on);
        }
        function onGallerySelect(e) {
            e.preventDefault();
            OVERLAY.showURL(e.currentTarget.href);
        }
        init();
    };
    $.fn.gallerySelect = function(options) {
        return this.each(function(idx, el) {
            var $el = $(this), key = 'gallerySelect';
            if ($el.data(key)) { return; }
            var gallerySelect = new GallerySelect(this, options);
            $el.data(key, gallerySelect);
        });
    };
    // default settings
    $.fn.gallerySelect.defaults = {  };

})(jQuery);