/*!
 * jQuery rollovers
 * Original author: @ncherro
 * Further changes, comments: @ncherro
 * Licensed under the MIT license
 */

;(function ($, window, document, undefined) {

  var plugin_name = "rollovers",
  defaults = {
    preload: true
  };

  function Plugin(el, options) {
    this.el = el;
    this.$el = $(el);

    this.settings = $.extend( {}, defaults, options) ;

    this._defaults = defaults;
    this._name = plugin_name;

    this.init();
  }

  Plugin.prototype = {

    over: function() {
      this.$el.attr('src', this.rollover_src);
    },

    out: function() {
      this.$el.attr('src', this.orig_src);
    },

    init: function() {
      this.orig_src = this.$el.attr('src');
      this.rollover_src = this.$el.data('rollover');
      if (this.settings.preload) {
        (new Image()).src = this.rollover_src;
      }
      this.$el.hover(
        $.proxy(this.over, this),
        $.proxy(this.out, this)
      );
    }

  };

  $.fn[plugin_name] = function ( options ) {
    return this.each(function () {
      if (!$.data(this, "plugin_" + plugin_name)) {
        $.data(this, "plugin_" + plugin_name, new Plugin(this, options));
      }
    });
  };

})(jQuery, window, document);
