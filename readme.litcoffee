# Bemifier

Class utility to turn your insanely long bem class names into something a
little more managable.

This is stupid simple, so don't over-complicate it!

## Including in your project

### Raw Source

> $ npm build
> $ cp ./build/bemifier.js /path/to/your/project/javascripts/

### Npm

## TODO: Add npm install support

# Philosophy

Bem classes are named using blocks, elements, modifiers.  When creating classes,
you can end up with a ton of classes for just one element in a block, which may
look like this:

> .my-block {
    display: 'inline';
    border: 1px black solid;
    background-color: red;
  }

  .my-block__my-element {
    font-size: 16pt;
    font-weight: bold;
    color: white;
  }

  .my-block--active {
    background-color: white;
  }

  .my-block__my-element--active {
    color: red;
  }

Obviously, the pain comes to implementing it in your HTML/javascripts:

```
<div class="my-block my-block--active">
<span class="my-block__my-element my-block__my-element--active">
Hello World!
</span>
</div>
```




# Examples

These examples are written in coffeescript, but I have written them in a way
that they more closely resemble plain old javascript.  You can safely ignore
any arrows ('->'), which just denote functions.

    require './index.litcoffee'


## Basic Usage

    console.log('%cBlue!', 'Basic Usage Example:')

    bem = new Bemifier()

    output = bem.classNames = {
      block: 'header',
      element: 'title',
      modifiers: {
        'shaded': true
      }
    }

Produces:

    console.log('Expected Output: ', "header__title header__title--shaded")
    console.log('Received Output: ', output)

## With React and Coffeescript

This works similar to the classes mixin in the React Addons package.

    console.log('%cBlue!', 'Bemifier with React and Coffeescript')

    div = React.DOM.div

    MyComponent = React.createFactory React.createClass({
      displayName: 'MyComponent',

      bem: new Bemifier(),

      render: ->
        classes = @bem({
          block: 'my-component',
          modifiers: {
            active: @props.active
          }
        })

        return div({classNames: classes}, @props.children)
    })


## Details

Just pass in a series of BEM-like javascript objects.
Those objects should look something like this:

    myFirstBemObject = {
      block: 'what-a-blocky-mark',
      element: 'the-fifth',
      modifiers: {
        'active': true
      }
    }

Should produce something like this:

> "what-a-blocky-mark__the-fifth what-a-blocky-mark__the-fifth--active"

    console.log('What does a BEM Object look like?', myFirstBemObject)


Modifiers are just a way of conditionally setting
parts of a class.  If the value of the key/value
pair is true, then the key is appended to the end
of the class.  If you have multiple modifiers,
this method generates a set of classes.

For example, if I had modifiers for both 'cool'
and 'awesome', my code/output may look like this:


    bemObject = {
      block: 'my-block',
      modifiers: {
        'cool': true,
        'awesome': true
      }
    }

    bemClasses = bem.classNames(bemObject)

Should produce something like this:

> "my-block my-block--cool my-block--awesome"

    console.log('How do more complex modifiers work?', bomObject, bemClasses)

### But I'm using some third party libs, and string concat'ing is gross!

Add some custom css classes as the first parameter:


    bemClasses = bem.classNames('btn btn-primary', {
      block: 'my-custom-button',
      modifiers: {
        'large': true
      }
    })

Should produce something like this:

> "btn btn-primary my-custom-button my-custom-button--large"

    console.log('CSS class name concatenation with 3rd party classes:', bemClasses)

## Run this in node/your browser!

To run this in your console with node:

`npm run readme`

To run this in your browser:

`npm run webapp`

# Resources

To learn more about BEM, check out some of these resources:

 * [bem.info](https://en.bem.info/method/definitions/)
 * [bem-react](https://github.com/dfilatov/bem-react), a wrapper around react,
using bem.info's JSON notation for components.
 * [react-bem](https://github.com/cuzzo/react-bem), a react mixin handle bem
css classes.
 * [bemify](https://github.com/franzheidl/bemify) is a set of Sass mixins to
write well structured Sass with BEM.
