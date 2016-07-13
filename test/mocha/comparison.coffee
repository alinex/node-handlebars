test = require '../test'
### eslint-env node, mocha ###

describe "conditions", ->

  it "should allow is", ->
    test.equal '{{#is x}} 1 {{else}} 2 {{/is}}', {x: true}, ' 1 '
    test.equal '{{#is x}} 1 {{else}} 2 {{/is}}', {x: 'd'}, ' 1 '
    test.equal '{{#is x}} 1 {{else}} 2 {{/is}}', {x: 1}, ' 1 '
    test.equal '{{#is x}} 1 {{else}} 2 {{/is}}', {x: false}, ' 2 '
    test.equal '{{#is y}} 1 {{else}} 2 {{/is}}', {x: true}, ' 2 '
    test.equal '{{#is x}} 1 {{else}} 2 {{/is}}', {x: ''}, ' 2 '

  it "should allow is equal", ->
    test.equal '{{#is x y}} 1 {{else}} 2 {{/is}}', {x: 1, y: 1}, ' 1 '
    test.equal '{{#is x "==" y}} 1 {{else}} 2 {{/is}}', {x: 1, y: 1}, ' 1 '
    test.equal '{{#is x y}} 1 {{else}} 2 {{/is}}', {x: 1, y: 2}, ' 2 '
    test.equal '{{#is x "==" y}} 1 {{else}} 2 {{/is}}', {x: 1, y: 2}, ' 2 '
    test.equal '{{#is x "not" y}} 1 {{else}} 2 {{/is}}', {x: 1, y: 1}, ' 2 '
    test.equal '{{#is x "!=" y}} 1 {{else}} 2 {{/is}}', {x: 1, y: 1}, ' 2 '
    test.equal '{{#is x "not" y}} 1 {{else}} 2 {{/is}}', {x: 1, y: 2}, ' 1 '
    test.equal '{{#is x "!=" y}} 1 {{else}} 2 {{/is}}', {x: 1, y: 2}, ' 1 '

  it "should allow is (number comparison)", ->
    test.equal '{{#is x ">" y}} 1 {{else}} 2 {{/is}}', {x: 2, y: 1}, ' 1 '
    test.equal '{{#is x ">=" y}} 1 {{else}} 2 {{/is}}', {x: 2, y: 2}, ' 1 '
    test.equal '{{#is x "<" y}} 1 {{else}} 2 {{/is}}', {x: 2, y: 3}, ' 1 '
    test.equal '{{#is x "<=" y}} 1 {{else}} 2 {{/is}}', {x: 2, y: 2}, ' 1 '
    test.equal '{{#is x ">" y}} 1 {{else}} 2 {{/is}}', {x: 1, y: 2}, ' 2 '
    test.equal '{{#is x ">=" y}} 1 {{else}} 2 {{/is}}', {x: 1, y: 2}, ' 2 '
    test.equal '{{#is x "<" y}} 1 {{else}} 2 {{/is}}', {x: 2, y: 2}, ' 2 '
    test.equal '{{#is x "<=" y}} 1 {{else}} 2 {{/is}}', {x: 2, y: 1}, ' 2 '

  it "should allow is (collection)", ->
    test.equal '{{#is x "in" y}} 1 {{else}} 2 {{/is}}', {x: '2', y: '1,2,3,4'}, ' 1 '
    test.equal '{{#is x "in" y}} 1 {{else}} 2 {{/is}}', {x: 2, y: [1, 2, 3, 4]}, ' 1 '
    test.equal '{{#is x "in" y}} 1 {{else}} 2 {{/is}}', {x: '6', y: '1,2,3,4'}, ' 2 '
    test.equal '{{#is x "in" y}} 1 {{else}} 2 {{/is}}', {x: 6, y: [1, 2, 3, 4]}, ' 2 '
    test.equal '{{#is x "!in" y}} 1 {{else}} 2 {{/is}}', {x: '2', y: '1,2,3,4'}, ' 2 '
    test.equal '{{#is x "!in" y}} 1 {{else}} 2 {{/is}}', {x: 2, y: [1, 2, 3, 4]}, ' 2 '
    test.equal '{{#is x "!in" y}} 1 {{else}} 2 {{/is}}', {x: '6', y: '1,2,3,4'}, ' 1 '
    test.equal '{{#is x "!in" y}} 1 {{else}} 2 {{/is}}', {x: 6, y: [1, 2, 3, 4]}, ' 1 '

  it "should allow is (on array)", ->
    test.equal '{{#is x}} 1 {{else}} 2 {{/is}}', {x: [1]}, ' 1 '
    test.equal '{{#is x}} 1 {{else}} 2 {{/is}}', {x: [9]}, ' 1 '
    test.equal '{{#is x}} 1 {{else}} 2 {{/is}}', {x: [9, 2]}, ' 1 '
    test.equal '{{#is x}} 1 {{else}} 2 {{/is}}', {x: []}, ' 2 '

  it "should allow is (elements on array)", ->
    test.equal '{{#is x y}} 1 {{else}} 2 {{/is}}', {x: [1], y: 1}, ' 1 '
    test.equal '{{#is x y}} 1 {{else}} 2 {{/is}}', {x: [9], y: 1}, ' 1 '
    test.equal '{{#is x y}} 1 {{else}} 2 {{/is}}', {x: [9, 2], y: 2}, ' 1 '
    test.equal '{{#is x y}} 1 {{else}} 2 {{/is}}', {x: [], y: 1}, ' 2 '
    test.equal '{{#is x y}} 1 {{else}} 2 {{/is}}', {x: [9, 2], y: 1}, ' 2 '

  it "should allow is (on object)", ->
    test.equal '{{#is x}} 1 {{else}} 2 {{/is}}', {x: {a: 1}}, ' 1 '
    test.equal '{{#is x}} 1 {{else}} 2 {{/is}}', {x: {a: 1, b: 2}}, ' 1 '
    test.equal '{{#is x}} 1 {{else}} 2 {{/is}}', {x: {}}, ' 2 '

  it "should allow is (elements on object)", ->
    test.equal '{{#is x y}} 1 {{else}} 2 {{/is}}', {x: {a: 1}, y: 1}, ' 1 '
    test.equal '{{#is x y}} 1 {{else}} 2 {{/is}}', {x: {a: 2}, y: 1}, ' 1 '
    test.equal '{{#is x y}} 1 {{else}} 2 {{/is}}', {x: {a: 1, b: 2}, y: 2}, ' 1 '
    test.equal '{{#is x y}} 1 {{else}} 2 {{/is}}', {x: {}, y: 1}, ' 2 '
    test.equal '{{#is x y}} 1 {{else}} 2 {{/is}}', {x: {a: 1, b: 2}, y: 1}, ' 2 '

  it "should allow in each context", ->
    context =
      list: [0, 1, 2, 3, 4, 5]
    test.equal """
      {{#each list}}
        {{#if this}}
          if has {{this}}
        {{/if}}
        {{#is this}}
          is has {{this}}
        {{/is}}
      {{/each}}
      """
    , context, '    if has 1\n    is has 1\n    if has 2\n    is has 2\n    if has 3\n    is has 3\n    if has 4\n    is has 4\n    if has 5\n    is has 5\n'

  it "should allow in iterate context", ->
    context =
      list: [0, 1, 2, 3, 4, 5]
    test.equal """
      {{#iterate list}}
        {{#if value}}
          if has {{value}}
        {{/if}}
        {{#is value}}
          is has {{value}}
        {{/is}}
      {{/iterate}}
      """
    , context, '    if has 1\n    is has 1\n    if has 2\n    is has 2\n    if has 3\n    is has 3\n    if has 4\n    is has 4\n    if has 5\n    is has 5\n'
