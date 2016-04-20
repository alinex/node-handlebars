test = require '../test'
### eslint-env node, mocha ###

describe "collection helper", ->

  describe "join", ->

    it "should join elements of array", ->
      context =
        list: [1, 2, 3]
      test.equal '{{join list}}', context, '1 2 3'

    it "should join elements of array with separator", ->
      context =
        list: [1, 2, 3]
      test.equal '{{join list "-"}}', context, '1-2-3'

    it "should join keys of object", ->
      context =
        list:
          a: 1
          b: 2
          c: 3
      test.equal '{{join list}}', context, 'a b c'

    it "should join keys of object with separator", ->
      context =
        list:
          a: 1
          b: 2
          c: 3
      test.equal '{{join list "-"}}', context, 'a-b-c'

  describe "count", ->

    it "should count elements of array", ->
      context =
        list: [1, 2, 3]
      test.equal '{{count list}}', context, '3'

    it "should count keys of object", ->
      context =
        list:
          a: 1
          b: 2
          c: 3
      test.equal '{{count list}}', context, '3'
