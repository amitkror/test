var BOOKMARKS = (function($) {
  var app = {},
    $el = null;

  app.open = function(r) {
    if ($el !== null) {
        $el.remove();
    }
    $el = $(r);
    $el.css({ top: Math.max(0, $(window).height() * 0.5 - 200) });
    $('body').append($el);
    $el.find('.cancel').click(close);
    $el.find('.new').click(onNew);
    $('#new-folder-for-bookmarks').on('ajax:success', onCreated);
    //$el.find('li a').click(onSelect);
    $('#bookmarks-form').on('ajax:success', onSaved);
  };
  app.close = function() {
    $el.fadeTo(150, 0, function(){
        $el.remove();
    });
  };
  app.customCheck = function() {
    $('input.custom').customCheck();
    unCheck();
  }
  function close(e){
    e.preventDefault();
    app.close();
  }
  function unCheck() {
    var form = $('#bookmarks-form');
    var checkboxes = form.find('input');

    $('#uncheck').on('click', function(e) {
      checkboxes.filter(':checkbox').prop('checked',false);
      $('.bookmark-checks > .custom-check').removeClass('checked');
    })
  }
//   function onCreate(e) {
//     e.preventDefault();
//     var name = $el.find('input').val();
//     if (name === '') { return alert('You must enter a name'); }

//     $('.success span').text(name);
//     $.ajax({
//       url: $(this).attr('href'),
//       data: {
//         folder_name: name,
//         id: $el.data('bookmark-id')
//       }
//     }).success(onCreated);
// }
  function onCreated(e, r) {
    if (r.success) {
      var targ = $el.find('.new-folder');
      var bookmark = $('.bookmark-'+r.resource);
      var name = $(r.name);

      $el.find('.errors').hide();
      targ.fadeTo(150, 0, function(){
        targ.hide();
        $el.find('.success').fadeTo(250, 1);
        $('.success span').text(name);
      });
    } else {
      report("Sorry, couldn't save your folder", r.message);
    }

    if (r.has_bookmark) {
      bookmark.addClass('on');
    } else {
      bookmark.removeClass('on');
    }
  }
  function onNew(e){
    e.preventDefault();
    var targ = $el.find('.select');
    targ.fadeTo(150, 0, function(){
      targ.hide();
      $el.find('.new-folder').fadeTo(250, 1);
    });
  }
  // function onSelect(e) {

  //     e.preventDefault();
  //     $('.success span').text($(this).text());
  //     $.ajax({
  //         type: 'PUT',
  //         url: $(this).attr('href'),
  //         data: { 'folder_id': $(this).data('folder') }
  //     }).success(onSelected);

  // }
  function onSaved(e, r) {

      if (r.success) {
        var targ = $el.find('.select');
        var bookmark = $('.bookmark-'+r.resource);

        $el.find('.errors').hide();
        targ.fadeTo(150, 0, function(){
            targ.hide();
            $el.find('.success').fadeTo(250, 1);

        });

      } else {
        report("Sorry, couldn't update your bookmark", r.message);
      }
      if (r.has_bookmark) {
        bookmark.addClass('on');
      } else {
        bookmark.removeClass('on');
      }
  }
  function report(errors, arr) {
      for (var i = 0; i < arr.length; ++i) {
          errors += "<br/>" + arr[i];
      }
      var $err = $el.find('.errors');

      $err
          .html(errors)
          .fadeTo(150, 1);
  }
  return app;
} (jQuery));
