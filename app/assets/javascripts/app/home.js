//= require ../libs/jquery.imagesloaded

var HOME = (function($) {
    var app = {};

    function init(){
        $('#blocks').imagesLoaded(onImageLoad);
        $('#blocks .block:nth-child(3n)').css( { marginRight:0 });
        //$('.custom-modal-dialog').animate({'top':'32%'}, 1200, 'easeOutExpo');
    }
    function onImageLoad(){
        blocks();
        //setTimeout(blocks, 1000);
    }
    function blocks(){

        var h = 0,
            bs = [];

        $('#blocks .block').each(function(idx, el){
            h = Math.max(h, $(el).height());
            //console.log('h', h);
            bs[bs.length] = el;
            if (idx % 3 === 2) {
                //console.log('hit it', h, bs);
                $(bs).height(h);
                h = 0;
                bs = [];
            }
        });
        //console.log('done', h, bs);
        if (bs.length > 0) {
            $(bs).height(h);
        }
    }
    $(init);
    return app;
} (jQuery));