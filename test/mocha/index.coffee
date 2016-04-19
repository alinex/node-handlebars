test = require '../test'
### eslint-env node, mocha ###

describe "general", ->

  it "should match normal string", ->
    test.equal 'hello', null, 'hello'

  it "should compile handlebars", ->
    test.equal 'hello {{name}}', {name: 'alex'}, 'hello alex'
