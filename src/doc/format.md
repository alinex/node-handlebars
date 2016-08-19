Format helpers
=================================================

### date (inline/block)

Output date in specific format (alos supporting localization).

__Parameter:__

- `Date` to be printed (alternatively given as content)
- `String` defining the display format (optional)
- `String` additionally specify a locale to use (optional)

``` handlebars
{{date mydate "MMMM YYYY"}}
# January 2016

{{date mydate "LL" "de"}}
# 18. January 2016

{{#date "LL"}}2016-01-20{{/date}}
# January 18, 2016
```

See the description of [moment.js](http://momentjs.com/docs/#/displaying/) for
the possible format strings.

The language for the date format can be given as last argument (two letter code).

### format (inline/block)

__Parameter:__

- `Number` to be printed (alternatively given as content)
- `String` defining the display format (optional)
- `String` additionally specify a locale to use (optional)

``` handlebars
{{format 123.45 "0.0"}}
# 123.5

{{format 123.45 "0.0" "de"}}
# 123,5

{{#format "0.0"}}123.45{{/format}}
# 123.5
```

See the description of [numeral.js](http://numeraljs.com/) for the possible format
strings.

The language for the number format can be given as last argument (two letter code).

### i18n

Support internationalization, but only if configured before using the
[i18n](https://github.com/mashpie/i18n-node) package like:

``` coffee
i18n = require 'i18n'
i18n.configure
  defaultLocale: 'en'
  directory: __dirname + '/../var/locale'
  objectNotation: true
```

__Parameter:__

- `String` the text id or original text to be translated
- `Object` object with context
- `String` optional locale, changed from the current one

``` handlebars
{{i18n "button.go"}}
# Go

{{i18n "button.go" null "de"}}
# Los

{{i18n "results" 6 "de"}}
# 6 Ergebnisse
```

### unit

Formats a value with unit.

__Parameter:__

- `Number` as numeric value or string with unit
- `String` the unit, the value is given
- `String` the unit to convert to
- `String` defining the display format
- `String` additionally specify a locale to use

You can call it without the last parameters but don't forget one in the middle.

``` handlebars
x = '1234567mm'
{{unit x}}            # 1.23 km

{{unit 1234567 "mm"}}       
# 1.23 km

{{unit 1234567 "mm" "km"}}
# 1.23 km

{{unit 1234567 "mm" "m"}}
# 1235 m

{{unit 1234567 "mm" "km" "0.0"}}
# 1.2 km

{{unit 1234567 "mm" "km" "0.0" "de"}}
# 1,2 km
```
