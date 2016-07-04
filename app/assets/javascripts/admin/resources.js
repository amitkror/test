var RESOURCES = (function($) {
    var app = {},
        $assetsList = $('#assets-list'),
        $resourceType = $('#resource_type_id'),
        $tokens = $("#resource_user_tokens");

    function init() {
        $assetsList.sortable({
            stop:onSorted
        });
        onSorted(null, $assetsList);

        $(window).on('nested:fieldAdded', onAdded);

        $resourceType.change(onTypeChange);
        onTypeChange();

        $tokens.tokenInput("/admissions/users/search.json", { preventDuplicates:true });

        $assetsList.find('input[type=file]').on('change', addRequired);
        $assetsList.find('.remove_nested_fields').on('click', removeRequired)
    }

    function addRequired() {
      if ($('#assets-list').find('input[type=file]').val().length > 0) {
        $assetsList.find('.small').attr('required', 'required');
      } else {
        $assetsList.find('.small').attr('required', 'false');
      }
    }

    function removeRequired() {
      $assetsList.find('.small').removeAttr('required');
    }

    function onAdded(e) {
        // move the form around to where we want it.
        // $promoList.append(e.field);
        $el = $($(e.field)
                    .parent()
                    .data('target'));
        $el.append(e.field);
        onSorted(null, $el);
    }
    function onSorted(e, ui) {
        // if 'e' is passed in, it's from a sortable event
        var targ = e === null ? ui : $(e.target);
        targ.find('> li').each(function(idx, e){
            $(this)
                .find('.order')
                .val(idx);
        });
    }
    function onTypeChange(e) {
        $('.program-fields').hide();
        var id = parseInt($resourceType.val(), 10);
        if (id === 1) {
            $('.program-fields').show();
        }
    }
    $(init);
    return app;
} (jQuery));
