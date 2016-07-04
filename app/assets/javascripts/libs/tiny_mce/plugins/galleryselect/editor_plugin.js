(function() {
    tinymce.create('tinymce.plugins.GallerySelectPlugin', {
        init: function(ed, url) {
            ed.addCommand('mceGallerySelect', function() {
                ed.windowManager.open({ file: '/admissions/galleries/browse?tiny=true', width: 820, height: 590, inline: 1, popup_css: url + '/css/pop.css' }, { plugin_url: url });
            });
            ed.addButton('galleryselect', { title: 'Add A Gallery', cmd: 'mceGallerySelect', image: url + '/img/icon.gif' });
            ed.onNodeChange.add(function(ed, cm, n) { cm.setActive('galleryselect', n.nodeName == 'IMG'); });
        },
        createControl: function(n, cm) { return null; },
        getInfo: function() { return { longname: 'Gallery Select Plugin', author: 'caleb brown', authorurl: 'http://www.bottleupandexplode.com', version: "1.0" }; }
    });
    tinymce.PluginManager.add('galleryselect', tinymce.plugins.GallerySelectPlugin);
})();
