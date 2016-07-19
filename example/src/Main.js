"use strict";

exports.value = function (el) {
  return function () {
    return el.value;
  };
};
