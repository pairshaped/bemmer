var Bemmer, React, ReactBemmer;

Bemmer = require('../bemmer-class');

React = require('react/addons');

ReactBemmer = ReactBemmer || {
  _wrapper: function(element) {
    return function(specs, children) {
      if (specs.bem) {
        specs.classNames = Bemmer.classNames(specs.bem);
      }
      return element(specs, children);
    };
  },
  DOM: React.DOM.map(this._wrapper),
  createClass: function(componentName, specs) {
    specs.displayName = componentName;
    specs.bemmer = new Bemmer({
      block: componentName
    });
    return React.createClass(specs);
  },
  createComponent: function(componentName, specs) {
    return React.createFactory(this.createClass(componentName, specs));
  }
};

if (typeof define === 'function' && typeof define.amd === 'object' && define.amd) {
  define(function() {
    return ReactBemmer;
  });
} else if (typeof module !== 'undefined' && module.exports) {
  module.exports = ReactBemmer;
} else {
  window.ReactBemmer = ReactBemmer;
}
