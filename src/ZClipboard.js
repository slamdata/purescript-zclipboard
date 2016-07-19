"use strict";

exports.setData = function (key) {
  return function (value) {
    return function (clipboard) {
      return function () {
        clipboard.setData(key, value);
        return clipboard;
      };
    };
  };
};

exports.getData = function (key) {
  return function (clipboard) {
    return function () {
      return clipboard.getData(key);
    };
  };
};

exports.clearData = function (key) {
  return function (clipboard) {
    return function () {
      return clipboard.clearData(key);
    };
  };
};

exports.init = function () {
  var ZC = require("zeroclipboard");
  return new ZC();
};

exports.clip = function (el) {
  return function (client) {
    return function () {
      client.clip(el);
      return client;
    };
  };
};

exports.make = function (el) {
  return function () {
    var ZC = require("zeroclipboard");
    return new ZC(el);
  };
};

exports.onCopy = function (callback) {
  return function (client) {
    return function () {
      client.on("ready", function () {
        client.on("copy", function (event) {
          callback(event.clipboardData)();
        });
      });
      return client;
    };
  };
};
