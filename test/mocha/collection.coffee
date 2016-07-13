test = require '../test'
### eslint-env node, mocha ###

describe "collection helper", ->

  describe "iterate", ->

    it "should step over array", ->
      context =
        list: ['a', 'b', 'c']
      test.equal """
        {{#iterate list}}
        {{index}}: {{value}}
        {{/iterate}}
        """
      , context, '0: a\n1: b\n2: c\n'

    it.only "should step over array (with included is check)", ->
      context =
        list: [0, 1, 2, 3, 4, 5]
      test.equal """
        {{#each list}}
          {{this}}
          {{#if this}}
            {{this}} {{list}}
          {{/if}}
        {{/each}}
        {{#iterate list}}
          {{value}}
          {{#is value ">" 2}}
            {{value}} {{list}}
          {{/is}}
        {{/iterate}}
        """
      , context, '0: a\n1: b\n2: c\n'

    it "should step over object", ->
      context =
        list: {a: 1, b: 2, c: 3}
      test.equal """
        {{#iterate list}}
        {{key}}: {{value}}
        {{/iterate}}
        """
      , context, 'a: 1\nb: 2\nc: 3\n'

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

    it "should keep unsupported objects untouched", ->
      test.equal '{{join obj}}', {obj: "hello"}, 'hello'

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

    it "should count characters", ->
      test.equal '{{count obj}}', {obj: "hello"}, '5'

    it "should keep unsupported objects untouched", ->
      test.equal '{{join obj}}', {obj: 5}, '5'
