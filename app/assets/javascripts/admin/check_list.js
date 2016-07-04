/*
Call the plugin with $('jquery-selector').plugin({ foo:'custom-setting' });
*/

(function($) {
    var CheckList = function(el, opts) {
        //Defaults are below
        var settings = $.extend({}, $.fn.checkList.defaults, opts),
            $el,
            checked = 'checked',
            on = 'on';

        // private methods
        function init() {
            $el = $(el);
            $el
                .find('input:' + checked)
                .parent()
                .addClass(on);

            $el
                .find('input')
                .change(onCheckChange);

            $el
                .find('label')
                .click(onCheck);
        }
        function onCheckChange(e) {
            $el = $(this);
            if ($el.attr(checked) == checked) {
                $el
                    .parent()
                    .addClass(on);
            } else {
                $el
                    .parent()
                    .removeClass(on);
            }
        }
        function onCheck(e) {
            e.preventDefault();
            $el = $(this);
            $el.toggleClass(on);
            if ($el.hasClass(on)) {
                $el
                    .find('input')
                    .attr(checked, checked);
            } else {
                $el
                    .find('input')
                    .removeAttr(checked);
            }
        }
        init();
    };
    $.fn.checkList = function(options) {
        return this.each(function(idx, el) {
            var $el = $(this), key = 'checkList';
            if ($el.data(key)) { return; }
            var checkList = new CheckList(this, options);
            $el.data(key, checkList);
        });
    };
    // default settings
    $.fn.checkList.defaults = {  };
})(jQuery);
