test = require '../test'
### eslint-env node, mocha ###

describe "object helper", ->

  it "should add date interval", ->
    context =
      date: new Date('1974-01-23')
    test.equal '{{#format "LL"}}{{dateAdd date 1 "month"}}{{/format}}',
    context, 'February 23, 1974'
    test.equal '{{#format "LL"}}{{dateAdd date -1 "month"}}{{/format}}',
    context, 'December 23, 1973'
    test.equal '{{#format "LL"}}{{#dateAdd 1 "month"}}1974-01-23{{/dateAdd}}{{/format}}',
    context, 'February 23, 1974'
