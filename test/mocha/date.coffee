test = require '../test'
### eslint-env node, mocha ###

moment = require 'moment'

describe "date helper", ->

  it "should format dates", ->
    context =
      date: new Date('1974-01-23')
    test.equal '{{dateFormat date "LL"}}', context, 'January 23, 1974'

  it "should format dates intl", ->
    context =
      date: new Date('1974-01-23')
    oldLocale = moment.locale()
    moment.locale 'de'
    test.equal '{{dateFormat date "LL"}}', context, '23. Januar 1974'
    test.equal '{{#dateFormat "LL"}}1974-01-23{{/dateFormat}}', context, '23. Januar 1974'
    moment.locale oldLocale

  it "should add date interval", ->
    context =
      date: new Date('1974-01-23')
    test.equal '{{#dateFormat "LL"}}{{dateAdd date 1 "month"}}{{/dateFormat}}',
    context, 'February 23, 1974'
    test.equal '{{#dateFormat "LL"}}{{dateAdd date -1 "month"}}{{/dateFormat}}',
    context, 'December 23, 1973'
    test.equal '{{#dateFormat "LL"}}{{#dateAdd 1 "month"}}1974-01-23{{/dateAdd}}{{/dateFormat}}',
    context, 'February 23, 1974'

  it "should allow unit format", ->
    test.equal '{{unitFormat x}}', {x: '1234567mm'}, '1.23 km'
    test.equal '{{unitFormat x "mm"}}', {x: 1234567}, '1.23 km'
    test.equal '{{unitFormat x "mm" "km"}}', {x: 1234567}, '1.23 km'
    test.equal '{{unitFormat x "mm" "m"}}', {x: 1234567}, '1230 m'
    test.equal '{{unitFormat x "mm" "m" 4}}', {x: 1234567}, '1235 m'
