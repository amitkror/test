var ASSETS = (function($) {
    var app = {},
        $el,
        alt = $('#alt'),
        form = $('#upload-form'),
        dz = $('#drop'),
        icon = $('#alignment .icon'),
        insert = $('.insert'),
        link = $('#link'),
        list = $('#queue'),
        size = $('#size'),
        uploaded = $('#uploaded'),
        cancel = form.find('.cancel'),
        uploader,
        selection = null,
        noneSelected = 'You have not selected anything. Please select something to insert or click "Cancel" to close the window.',
        selectable = 'a.selectable',
        selected = 'selected',
        path = '/admissions/';

    // event handlers
    app.onAlignmentChange = function() {
        var val = 0;
        switch ($('[name=alignment]:checked').attr('id')) {
            case "align1": val = 1; break;
            case "align2": val = 2; break;
            case "align4": val = 3; break;
            case "align5": val = 4; break;
        }
        // icon.animate({ backgroundPosition: (val * -96) + 'px 0px' }, 250);
        icon.css({ backgroundPosition: (val * -96) + 'px 0px' });
    };
    function init() {
        var atoken = $("input[name=authenticity_token]").val();
        uploader = new plupload.Uploader({
            runtimes: 'html5,gears,silverlight,browserplus,html4',
            url: path + 'assets.json',
            browse_button: 'browse',
            container: 'container',
            drop_element: 'drop',
            dragdrop: true,
            // Make sure to send authenticity token and any other
            // parameters that are on the plain html form
            multipart: true,
            multipart_params: {
                'authenticity_token':atoken
            },
            filters: [{title: "Image files", extensions: "jpg,jpeg,gif,png"}],
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
        insert.click(onInsert);
        cancel.click(function() { tinyMCEPopup.close(); });
        $('[name=alignment]').click(app.onAlignmentChange);
        $(selectable).live('click', onImageSelect);
        var drag = 'dragover';
        dz.bind('dragenter', function(e) {
            dz.addClass(drag);
            return false;
        })
        .bind('dragleave', function(e) {
            dz.removeClass(drag);
            return false;
        })
        .bind('dragover', function(e) {
            return false;
        }).bind('drop', function(ev) {
            dz.removeClass(drag);
            return false;
        });
    }
    // plupload event handlers
    function onError(up, err) {
        list.append('<li class="error">Error: ' + err.code + ', Message: ' + err.message + (err.file ? ', File: ' + err.file.name: '') + '</li>');
        up.refresh();
    }
    function onFilesAdded(up, files) {
        $.each(files, function(i, file) {
            list.append('<li id="' + file.id + '">' + file.name + ' (' + plupload.formatSize(file.size) + ') <b></b>' + '</li>');
        });
    }
    function onFileUploaded(up, file, r) {
        r = jQuery.parseJSON(r.response);
        if (r.success) {
            $('#' + file.id).remove();
            uploaded.prepend('<li><a href="#" id="' + r.id + '" class="selectable"><img src="' + r.file + '" /></a></li>');
        } else {
            log('error uploading');
        }
    }
    function onInit(up, param) {
        // console.log('init', up.features);
        if (up.features.html5) { return; }
        
        $('.drop').hide();
        dz.hide();
    }
    function onUploadProgress(up, file) {
        $('#' + file.id + " b").html(file.percent + "%");
    }
    function onUploadStart() {
        uploader.start();
    }
    function onDataReturned(d) {
        var imgClass = $('input[name=alignment]:checked').val();
        var result = '<p class="inline-image' + (imgClass !== '' ? ' ' + imgClass: '') + '"';
        // assign a width only if it's not floating, otherwise the align doesn't do anything
        if (imgClass.indexOf('align') <= -1) {
            result += ' style="width:' + d.width + 'px;"';
        }
        result += '>';
        var img = '<img src="' + d.filename + '" alt="' + alt.val() + '" width="' + d.width + '" />';
        if ($.trim(link.val()) !== '') {
            img = '<a href="' + link.val() + '">' + img + '</a>';
        }
        var cite = '';
        if ($.trim(alt.val()) !== '') {
            cite = '<cite>' + alt.val() + '</cite>';
        }
        result = result + img + cite + '</p>';
        tinyMCEPopup.restoreSelection();
        tinyMCEPopup.editor.execCommand('mceInsertContent', false, result);
        tinyMCEPopup.close();
    }
    function onImageSelect(e) {
        e.preventDefault();
        $(selection).removeClass(selected);
        if (selection == this) {
            selection = null;
            return;
        }
        selection = this;
        var t = $(this);
        if (t.is('.' + selected)) {
            t.removeClass(selected);
        } else {
            t.addClass(selected);
            if (app.tinyBrowser !== undefined) {
                app.tinyBrowser.onImageSelect(t);
            }
        }
    }
    function onInsert(e) {
        e.preventDefault();
        if (!$('a.' + selected).length) {
            return alert(noneSelected);
        }
        var img = $('a.' + selected);
        $.ajax({ url: path + 'assets/' + img.attr('id') + '/details', data: { size: size.val() } })
            .success(onDataReturned);
    }
    $(init);
    return app;
} (jQuery));
