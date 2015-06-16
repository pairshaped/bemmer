var bemmer;

bemmer = function(bemObject) {
  return Bemmer.classNames(bemObject);
};

if ((typeof module !== "undefined" && module !== null) || (module.exports != null)) {
  module.exports = bemmer;
} else {
  window.bemmer = bemmer;
}

if (typeof define === 'function' && typeof define.amd === 'object' && define.amd) {
  define(function() {
    return bemmer;
  });
} else if (typeof module !== 'undefined' && module.exports) {
  module.exports = bemmer;
} else {
  window.bemmer = bemmer;
}
