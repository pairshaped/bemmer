var bemmer;

bemmer = function(bemObject) {
  return Bemmer.classNames(bemObject);
};

if (typeof define === 'function' && typeof define.amd === 'object' && define.amd) {
  define(function() {
    return bemmer;
  });
} else if (typeof module !== 'undefined' && module.exports) {
  module.exports.bemmer = bemmer;
} else {
  window.bemmer = bemmer;
}
