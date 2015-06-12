#
# Simple Test Method
#
#
Bemmer = require('./index.litcoffee')

Unit = (test) ->
  console.log 'Testing ', test.it
  success = false
  reality = ''
  try
    bem = new Bemmer(test.param)
    reality = bem.classes()
    console.log '>>>>>>>', reality
    if test.comparison == reality
      success = true
  catch e
    success = false
    console.log e if success != test.expect

  if success == test.expect
    console.log '  \u2713', "'#{test.comparison}'", '==', "'#{reality}'"
  else
    console.log '  \u2717', "'#{test.comparison}'", '!=', "'#{reality}'"

  return success == test.expect

#
# Test Cases
#

tests = [
  {
    it: 'will not produce classes without a block'
    param: {classes: 'test foo bar'}
    comparison: undefined
    expect: false
  }
  {
    it: 'produces same-ordered classes with spaces with only bem fields'
    param: {
      block: 'foo'
      element: 'bar-baz'
      modifiers: {
        'active': true
      }
    }
    comparison: 'foo__bar-baz foo__bar-baz--active'
    expect: true
  }
  {
    it: 'produces same-ordered classes with spaces with mixed fields'
    param: {
      block: 'foo'
      element: 'bar-baz'
      modifiers: {
        'active': true
      }
      classes: 'bar'
    }
    comparison: 'bar foo__bar-baz foo__bar-baz--active'
    expect: true
  }
  {
    it: 'produces an error when params are wrong'
    param: {
      block: 'foo'
      element: 'bar-baz'
      modifiers: {
        'active': true
      }
      classes: 'bar'
    }
    comparison: 'foo__bar-baz--active bar'
    expect: false
  }
]

success = 0
fail = 0
total = tests.length
for test in tests
  if Unit(test)
    success++
  else
    fail++

remaining = total - (success + fail)

console.log "#{success} test(s) passed",
  "#{fail} test(s) failed",
  "#{remaining} test(s) remaining"

