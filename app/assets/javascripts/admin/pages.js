var PAGES = (function($) {
    var app = {},
        $el;
    // sitemap vars
    var $sitemap = $('.sitemap'),
        $order = $('#order-button'),
        closed = 'closed',
        dis = 'disabled',
        dropzone = 'dropzone',
        expand = '.expander',
        open = 'open';

    function init() {

        if ($sitemap.length <= 0) { return; }
        $('.expand-all').click(function expandAll() { $('.' + closed).addClass(open).removeClass(closed); });
        $('.collapse-all').click(function collapseAll() { $('.' + open).removeClass(open).addClass(closed); });

        $sitemap
            .find('li')
            .prepend('<div class="' + dropzone + '"></div>');

        updateSitemap();

        $sitemap.find('li dl, .' + dropzone).droppable({
            accept: '.sitemap li',
            tolerance: 'pointer',
            drop: onDrop,
            over: function() {
                $el = $(this);
                $el.filter('dl').css({ backgroundColor: '#ccc' });
                $el.filter('.' + dropzone).css({ borderColor: '#aaa' });
            },
            out: function() {
                $el = $(this);
                $el.filter('dl').css({ backgroundColor: '' });
                $el.filter('.' + dropzone).css({ borderColor: '' });
            }
        });
        $sitemap
            .find('li')
            .draggable({
                handle: ' > .move',
                opacity: 0.8,
                helper: 'clone',
                zIndex: 100
            });
        $(expand).click(onExpand);
        $order.click(onOrder);
    }
    
    /* sitemap */
    function addPage(pages, idx, el) {
        var $el = $(el), children = [], page,
        kids = $el.find('ul:first').children();
        kids.each(function(i, el) {
            children.push(addPage(children, i, el));
        });
        page = '{ "id": ' + el.id.split('page_').join('') + ', "idx": ' + idx + ', "children": [' + children.join(',') + '] }';
        return page;
    }
    function onDrop(e, ui) {
        var li = $(this).parent(), child = !$(this).hasClass(dropzone);
        //If this is our first child, we'll need a ul to drop into.
        if (child && li.children('ul').length === 0) {
            li.append('<ul/>');
        }
        //ui.draggable is our reference to the item that's been dragged.
        if (child) {
            li.children('ul').append(ui.draggable);
        } else {
            li.before(ui.draggable);
        }
        //reset our background colours.
        li.find('dl,.dropzone').css({ backgroundColor: '', borderColor: '' });
        $order.removeClass(dis);
        updateSitemap();
    }
    function updateSitemap() {
        $sitemap.find('li').each(function (idx, el){
            $el = $(el);
            if ($el.find('ul li').length === 0) {
                $el.find(expand).hide();
                $el.removeClass(open).addClass(closed);
            } else {
                $el.find(expand).show();
            }
        });
    }
    function onExpand(e) {
        e.preventDefault();
        $el = $(e.currentTarget).parent();
        if ($el.hasClass(open)) {
            $el.removeClass(open).addClass(closed);
        } else {
            $el.removeClass(closed).addClass(open);
        }
    }
    function onOrder(e) {
        var pages = [];
        $order.text('saving...');
        $sitemap.children().each(function(idx, el) {
            pages.push(addPage(pages, idx, el));
        });
        // console.log(pages.join(','));
        $.ajax({ url:ORDER_URL, data:'pages=[' + pages.join(',') + ']', success:onOrderUpdate });
    }
    function onOrderUpdate(r) {
        if (r.success) {
            $order.addClass(dis).text('update order');
        } else {
            alert('awe man, there was an error saving the order');
        }
    }
    $(init);
    return app;
} (jQuery));
