# React Wrapper

**Warning:** This module hasn't been tested yet!

There have been a few solutions in React to capture BEM css conventions, but
none of them take out the pain of it.  This is our solution to making bem
slightly more approachable.

    Bemmer = require('../index.litcoffee')
    React = require('react/addons')

    ReactBemmer = ReactBemmer || {

This is just some boring  internal code, no need to worry yourself in here
right now.

      _wrapper: (element) ->
        (specs, children) ->
          specs.classNames Bemmer.classNames(specs.bem) if specs.bem
          element(specs, children)

# DOM Elements

React DOM elements all nicely wrapped with a bow on top.  Now all you have to
do is call these.  There is currently no reasonable way to use this in JSX,
since I can only imagine JSX backs onto React.DOM, which I am not going to 
override at this time.  You as a developer can always do an override if you
would like, that would look like this:

> React.sourceDOM = React.DOM
React.DOM = ReactBemmer.DOM

      DOM: React.DOM.map @_wrapper

# Create Class

The method from React that we all know and love, with some extra sugar.  Now
it does some extra listening for bem-style props extracts them, and overrides
your className property

      createClass: (componentName, specs) ->
        specs.displayName = componentName
        specs.bemmer = new Bemmer(componentName)
        React.createClass(specs)

      createComponent: (componentName, specs) ->
        React.createFactory @createClass(componentName, specs)

    }


## Export it

    if module? || module.exports?
      module.exports = ReactBemmer
    else
      window.ReactBemmer = ReactBemmer

