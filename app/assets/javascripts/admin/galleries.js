var GALLERY = (function () {
    var app = {},
        $tokens = $("#gallery_asset_tokens"),
        $list;

    app.add = function(id, name, file, url) {
        $tokens.tokenInput("add", {id: id, name: name, file: file, url: url});
    };

    function init(){
        $tokens.tokenInput("/admissions/assets/search.json", {
            resultsFormatter:formatResult,
            tokenFormatter:formatToken,
            preventDuplicates:true,
            //onAdd:onSorted,
            onReady:onTokenReady
        });
    }
    function formatResult(item) {
        return '<li><img src="' + item.file + '"/><p>' + item.name + '</p><div class="clear"></div></li>';
    }
    function formatToken(item) {
        return '<li data-id="' + item.id + '"><a href="' + item.url + '" target="_blank"><img src="' + item.file + '"/></a></li>';
    }
    function onSorted(e, ui) {
        var ids = [],
            tokens = [];
        $list.find('li').each(function(){
            var data = $.data(this, "tokeninput");
            if (data) {
                ids.push(data.id);
                tokens.push(data);
            }
        });
        $tokens.val(ids.join(','));
    }
    function onTokenReady() {
        $list = $('.token-input-list');
        $list.sortable({ stop:onSorted });
    }
    $(init);
    return app;
}());

var ASSETS = (function($) {
    var app = {},
        uploader,
        $dz = $('#drop'),
        $msg = $('#msg'),
        $queue = $('#queue'),
        $uploaded = $('#uploaded'),
        $el,
        path = '/admissions/';

    function init() {
        var atoken = $("input[name=authenticity_token]").val();
        $msg.hide();
        $queue.hide();
        $uploaded.hide();
        uploader = new plupload.Uploader({
            runtimes: 'html5,gears,silverlight,browserplus,html4',
            url: path + 'assets.json',
            browse_button: 'browse',
            container: 'upload-form',
            drop_element: 'drop',
            dragdrop: true,
            // Make sure to send authenticity token and any other
            // parameters that are on the plain html form
            multipart: true,
            multipart_params: {
                'authenticity_token':atoken
            },
            filters: [{ title: "Image files", extensions: "jpg,jpeg,gif,png" }],
            flash_swf_url: '/assets/libs/plupload/plupload.flash.swf',
            silverlight_xap_url: '/assets/libs/plupload/plupload.silverlight.xap'
        });
        uploader.bind('QueueChanged', onUploadStart);
        uploader.bind('Error', onError);
        uploader.bind('Init', onInit);
        uploader.bind('FilesAdded', onFilesAdded);
        uploader.bind('UploadProgress', onUploadProgress);
        uploader.bind('FileUploaded', onFileUploaded);
        uploader.init();
        
        var drag = 'dragover';
        $dz
            .on('dragenter', function(e) {
                $dz.addClass(drag);
                return false;
            })
            .on('dragleave', function(e) {
                $dz.removeClass(drag);
                return false;
            })
            .on(drag, function(e) {
                return false;
            }).on('drop', function(ev) {
                $dz.removeClass(drag);
                return false;
            });
    }
    // plupload event handlers
    function onError(up, err) {
        $queue.append('<li class="error">Error: ' + err.code + ', Message: ' + err.message + (err.file ? ', File: ' + err.file.name: '') + '</li>');
        up.refresh();
    }
    function onFilesAdded(up, files) {
        $queue.show();
        $uploaded.show();
        $.each(files, function(i, file) {
            $queue.append('<li id="' + file.id + '">' + file.name + ' (' + plupload.formatSize(file.size) + ') <b></b>' + '</li>');
        });
    }
    function onFileUploaded(up, file, r) {
        r = jQuery.parseJSON(r.response);
        if (r.success) {
            $msg.show();
            $('#' + file.id).remove();
            GALLERY.add(r.id, r.title, r.file, r.url);
            $uploaded.prepend('<li><a href="' + path + 'assets/' + r.id + '/edit" id="' + r.id + '" target="_blank" title="Click to edit in new window."><img src="' + r.file + '" /></a></li>');
        } else {
            log('error uploading');
        }
    }
    function onInit(up, param) {
        // console.log('init', up.features);
        if (up.features.html5) { return; }
        $('.drop').hide();
        $dz.hide();
    }
    function onUploadProgress(up, file) {
        $('#' + file.id + " b").html(file.percent + "%");
    }
    function onUploadStart() {
        uploader.start();
    }
    $(init);
    return app;
} (jQuery));
