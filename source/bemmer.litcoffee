# Easy method wrapper for class Bemmer

Less typing with expected results.

> bemmer({block: 'my-block', element: 'my-element'})

    bemmer = (bemObject) -> Bemmer.classNames(bemObject)

## Export it

    if module? || module.exports?
      module.exports = bemmer
    else
      window.bemmer = bemmer

    if typeof define == 'function' && typeof define.amd == 'object' && define.amd
      define -> bemmer
    else if typeof module != 'undefined' && module.exports
      module.exports = bemmer
    else
      window.bemmer = bemmer


