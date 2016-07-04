var USERS = (function () {
    var app = {},
        $tokens = $("#user_resource_tokens"),
        $userRole = $('#user_role_id');

    function init(){
        $userRole.change(onRoleChange);
        onRoleChange();

        $tokens.tokenInput("/admissions/resources/search.json", {
            preventDuplicates:true
        });
    }
    function onRoleChange(e) {
        $('.adviser-fields').hide();
        var id = parseInt($userRole.val(), 10);
        if (id !== 1) {
            $('.adviser-fields').show();
        }
    }
    $(init);
    return app;
}());
