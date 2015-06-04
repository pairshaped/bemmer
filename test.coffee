#
# Simple Test Method
#
#
Bemifier = require('./index.litcoffee')

Unit = (test) ->
  console.log 'Testing ', test.it
  bem = new Bemifier()
  success = false
  try
    console.log bem.classNames, bem.bemName
    reality = bem.classNames(test.params...)
    if comparison == reality
      console.log '  \u2713', "'#{test.comparison}'", '==', "'#{reality}'"
      success = true
  catch error
    success = false
    console.log error
    console.log '  \u2717', "'#{test.comparison}'", '!=', "'#{reality}'"

  return success == test.expect

#
# Test Cases
#

tests = [
  {
    it: 'produces same-ordered classes with spaces with only text fields'
    params: ['test foo bar']
    comparison: 'test foo bar'
    expect: true
  }
  {
    it: 'produces same-ordered classes with spaces with only bem fields'
    params: [
      {
        block: 'foo'
        element: 'bar-baz'
        modifiers: {
          'active': true
        }
      }
    ]
    comparison: 'foo__bar-baz foo__bar-baz--active'
    expect: true
  }
  {
    it: 'produces same-ordered classes with spaces with mixed fields'
    params: [
      'bar',
      {
        block: 'foo'
        element: 'bar-baz'
        modifiers: {
          'active': true
        }
      }
    ]
    comparison: 'bar foo__bar-baz foo__bar-baz--active'
    expect: true
  }
  {
    it: 'produces an error when params are wrong'
    params: [
      {
        block: 'foo'
        element: 'bar-baz'
        modifiers: {
          'active': true
        }
      }
      'bar'
    ]
    comparison: 'foo__bar-baz--active bar'
    expect: false
  }
]

success = 0
fail = 0
for test in tests
  if Unit(test)
    success++
  else
    fail++
    break

console.log "#{success} tests passed, #{fail} tests failed"

