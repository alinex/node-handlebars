test = require '../test'
### eslint-env node, mocha ###

describe "math helper", ->

  it "should add date interval", ->
    context =
      date: new Date('1974-01-23')
    test.equal '{{#date "LL"}}{{addDate date 1 "month"}}{{/date}}',
    context, 'February 23, 1974'
    test.equal '{{#date "LL"}}{{addDate date -1 "month"}}{{/date}}',
    context, 'December 23, 1973'
    test.equal '{{#date "LL"}}{{#addDate 1 "month"}}1974-01-23{{/addDate}}{{/date}}',
    context, 'February 23, 1974'

  it "should subtract date interval", ->
    context =
      date: new Date('1974-01-23')
    test.equal '{{#date "LL"}}{{subtractDate date 1 "month"}}{{/date}}',
    context, 'December 23, 1973'
    test.equal '{{#date "LL"}}{{subtractDate date -1 "month"}}{{/date}}',
    context, 'February 23, 1974'
    test.equal '{{#date "LL"}}{{#subtractDate 1 "month"}}1974-01-23{{/subtractDate}}{{/date}}',
    context, 'December 23, 1973'

  it "should add number", ->
    test.equal '{{add 5 1}}', null, '6'

  it "should subtract number", ->
    test.equal '{{subtract 5 1}}', null, '4'
