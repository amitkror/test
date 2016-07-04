
var BLOG = (function($) {
	var app = {};
	var $nav = $('#blog-date-nav')
  // Private functions
  function init() {    
    $nav.find('.year').each(function(){
    	// console.log(this);
    	var $this = $(this);
    	$this.find('ul.months').hide();
    });
    $nav.find('.year').click(function(){
    	var $this = $(this);
    	$this.find('i').toggleClass('ico-down').toggleClass('ico-right');
    	$this.find('.months').toggle('fast');
    });
  }
  $(init);
  return app;
} (jQuery));
