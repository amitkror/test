// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
(function($) {
  var code, $copyCode, refUrl, target;

  $(document).ready(function() {
    $('.generate').submit(function(event) {
      $('.code').val(randomString());

      createReferralCode(event);
    });

    $.each($('.contest'), function(index, value) {
      $copyCode = $(value).find('.copy-code');
      $refUrl = $(value).find('.ref-url');

      var client = new ZeroClipboard($copyCode);
      $copyCode.attr('data-clipboard-text', $refUrl.val());

      setupSocial(value);
    });
  });

  var setupSocial = function(target) {
    var social = $(target).find('.social');
    var loc = $($(target).find('.ref-url')[0]).val(),
        msg = "Get free tools, tips & scholarships for #collegebound New Yorkers. Sign up here now: "

    var uriEncode = encodeURIComponent([msg, loc].join(' '));

    $(social).html('<a href="http://twitter.com/intent/tweet?text=' + uriEncode + '&via=NYCCollegeLine" class="twitter button ovly" target="_blank"><span class="socicon">a</span><p>TWEET</p></a> \
                      <a href="http://facebook.com/sharer.php?u=' + loc + '&t=' + msg + '" target="_blank" class="facebook button ovly"><span class="socicon">b</span><p>SHARE</p></a>')
  }

  var randomString = function() {
    var chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
        result = '';

    for (var i = 0; i < 17; i++) {
      result += (chars[(Math.floor(Math.random() * chars.length))])
    }

    code = result;
    return result;
  }

  var createReferralCode = function(event) {
    event.preventDefault();
    var url = $('.generate').attr('action');
    var data = $('.generate').serialize();
    target = $(event.target).next()[0];
    $.ajax({
      type: 'POST',
      url: url,
      data: data,
      success: function() {
        revealBlock(target);
        setClipboard(target);
        setupSocial(target);
      },
      error: function() {
        $('.error').html('<p>Something went wrong! Try again.</p>');
      }
    })
  }

  var revealBlock = function(target) {
    var el = $(target)
    $($(target).prev()).addClass('hidden');
    $(target).removeClass('hidden');
  }

  var setClipboard = function(target) {
    // $.each($('.contest'), function(index, value) {
    //   $copyCode = $(value).find('.copy-code');
    //   $refUrl = $(value).find('.ref-url');
    //
    //   var client = new ZeroClipboard($copyCode);
    //   // $refUrl.attr('value', )
    //   $copyCode.attr('data-clipboard-text', $refUrl.val() + code);
    // });
    var thisRef = $(target).find('.ref-url')[0];
    var thisCopy = $(target).find('.copy-code');
    var urlPart = $(thisRef).val();
    var urlWhole = urlPart + code;

    $(thisRef).attr('value', urlWhole);
    $(thisCopy).attr('data-clipboard-text', urlWhole);


    // var urlPart = $('.ref-url').val();
    // var urlWhole = urlPart + code;
    // $('.ref-url').attr('value', urlWhole);
    // $('.copy-code').attr('data-clipboard-text', urlWhole);
  }
}(jQuery));
