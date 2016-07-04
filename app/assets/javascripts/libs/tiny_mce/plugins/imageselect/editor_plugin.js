(function() {
    tinymce.create('tinymce.plugins.ImageSelectPlugin', {
        init: function(ed, url) {
            ed.addCommand('mceImageSelect', function() {
                ed.windowManager.open({
                    file: '/admissions/assets/browse',
                    width: 840,
                    height: 590,
                    inline: 1,
                    popup_css: url + '/css/pop.css'
                }, {
                    plugin_url: url
                });
            });
            ed.addButton('imageselect', {
                title: 'Add Image',
                cmd: 'mceImageSelect',
                image: url + '/img/icon.gif'
            });
            ed.onNodeChange.add(function(ed, cm, n) {
                cm.setActive('imageselect', n.nodeName == 'IMG');
            });
        },
        createControl: function(n, cm) {
            return null;
        },
        _insertText: function(content) {
            this.editor.execCommand("mceInsertRawHTML", false, 'wwot');
        },
        getInfo: function() {
            return {
                longname: 'Image Select Plugin',
                author: 'cbrown',
                authorurl: 'http://www.bottleupandexplode.com',
                version: '1.0'
            };
        }
    });
    tinymce.PluginManager.add('imageselect', tinymce.plugins.ImageSelectPlugin);
})();
