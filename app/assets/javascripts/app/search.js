var SEARCH = (function($, RESPONSIVE, undefined) {
    var app = {},
        $form = $('form'),
        $loading = $('#loading'),
        $noResults = $('#no-results'),
        $results = $('#search-results'),
        $req = null,
        url = '/search';

    function init(){
        $('.filter .all')
            .customCheck({ onCheck: onAllCheck });

        $('.filter input:not(.all)')
            .customCheck({ onCheck: onFilterCheck });

        $('.filter .show-more')
            .click(toggleFilter);

        $('.filter .clear-all').click(clearAll);

        $('#remove-filters').click(removeFilters);

        $('#mobile-search-type').change(onMobileSearchTypeChanged);

        $('.mobile-only-b').change(linkWork);
    }

    function linkWork(e){
      var linkValue = $('.mobile-only-b option:selected').attr("value");
      if(linkValue == 6){ 
        e.preventDefault();
        location.href = $(".tgt-link").attr("href");
      }
    }

    function clearAll(e) {
        var $alls = $('.filter .all'),
            $filters = $('.filter input:not(.all)');

        $alls.each(function(idx, el){
            $(el).data('customCheck').check();
        });

        $filters.each(function(idx, el){
            $(el).data('customCheck').uncheck();
        });
        refresh();
    }
    function onAllCheck(e) {
        var $filter = $(this).closest('.filter'),
            $filters = $filter.find('input:not(.all)'),
            checked = $filter.find('.all').is(':checked');

        $filters.each(function(idx, el){
            if (checked) { $(el).data('customCheck').uncheck(); }
            else { $(el).data('customCheck').check(); }
        });
        refresh();
    }
    function onFilterCheck(e) {
        var $filter = $(this).closest('.filter'),
            $all = $filter.find('.all');
        //console.log($filter.find('.all').data('customCheck'));

        if ($all.length > 0) {
            if ($filter.find(':checked').length === 0) {
                $all
                    .data('customCheck')
                    .check();
            } else {
                $all
                    .data('customCheck')
                    .uncheck();
            }
        }
        refresh();
    }

    function onMobileSearchTypeChanged(e) {
      $('#search_form_type').val($(this).val());
      refresh();
    }

    function refresh() {
        $results.children().remove();
        $noResults.stop().fadeTo(100, 0, function(){ $noResults.hide(); });
        $loading.show();
        if ($req !== null) {
            $req.abort();
        }
        $req = $.ajax({
            type: "GET",
            url: url + ".json",
            data: $form.serialize()
        }).done(onRefresh);
    }
    function onRefresh(r) {
        $req = null;
        $loading.hide();

        if (r.has_results) {
            $results.html(r.results);
            RESPONSIVE.handleResized(true);
        } else {
            $noResults.stop().css({ opacity: 0 }).fadeTo(150, 1);
        }

        var path = url + '?' + r.link_path,
            p = '';
        if (Modernizr.history) {
            window.history.pushState(null, null, path);
        }
        path = removeParam(path, 'type');
        $('#tabs a').each(function(idx, el){
            if ($(this).data('type') !== undefined) {
                p = '&type=' + $(this).data('type');
            }
            $(this).attr('href', path + p);
        });
        var $total = $('.total'),
            type = $total.data('phase') || '';
        $total.text(r.total + ' ' + type + (r.total === 1 ? ' result' : ' results'));
    }
    function removeFilters(e) {
        e.preventDefault();
        $('#search_form_org').val('');
        $('#search_form_phase_id').val('');
        $('#new_search_form').submit();
        refresh();
    }
    function toggleFilter(e){
        e.preventDefault();
        var $filters = $(this).parent().find('.more');
        $(this).text($filters.is(':visible') ? 'Show more' : 'Show less');
        $filters.slideToggle('fast');
    }
    function removeParam(str, param){
        var pairs = str.split('&');
        for (var i = 0; i < pairs.length; ++i){
            if (pairs[i].indexOf(param + '=') === 0) {
                pairs.splice(i, 1);
            }
        }
        return pairs.join('&');
    }

    $(init);
    return app;
} (jQuery, RESPONSIVE));
