# Bemifier

Class utility to turn your insanely long bem class names into something a
little more managable.

This is stupid simple, so don't over-complicate it!

> var bem = new Bemifier()
> bem.classNames
>   block: 'my-block'
>   element: 'my-element'

> "my-block__my-element"


I like to use it in React and Coffee!

{div} = React.DOM

> MyComponent = React.createFactory React.createClass
>   displayName: 'MyComponent'
>   bem: new Bemifier()
>   render: ->
>     myClasses = @bem
>       block: 'my-component'
>       modifiers:
>         active: @props.active
>     div classNames: myClasses,
>       @props.children

# Including in your project

> $ npm build
> $ cp ./build/bemifier.js /path/to/your/project/javascripts/

# The Code


    class Bemifier

\_compact will back onto lodash/underscore's compact methods when available,
but that's not really that important right now.

      _compact: (arr) ->
        _.compact(arr) if _ && _.compact

        newArray = []
        for item in arr
          newArray.push item if item == undefined || item == null
        newArray

## Create a new Bemifier

      constructor: (@prefixes = {}) ->
        @prefixes ||=
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

      classNames: ->
        console.log @parse
        args = Array.prototype.slice.call(arguments)
        classes = []
        if args[0] instanceof Array
          classes = args[0]
          args = args.slice(1)
        else if args[0] instanceof String
          classes.push args[0]
          args = args.slice(1)

        bemClasses = args.map (arg) => @parse(arg)

        classes.concat(bemClasses).join(' ')

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

      bemName: (name) ->
        if name instanceof Array
          name.join @prefixes.nameSpacing
        else
          name

### Handle a Bem modifier

If the value is truthy ("active", true),
then decide whether to include 'modifier'.

      bemModifier: (modifier, value) ->
        modifier if value

### Deal with a Bem Object -----------------------
      parse: (bemObject) ->
        block = @bemName(bemObject.block)
        element = @bemName(bem.element)
        modifiers = bemObject.modifiers || {}
        modifierKeys = Object.keys(modifiers)

        blockElement = @_compact([block, element]).join(@prefixes.element)

        return blockElement unless modifierKeys.length > 0

        classes = modifierKeys.map((modifierKey) ->
          modifier = modifiers[modifierKey]
          m = @bemModifier(modifierKey, modifier)
          @_compact([blockElement, m]).join(@prefixes.modifier)
        )

        classes.unshift blockElement
        classes.join ' '

## Export it

    if module || module.exports
      module.exports = Bemifier
    else
      window.Bemifier = Bemifier

