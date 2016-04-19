test = require '../test'
### eslint-env node, mocha ###

moment = require 'moment'

describe "format helper", ->

  it "should format dates", ->
    context =
      date: new Date('1974-01-23')
    test.equal '{{format date "LL"}}', context, 'January 23, 1974'

  it "should parse and format dates", ->
    test.equal '{{format "1974-01-23" "LL"}}', context, 'January 23, 1974'

  it "should format dates intl", ->
    context =
      date: new Date('1974-01-23')
    oldLocale = moment.locale()
    moment.locale 'de'
    test.equal '{{format date "LL"}}', context, '23. Januar 1974'
    test.equal '{{#format "LL"}}1974-01-23{{/format}}', context, '23. Januar 1974'
    moment.locale oldLocale

  it "should format dates intl with specified language", ->
    test.equal '{{format "1974-01-23" "LL" "de"}}', context, '23. Januar 1974'


  it "should allow unit format", ->
    test.equal '{{unit x}}', {x: '1234567mm'}, '1.23 km'
    test.equal '{{unit x "mm"}}', {x: 1234567}, '1.23 km'
    test.equal '{{unit x "mm" "km"}}', {x: 1234567}, '1.23 km'
    test.equal '{{unit x "mm" "km" "0.000"}}', {x: 1234567}, '1.235 km'
    test.equal '{{unit x "mm" "km" "0.000" "de"}}', {x: 1234567}, '1,235 km'
    test.equal '{{unit x "mm" "m" "0"}}', {x: 1234567}, '1235 m'
    test.equal '{{#unit}}1234567mm{{/unit}}', context, '1.23 km'
