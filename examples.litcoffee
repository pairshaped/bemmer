## Basic Usage

    var bem = new Bemifier()
    bem.classNames = {
      block: 'header',
      element: 'title',
      modifiers: = {
        'shaded': true
      }
    }

Produces:

    "header__title header__title--shaded"

## Same Example but with Coffeescript

    bem = new Bemifier()
    bem.classNames
      block: 'footer'
      element: 'title'
      modifiers:
        'shaded': true

Produces:

    "footer__title footer__title--shaded"


## With React and Coffeescript

This works similar to the classes mixin in the React Addons package.

    { div } = React.DOM

    MyComponent = React.createFactory React.createClass
      displayName: 'MyComponent'

      bem: new Bemifier()

      render: ->
        classes = @bem
          block: 'my-component'
          modifiers:
            active: @props.active

        div classNames: classes, @props.children


## Details

Just pass in a series of BEM-like javascript objects.
Those objects should look something like this:

    myFirstBemObject = {
      block: 'what-a-blocky-mark'
      element: 'the-fifth'
      modifiers:
        'active': true
    }

Produces:

    "what-a-blocky-mark__the-fifth what-a-blocky-mark__the-fifth--active"

Modifiers are just a way of conditionally setting
parts of a class.  If the value of the key/value
pair is true, then the key is appended to the end
of the class.  If you have multiple modifiers,
this method generates a set of classes.

For example, if I had modifiers for both 'cool'
and 'awesome', my code/output may look like this:

    bem.classNames({
      block: 'my-block',
      modifiers: {
        'cool': true,
        'awesome': true
      }

    });

    "my-block my-block--cool my-block--awesome"

### But I'm using some third party libs, and string concat'ing is gross!

Add some custom css classes as the first parameter:

    bem.classNames('btn btn-primary', {
      block: 'my-custom-button',
      modifiers: {
        'large': true
      }

    })

    "btn btn-primary my-custom-button my-custom-button--large"
