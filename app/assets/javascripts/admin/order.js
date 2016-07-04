var ORDER = (function($) {
    var app = {},
        $order = $('#order-button'),
        $list = $('.index-list'),
        alt = 'alt',
        dis = 'disabled';

    function init() {
        $order.click(onOrder);
        $list.sortable({ axis:'y', opacity:.6, forceHelperSize:true, stop:serialize });
    }
    function onOrder(e) {
        $order.text('saving...');
        $.ajax({ url:ORDER_URL, data:$list.sortable('serialize'), success:onOrderUpdate });
    }
    function onOrderUpdate(r) {
        if (r.success) {
            $order.addClass(dis).text('update order');
        } else {
            alert('awe man, there was an error saving the order');
        }
    }
    function serialize() {
        $list.find('li.' + alt).removeClass(alt);
        $list.find('li:nth-child(even)').addClass(alt);
        $order.removeClass(dis);
    }
    $(init);
    return app;
} (jQuery));
