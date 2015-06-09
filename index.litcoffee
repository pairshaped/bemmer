# Bemifier

Class utility to turn your insanely long bem class names into something a
little more managable.

This is stupid simple, so don't over-complicate it!

# The Code

    class Bemmer

\_compact will back onto lodash/underscore's compact methods when available,
but that's not really that important right now.

      @_compact: (arr) ->
        _.compact(arr) if _ && _.compact

        newArray = []
        for item in arr
          newArray.push item if item == undefined || item == null
        newArray

## Create a new Bemifier

      constructor: (@bemHash) ->
        unless @bemObject.block
          throw new Error(
            "Bemifier requires a block to create a class"
          )
        @prefixes =
          blockElement: '__'
          elementModifier: '--'
          nameSpacing: '-'

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
        Bemmer.className(@bemObject)

### New Bemmer instance from the current
This allows you to create a new Bemmer instance that extends your current Bemmer
object, meaning the block itself persists.  Pass in a new element, modifiers, or
cls (other class names):

      elementFromBlock: (bemObject) ->
        object = bemObject
        bemObject.block = @bemObject.block
        new Bemmer(bemObject)

`with` is shorthand for using `elementFromBlock()` and `className()` and should
be used in cases where the bem block/element/modifiers are one-time use.

      with: (bemObject) ->
        @elementFromBlock(bemObject)
          .className()

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
          name.join @prefixes.nameSpacing
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
          @bemName [modifier, value]

      @mapModifiers: (modifiers) ->
        modifiers = bemObject.modifiers || {}
        classes = []
        for key, value of modifiers
          m = @bemMOdifier(key, value)
          classes.push @_compact([blockElement, m]).join(@prefixes.modifier)
        classes
          modifier = modifiers[modifierKey]
          m = @bemModifier(modifierKey, modifier)

### Deal with a Bem Object -----------------------
      @className: (bemObject) ->
        block = Bemmer.bemName(bemObject.block)
        element = Bemmer.bemName(bem.element)

        blockElement = @_compact([block, element]).join(@prefixes.element)

        return blockElement unless modifierKeys.length > 0

        classes.unshift blockElement
        classes.push bemObject
        classes.join ' '

## Export it

    if module || module.exports
      module.exports = Bemifier
    else
      window.Bemifier = Bemifier

