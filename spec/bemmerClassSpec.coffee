
# require('jasmine-collection-matchers')

Bemmer = require('../bemmer.js')

describe 'Bemmer', ->
  describe 'aux', ->
    describe 'compact', ->
      it 'should throw if anything but an array is passed', ->
        callWrapper = -> Bemmer.aux.compact('')
        expect(callWrapper).toThrow()

      it 'should return an empty array when an empty array is passed', ->
        emptyCompact = Bemmer.aux.compact []
        expect(emptyCompact.length).toEqual(0)

      it 'should return an array length the same as the source with data', ->
        before = [1, 2, 3, 4]
        after = Bemmer.aux.compact(before)
        expect(before.length).toEqual(after.length)

      it 'should return the same array data when given an array with data', ->
        before = [1, 2, 3, 4]
        after = Bemmer.aux.compact(before)
        before.map (value, index) ->
          expect(value).toEqual(after[index])

      it 'should remove null items in an array', ->
        array = [1, 2, null, "test", {foo: 'bar'}, null]
        compacted = Bemmer.aux.compact(array)
        expect(compacted.length).toEqual(4)

  describe 'constructor', ->
    it 'should throw if anything but a hash is passed in', ->
      initialize = -> new Bemmer("test")
      expect(initialize).toThrow()

    it 'should throw if the bem hash does not contain a block', ->
      initialize = -> new Bemmer(element: 'test')
      expect(initialize).toThrow()

    it 'should not throw when a block is passed', ->
      bem = null
      initialize = -> bem = new Bemmer(block: 'test')
      expect(initialize).not.toThrow()

  describe 'bemName', ->
    it 'should throw if the parameter is not a string or array', ->
      expect(-> Bemmer.bemName(123)).toThrow()
      expect(-> Bemmer.bemName({foo: 'bar'})).toThrow()
      expect(-> Bemmer.bemName(null)).toThrow()

    it 'should return an unmodified string that is passed in', ->
      source = 'test'
      result = Bemmer.bemName(source)
      expect(result).toEqual(result)

    it 'should return a string from an array with the default separator', ->
      pieces = ['test', 'name']
      result = Bemmer.bemName(pieces)
      expect(result).toEqual('test-name')


  describe 'bemModifier', ->
    it 'should throw if modifier is not a string', ->
      expect(-> Bemmer.bemModifier(1234, true)).toThrow()

    it 'should throw if value is not a string or boolean', ->
      expect(-> Bemmer.bemModifier('test', {foo: 'bar'})).toThrow()

    it 'should return the modifier if the value is true', ->
      expect(Bemmer.bemModifier('test', true)).toEqual('test')

    it 'should return the modifier-value when the value is alphanumeric', ->
      expect(Bemmer.bemModifier('test', 123)).toEqual('test-123')

  describe 'mapModifiers', ->
    it 'should return an empty array with null for modifiers', ->
      expect(Bemmer.mapModifiers(null, 'test').length).toEqual(0)

    it 'should not accept modifiers that are not null or an object', ->
      expect(-> Bemmer.mapModifiers(12, 'test')).toThrow()

    it 'should return an array of classes with modifiers', ->
      modifiers =
        active: true
        foo: 'bar'

      classes = Bemmer.mapModifiers(modifiers, 'test')

      expectations = [
        'test--active'
        'test--foo-bar'
      ]

      for className, index in classes
        expect(expectations[index]).toEqual(className)












































