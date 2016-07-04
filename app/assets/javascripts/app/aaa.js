$(window).load(function(){

   jQuery('.newpopup #ajax_recaptcha').addClass("newpopuprecaptcha");
   jQuery('.newpopuprecaptcha .recaptchatable').addClass("newpopuprecaptchatable");
   jQuery('.newpopuprecaptcha .recaptcha_image_cell').addClass("newpopuprecaptchaimg");
  
  //setTimeout(function() { $('.custom-modal-dialog').animate({'top':'9%'}, 1200, 'easeOutExpo'); }, 5000);
  $('.custom-modal-dialog').animate({'top':'17%'}, 1200, 'easeOutExpo');
  $('#aaa-popup-fade').show();
  $("#foot-wrap").css("z-index", "1");


  //$('.custom-modal-signup').animate({'top':'9%'}, 1200, 'easeOutExpo');

    // if (sessionStorage.getItem('dontLoad') == null){
    //   setTimeout(function() { $('.custom-modal-dialog').animate({'top':'10%'}, 1200, 'easeOutExpo'); }, 5000);
    //   sessionStorage.setItem('dontLoad', 'true');    
    // };

    //$('.custom-modal-signup').animate({'top':'10%'}, 1200, 'easeOutExpo');

    //$('#nyc-close-signup').click(function() {
      //  $('.custom-modal-signup').animate({'top':'-80%'}, 400, 'easeOutExpo');
      //  setTimeout(function() { $('.custom-modal-dialog').animate({'top':'10%'}, 1200, 'easeOutExpo'); }, 5000);
    //});

    $('#aaa-close').click(function() {
        $('.custom-modal-dialog').animate({'top':'-80%'}, 400, 'easeOutExpo');
        //setTimeout(function() { $('.custom-modal-signup').animate({'top':'9%'}, 1200, 'easeOutExpo'); }, 5000);
        $('#aaa-popup-fade').hide();
    });

    $('#signup-close').click(function() {
        $('.custom-modal-signup').animate({'top':'-80%'}, 400, 'easeOutExpo');
        setTimeout(function() { $('.custom-modal-dialog').animate({'top':'9%'}, 1200, 'easeOutExpo'); }, 3000);
    });
    
    // $('#modalclose').click(function() {
    //     $('.custom-modal').animate({'top':'-50%'}, 800, 'easeOutExpo');
    // });
});