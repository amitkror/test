var RESPONSIVE = (function($, window, document, undefined) {

  var breakpoint = 960, $win, mobile_style = false, app = {};

  // public
  app.handleResized = function(skip_check) {
    if ($win.width() < breakpoint) {
      if (skip_check || !mobile_style) {
        $('.type .tip').tooltip('destroy').tooltip({
          placement: 'right'
        });
        $('.bookmark.tip').tooltip('destroy').tooltip({
          placement: 'left'
        });
        mobile_style = true;
      }
    } else if (skip_check || mobile_style) {
      $('.type .tip').tooltip('destroy').tooltip();
      $('.bookmark.tip').tooltip('destroy').tooltip();
      mobile_style = false;
    }
  }

  // private
  function init() {
    $win = $(window);

    // menu togglers
    $('#mobile-menu').toggler({
      group: 'menu'
    });
    $('#mobile-account, #mobile-logout').toggler({
      group: 'menu',
      toggle_sel: false
    });
    $('#mobile-search').toggler({
      group: 'menu',
      after_init: function() {
        var that = this;
        that.$search_input = that.$toggled.find('input[type="search"]');
        that.$icon = that.$el.find('i');
        that.$search_input.focus(function() {
          that.locked = true;
        }).blur(function() {
          that.locked = false;
        })
      },
      on_show: function() {
        this.$search_input.focus();
        this.$icon.addClass('ico-cancel');
      },
      on_hide: function() {
        this.$search_input.blur();
        this.$icon.removeClass('ico-cancel');
      }
    });

    // child togglers
    $('#kids article > h1').toggler({
      group: 'kids',
      show_on_mouseover: false,
      hide_on_mouseout: false,
      toggle_sel: '~', // siblings
      animate: 'fast',
      after_init: function() {
        this.$icon = this.$el.find('i');
      },
      on_show: function() {
        this.$icon.addClass('ico-minus')
      },
      on_hide: function() {
        this.$icon.removeClass('ico-minus')
      }
    });

    // search togglers
    $('.filters > h3').toggler({
      show_on_mouseover: false,
      hide_on_mouseout: false,
      hide_others: false,
      toggle_sel: '~ .filter:not(.no-mobile)',
      animate: 'fast',
      after_init: function() {
        this.$icon = this.$el.find('i');
      },
      on_show: function() {
        this.$icon.addClass('ico-minus')
      },
      on_hide: function() {
        this.$icon.removeClass('ico-minus')
      }
    });

    // profile nav
    $('#mobile-profile-nav-sel').change(function() {
      window.location.href = $(this).val();
    });

    app.handleResized();
    $win.smartresize(app.handleResized);
  }

  $(init);

  return app;

}(jQuery, window, document));
