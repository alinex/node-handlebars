test = require '../test'
### eslint-env node, mocha ###

moment = require 'moment'

describe "format helper", ->

  describe "date", ->

    it "should format dates", ->
      context =
        date: new Date('1974-01-23')
      test.equal '{{date date "LL"}}', context, 'January 23, 1974'

    it "should parse and format dates", ->
      test.equal '{{date "1974-01-23" "LL"}}', context, 'January 23, 1974'

    it "should parse natural dates", ->
      test.equal '{{date "now" "LL"}}', context, moment().format "LL"

    it "should format dates intl", ->
      context =
        date: new Date('1974-01-23')
      oldLocale = moment.locale()
      moment.locale 'de'
      test.equal '{{date date "LL"}}', context, '23. Januar 1974'
      test.equal '{{#date "LL"}}1974-01-23{{/date}}', context, '23. Januar 1974'
      moment.locale oldLocale

    it "should format dates intl with specified language", ->
      test.equal '{{date "1974-01-23" "LL" "de"}}', context, '23. Januar 1974'

    it "should keep unsupported objects untouched", ->
      test.equal '{{date obj}}', {obj: new Error 1}, moment().format('YYYY-MM-DD')
#      test.equal '{{date obj}}', {obj: 'hello'}, moment().format('YYYY-MM-DD')

  describe "format", ->

    it "should format numbers", ->
      test.equal '{{format 123.45 "0.0"}}', context, '123.5'
      test.equal '{{format 123.45 "0.0" "de"}}', context, '123,5'
      test.equal '{{#format "0.0"}}123.45{{/format}}', context, '123.5'

    it "should keep unsupported objects untouched", ->
      test.equal '{{format obj}}', {obj: new Error 1}, 'Error: 1'

  describe "i18n", ->

    i18n = require 'i18n'
    i18n.configure
      defaultLocale: 'en'
      directory: __dirname + '/../data/locale'
      objectNotation: true

    it "should show international text", ->
      test.equal '{{i18n "button.go"}}', null, 'Go'

    it "should show international text with context", ->
      test.equal '{{i18n "counter:counting to %d" 5}}', null, 'counting to 5'

    it "should show international text in other language", ->
      test.equal '{{i18n "button.go" null "de"}}', null, 'Los'

  describe "unit", ->

    it "should allow unit format", ->
      test.equal '{{unit x}}', {x: '1234567mm'}, '1.23 km'
      test.equal '{{unit x "mm"}}', {x: 1234567}, '1.23 km'
      test.equal '{{unit x "mm" "km"}}', {x: 1234567}, '1.23 km'
      test.equal '{{unit x "mm" "km" "0.000"}}', {x: 1234567}, '1.235 km'
      test.equal '{{unit x "mm" "km" "0.000" "de"}}', {x: 1234567}, '1,235 km'
      test.equal '{{unit x "mm" "m" "0"}}', {x: 1234567}, '1235 m'
      test.equal '{{#unit}}1234567mm{{/unit}}', context, '1.23 km'

#    it "should keep unsupported objects untouched", ->
#      test.equal '{{unit obj}}', {obj: new Error 1}, 'Error: 1'
