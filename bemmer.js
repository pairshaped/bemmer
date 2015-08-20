var Bemmer;

Bemmer = (function() {
  Bemmer.prefixes = {
    blockElement: '__',
    elementModifier: '--',
    nameSpacing: '-'
  };

  function Bemmer(bemHash) {
    this.bemHash = bemHash;
    if (!this.bemHash.block) {
      throw new Error("Bemmer needs an object with a 'block' key to make css classes.");
    }
  }

  Bemmer.prototype.classes = function() {
    return Bemmer.className(this.bemHash);
  };

  Bemmer.prototype.elementFromBlock = function(bemObject) {
    var object;
    object = bemObject;
    bemObject.block = this.bemHash.block;
    return new Bemmer(bemObject);
  };

  Bemmer.prototype["with"] = function(bemObject) {
    return this.elementFromBlock(bemObject).classes();
  };

  Bemmer.bemName = function(name) {
    var isArray, isString;
    isArray = name instanceof Array;
    isString = typeof name === "string";
    if (!(isArray || isString)) {
      throw new Error(['Bemmer.bemName:', 'expects name to either be a string or array of strings,', "got " + (typeof name) + "."].join(' '));
    }
    if (name instanceof Array) {
      return name.join(Bemmer.prefixes.nameSpacing);
    } else {
      return name;
    }
  };

  Bemmer.bemModifier = function(modifier, value) {
    var isValueAlphaNumeric, isValueTruthy;
    if (typeof modifier !== 'string') {
      throw new Error(['Bemmer.bemModifier:', 'expected modifier to be a string,', "got a " + (typeof modifier)].join(' '));
    }
    isValueTruthy = value === !!value;
    isValueAlphaNumeric = (typeof value === 'string') || (typeof value === 'number');
    if (!(isValueTruthy || isValueAlphaNumeric)) {
      throw new Error(['Bemmer.bemModifier:', 'expected value to be string, number, or boolean,', "got a " + (typeof value)].join(' '));
    }
    if (isValueTruthy) {
      if (value) {
        return modifier;
      }
    } else {
      return Bemmer.bemName([modifier, value]);
    }
  };

  Bemmer.mapModifiers = function(modifiers, blockElement) {
    var classes, element, isModifiersArray, isModifiersObject, key, m, value;
    isModifiersObject = typeof modifiers === 'object';
    isModifiersArray = modifiers instanceof Array;
    if (!isModifiersObject || isModifiersArray) {
      throw new Error(['Bemmer.mapModifiers:', 'expected modifiers to be an object or null,', "got a " + (typeof modifiers)].join(' '));
    }
    classes = [];
    for (key in modifiers) {
      value = modifiers[key];
      m = Bemmer.bemModifier(key, value);
      element = Bemmer.aux.compact([blockElement, m]).join(Bemmer.prefixes.elementModifier);
      classes.push(element);
    }
    return classes;
  };

  Bemmer.className = function(bemObject) {
    var block, blockElement, classes, element;
    block = Bemmer.bemName(bemObject.block);
    element = Bemmer.bemName(bemObject.element);
    classes = [];
    if (bemObject.classNames) {
      classes = [bemObject.classNames];
    }
    blockElement = Bemmer._compact([block, element]).join(Bemmer.prefixes.blockElement);
    classes.push(blockElement);
    classes = classes.concat(Bemmer.mapModifiers(bemObject.modifiers, blockElement));
    return classes.join(' ');
  };

  Bemmer.aux = {
    compact: function(arr) {
      var i, item, len, newArray;
      if (!(arr instanceof Array)) {
        throw new Error(["Bemmer.aux.compact:", "expected an Array, got a " + (typeof arr)].join(' '));
      }
      newArray = [];
      for (i = 0, len = arr.length; i < len; i++) {
        item = arr[i];
        if (!(item === void 0 || item === null)) {
          newArray.push(item);
        }
      }
      return newArray;
    }
  };

  return Bemmer;

})();

if (typeof define === 'function' && typeof define.amd === 'object' && define.amd) {
  define(function() {
    return Bemmer;
  });
} else if (typeof module !== 'undefined' && module.exports) {
  module.exports = Bemmer;
} else {
  window.Bemmer = Bemmer;
}
