# Bemmer

Class utility to turn your insanely long bem class names into something a
little more managable.

This is stupid simple, so don't over-complicate it!

# The Code

    class Bemmer

\_compact will back onto lodash/underscore's compact methods when available,
but that's not really that important right now.

      @_compact: (arr) ->
        return _.compact(arr) if typeof _ == 'function' && _

        newArray = []
        for item in arr
          newArray.push item unless item == undefined || item == null
        newArray

      @prefixes:
        blockElement: '__'
        elementModifier: '--'
        nameSpacing: '-'

## Create a new Bemmer object

      constructor: (@bemHash) ->
        unless @bemHash.block
          throw new Error(
            "Bemmer needs an object with a 'block' key to make css classes."
          )

There is no magic or behind the scenes illusion here.  You may
specify non-default spacing if you desire, but the defaults are
the BEM standard.

> my-block__my-element--my-modifier
>   ^     ^           ^
>   |     |           +- elementModifier
>   |     +- blockElement
>   +- nameSpacing

## Use it

### Get the class names from the bem object
This just calls our static methods, while keeping everything
nicely wrapped in the class.

      classes: ->
        Bemmer.className(@bemHash)

### New Bemmer instance from the current
This allows you to create a new Bemmer instance that extends your current Bemmer
object, meaning the block itself persists.  Pass in a new element, modifiers, or
cls (other class names):

      elementFromBlock: (bemObject) ->
        object = bemObject
        bemObject.block = @bemObject.block
        new Bemmer(bmObject)

`with` is shorthand for using `elementFromBlock()` and `classes()` and should
be used in cases where the bem block/element/modifiers are one-time use.

      with: (bemObject) -> @elementFromBlock(bemObject).classes()

Just pass in a series of BEM-like javascript objects.
Those objects should look something like this:

> myFirstBemObject = {
>   block: 'what-a-blocky-mark'
>   element: 'the-fifth'
>   modifiers:
>     'active': true
> }

Modifiers are just a way of conditionally setting
parts of a class.  If the value of the key/value
pair is true, then the key is appended to the end
of the class.  If you have multiple modifiers,
this method generates a set of classes.

For example, if I had modifiers for both 'cool'
and 'awesome', my code/output may look like this:

> bem.classNames({
>   block: 'my-block',
>   modifiers: {
>     'cool': true,
>     'awesome': true
>   }
>
> });
>
> "my-block my-block--cool my-block--awesome"

### But I'm using some third party libs, and string concat'ing is gross!

Add some custom css classes as the first parameter:

> bem.classNames('btn btn-primary', {
>   block: 'my-custom-button',
>   modifiers: {
>     'large': true
>   }
>
> })

> "btn btn-primary my-custom-button my-custom-button--large"

## Boring stuff you don't care about unless you want to help optimize

You probably don't care about these methods...

      @bemName: (name) ->
        if name instanceof Array
          name.join Bemmer.prefixes.nameSpacing
        else
          name

### Handle a Bem modifier

If the value is truthy ("active", true),
then decide whether to include 'modifier'.

If the value is non-truthy (string, number),
then append the modifier with the value:
bemModifier("test", "yes") == "test-yes"

      @bemModifier: (modifier, value) ->
        if !!value == value
          modifier if value
        else
          Bemmer.bemName [modifier, value]

      @mapModifiers: (modifiers, blockElement) ->
        modifiers = modifiers || {}
        classes = []
        for key, value of modifiers
          m = @bemModifier(key, value)
          element = @_compact([blockElement, m])
            .join(Bemmer.prefixes.elementModifier)
          classes.push element
        classes

### Deal with a Bem Object

      @className: (bemObject) ->
        block = Bemmer.bemName(bemObject.block)
        element = Bemmer.bemName(bemObject.element)
        classes = []
        classes = [bemObject.classNames] if bemObject.classNames

        blockElement = Bemmer
          ._compact([block, element])
          .join(Bemmer.prefixes.blockElement)

        classes.push blockElement

        classes = classes.concat(
          Bemmer.mapModifiers(bemObject.modifiers, blockElement)
        )
        classes.join(' ')

## Export it

    if typeof define == 'function' && typeof define.amd == 'object' && define.amd
      define -> Bemmer
    else if typeof module != 'undefined' && module.exports
      module.exports.Bemmer = Bemmer
    else
      window.Bemmer = Bemmer

