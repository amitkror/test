  (function($) {
    


 $(document).ready(function(){ 
    
       $('.top-right .desktop-search').click(
            function () {
             $(".desktop-search-form").toggle(); 
        });

       $('#main-menu li').hover(
       function(){ $(this).addClass('open') },
       function(){ $(this).removeClass('open') }
		)

  });    

        

   $(window).scroll(function() {
		if ($(this).scrollTop() > 44){  
		    $('.newHeader').addClass("fixed");
        $('#toolbar').addClass("tbarfix");
		  }
		  else{
		    $('.newHeader').removeClass("fixed");
        $('#toolbar').removeClass("tbarfix");
		  }
	});


})(jQuery);
