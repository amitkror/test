$(window).load(function(){

  jQuery('.newpopup #ajax_recaptcha').addClass("newpopuprecaptcha");
  jQuery('.newpopuprecaptcha .recaptchatable').addClass("newpopuprecaptchatable");
  jQuery('.newpopuprecaptcha .recaptcha_image_cell').addClass("newpopuprecaptchaimg");
  
  $('.custom-modal-signup').hide();
  $('.custom-modal-dialog').hide(); 
  $('#aaa-popup-fade1').hide();
  $('#aaa-popup-fade2').hide();
  $('#popup-display').css('display', 'block');
  $("#foot-wrap").css("z-index", "1");

  // display signup popup
  if (!sessionStorage.alreadyClicked) {
    setTimeout(function() { $('.custom-modal-signup').animate({'top':'35%'}, 1200, 'easeOutExpo')}, 2000);
    setTimeout(function() { $('.custom-modal-signup').show()}, 2000);
    setTimeout(function() { $('#aaa-popup-fade1').show()}, 2000);
    setTimeout(function() {$('body').css('overflow','hidden')}, 2000);
    
    // sign up close when X click event
    $('#signup-close').click(function() {
      $('.custom-modal-signup').animate({'top':'-150%'}, 400, 'easeOutExpo');
      $('#aaa-popup-fade1').hide();
      sessionStorage.alreadyClicked = "true";
      $('body').css('overflow','auto')
      setTimeout(function() { $('.custom-modal-dialog').animate({'top':'35%'}, 1200, 'easeOutExpo')}, 7000);
      setTimeout(function() { $('.custom-modal-dialog').show()}, 7000);
      setTimeout(function() { $('#aaa-popup-fade2').show()}, 7000);
      setTimeout(function() {$('body').css('overflow','hidden')}, 7000);
    });  

    // sign up close when click outside popup
    $('#aaa-popup-fade1').click(function() {
      $('.custom-modal-signup').animate({'top':'-150%'}, 400, 'easeOutExpo');
      $('#aaa-popup-fade1').hide();
      sessionStorage.alreadyClicked = "true";
      $('body').css('overflow','auto')
      setTimeout(function() { $('.custom-modal-dialog').animate({'top':'35%'}, 1200, 'easeOutExpo')}, 7000);
      setTimeout(function() { $('.custom-modal-dialog').show()}, 7000);
      setTimeout(function() { $('#aaa-popup-fade2').show()}, 7000);
      setTimeout(function() {$('body').css('overflow','hidden')}, 7000);
    });  
  }

  // display askanadviser popup
  if (sessionStorage.alreadyClicked == "true" && !sessionStorage.alreadyViewed) {
    setTimeout(function() { $('.custom-modal-dialog').animate({'top':'35%'}, 1200, 'easeOutExpo')}, 7000);
    setTimeout(function() { $('.custom-modal-dialog').show()}, 7000);
    setTimeout(function() {$('#aaa-popup-fade2').show()}, 7000);
    setTimeout(function() {$('body').css('overflow','hidden')}, 7000);
  }
  
  // close ask an adviser popup when X click event
  $('#aaa-close').click(function() {
    $('.custom-modal-dialog').animate({'top':'-150%'}, 400, 'easeOutExpo');
    $('#aaa-popup-fade2').hide();
    sessionStorage.alreadyViewed = "true"
    $('body').css('overflow','auto')
    
  });

  // close ask an adviser popup when click outside popup
  $('#aaa-popup-fade2').click(function() {
    $('.custom-modal-dialog').animate({'top':'-150%'}, 400, 'easeOutExpo');
    $('#aaa-popup-fade2').hide();
    sessionStorage.alreadyViewed = "true"
    $('body').css('overflow','auto')  
  });

  // sign up hide on sign in click
  $('div.already a').click(function() {
    sessionStorage.alreadyClicked = "true";
    $('body').css('overflow','auto')

  });

  // hide both popups on terms and condition page 
  $('p.tos a').click(function() {
    sessionStorage.alreadyClicked = "true";
    sessionStorage.alreadyViewed = "true";
    $('body').css('overflow','auto')
  });

  // hide signup popup on form sunmit 
  $("#signup-popup").submit(function(){
    sessionStorage.alreadyClicked = "true";
    $('body').css('overflow','auto')
  });

  // hide ask an adviser popup on form sunmit 
  $("#aaa-popup").submit(function(){
    //e.preventDefault();
    sessionStorage.alreadyViewed = "true";
    $('body').css('overflow','auto')
  });


});