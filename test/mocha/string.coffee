test = require '../test'
### eslint-env node, mocha ###

describe "string helper", ->

  it "should lowercase", ->
    test.equal '{{lowercase "THIS SHOULD BE LOWERCASE"}}', null, 'this should be lowercase'

  it "should uppercase", ->
    test.equal '{{uppercase "this should be lowercase"}}', null, 'THIS SHOULD BE LOWERCASE'

  it "should capitalize first", ->
    test.equal '{{capitalizeFirst "this should be lowercase"}}', null, 'This should be lowercase'

  it "should capitallize each", ->
    test.equal '{{capitalizeEach "this should be lowercase"}}', null, 'This Should Be Lowercase'

  it "should shorten text", ->
    test.equal '{{shorten "this should be lowercase" 18}}', null, 'this should be...'

  it "should change spaces so that they don't break", ->
    test.equal '{{nobr "15 668"}}', null, '15\u00A0668'
