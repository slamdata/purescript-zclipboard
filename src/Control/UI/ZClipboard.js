// module Control.UI.ZClipboard

exports.setDataImpl = function(clipboard, key, value) {
    return function() {
        clipboard.setData(key, value);
        return clipboard;
    };
};

exports.getDataImpl = function(clipboard, key) {
    return function() {
        return clipboard.getData(key);
    };
};

exports.clearDataImpl = function(clipboard, key) {
    return function() {
        return clipboard.clearData(key);
    };
};

exports.init = function() {
    var ZC = require("zeroclipboard");
    return new ZC();
};

exports.clip = function(el) {
    return function(client) {
        return function() {
            client.clip(el);
            return client;
        };
    };
};

exports.make = function(el) {
    return function() {
        var ZC = require('zeroclipboard');
        return new ZC(el);
    };
};

exports.onCopy = function(callback) {
    return function(client) {
        return function() {
            client.on('ready', function() {
                client.on('copy', function(event) {
                    callback(event.clipboardData)();
                });
            });
            return client;
        };
    };
};
