/*
Call the plugin with $('jquery-selector').avatarSelector();
*/
(function($) {
  var AvatarSelector = function(el, opts) {
    //Defaults are below
    var settings = $.extend({}, $.fn.avatarSelector.defaults, opts),
      $el = $(el),
      $cur,
      $id = $('#user_system_avatar_id'),
      cur = 0,
      dir = 1,
      tot = $el.find('li').length;

    $el.find('.next').click(onNext);
    $el.find('.prev').click(onPrev);

    $cur = $('#ava-' + $id.val());
    cur = $cur.data('idx');
    $cur.css({ left:0 });

    function onPrev(e){
      --cur;
      dir = -1;
      if (cur < 0) { cur = tot -1; }
      show();
    }
    function onNext(e){
      ++cur;
      dir = 1;
      if (cur === tot) { cur = 0; }
      show();
    }
    function show(){
      $cur.css({ zIndex:1 });
      $cur = $el.find('ul li:nth-child(' + (cur + 1) + ')');
      $cur
          .css({ left:150 * dir, zIndex:2 })
          .animate({ left:0 }, 200);
      $id.val($cur.data('id'));
    }
  };
  $.fn.avatarSelector = function(options) {
    return this.each(function(idx, el) {
      var $el = $(this), key = 'avatarSelector';
      // Return early if this element already has a plugin instance
      if ($el.data(key)) { return; }
      // Pass options to plugin constructor
      var avatarSelector = new AvatarSelector(this, options);
      // Store plugin object in this element's data
      $el.data(key, avatarSelector);
    });
  };
  // default settings
  $.fn.avatarSelector.defaults = { /* nothing yet */ };
})(jQuery);


var PROFILE = (function($) {
  var app = {},
      $el;

  // Private functions
  function init() {
    $('#avatar-selector').avatarSelector();
    // profileSettings();
    $('input.audience').change(onAudienceChange).trigger('change');
  }

  function onAudienceChange(e) {
    $el = $(this);

    var checked = $el.is(':checked'),
        $parent = $el.parent().parent(),
        $newsletterCheck = $($el.data('newsletter')).find('input'),
        $newsletters = $('.newsletter').siblings('span');

    $parent
      .find('.destroy')
        .val(checked ? '0' : '1');

    $parent
      .find('.user-text-field')
        .toggleClass('on', checked);

    // if (checked && $newsletterCheck.length > 0) {
    //   $newsletterCheck.data('customCheck').check();
    // }
  }

  $(init);


  return app;
} (jQuery));

var AVATAR = (function($) {
  var app = {},
    uploader,
    $queue = $('#queue'),
    $uploaded = $('#uploaded'),
    $custom = $('#custom-avatar');

  function init() {
    var atoken = $("input[name=authenticity_token]").val();
    $queue.hide();
    $uploaded.hide();
    uploader = new plupload.Uploader({
      runtimes: 'html5,gears,flash,silverlight,browserplus,html4',
      url: '/avatars.json',
      browse_button: 'avatar-browse',
      container: 'avatar-form',
      max_file_size : '500kb',
      multipart: true,
      multipart_params: {
        'authenticity_token':atoken
      },
      filters: [{
        title: "Image files",
        extensions: "jpg,jpeg,gif,png"
      }],
      flash_swf_url: '/assets/libs/plupload/plupload.flash.swf',
      silverlight_xap_url: '/assets/libs/plupload/plupload.silverlight.xap'
    });
    uploader.bind('QueueChanged', onUploadStart);
    uploader.bind('Error', onError);
    uploader.bind('Init', onInit);
    uploader.bind('FilesAdded', onFilesAdded);
    uploader.bind('UploadProgress', onUploadProgress);
    uploader.bind('FileUploaded', onFileUploaded);
    uploader.init();

    $custom.find('#remove').click(onClearCustom);
  }
  function onClearCustom(e){
    $.ajax('/avatars/destroy', { type: 'delete' }).success(function(){
      $('#avatar-selector,#avatar-form').slideDown();
      $custom.slideUp();
    });
  }
  function onError(up, err) {
    var msg = '';
    $queue.text('');
    if (err.code === -600) {
      msg = "That's too big!<br/>Please choose a file under 500kb.";
    } else {
      msg = err.message + ' ' + err.code + ', ' + (err.file ? err.file.name : '');
    }
    $queue.append('<li class="error">' + msg + '</li>');
    up.refresh(); // Reposition Flash/Silverlight
  }
  function onFilesAdded(up, files) {
    $queue.show();
    $uploaded.show();
    $.each(files, function(i, file) {
      $queue.append('<li id="' + file.id + '">' + file.name + ' (' + plupload.formatSize(file.size) + ') <b></b>' + '</li>');
    });
  }
  function onFileUploaded(up, file, r) {
    r = jQuery.parseJSON(r.response);
    if (r.success) {
      $('#' + file.id).remove();
      $('#avatar-selector,#avatar-form').slideUp();

      $custom.find('span').html('<img src="' + r.file + '"/>');
      $custom.slideDown();
    } else {
      log('error uploading');
    }
  }
  function onInit(up, param) {
    //console.log('init', up.features);
  }
  function onUploadProgress(up, file) {
    $('#' + file.id + " b").html(file.percent + "%");
  }
  function onUploadStart() {
    uploader.start();
  }
  $(init);
  return app;
} (jQuery));



