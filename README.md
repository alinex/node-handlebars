Package: alinex-handlebars
=================================================

[![Build Status](https://travis-ci.org/alinex/node-handlebars.svg)](https://travis-ci.org/alinex/node-handlebars)
[![Coverage Status](https://coveralls.io/repos/alinex/node-handlebars/badge.png?branch=master)](https://coveralls.io/r/alinex/node-handlebars?branch=master)
[![Dependency Status](https://gemnasium.com/alinex/node-handlebars.png)](https://gemnasium.com/alinex/node-handlebars)

This is a collection of helper methods extending the [handlebars](http://handlebarsjs.com/)
template system.

- powerful helper
- easy to use
- easy to integrate

> It is one of the modules of the [Alinex Universe](http://alinex.github.io/code.html)
> following the code standards defined in the [General Docs](http://alinex.github.io/develop).


Install
-------------------------------------------------

[![NPM](https://nodei.co/npm/alinex-handlebars.png?downloads=true&downloadRank=true&stars=true)
 ![Downloads](https://nodei.co/npm-dl/alinex-handlebars.png?months=9&height=3)
](https://www.npmjs.com/package/alinex-handlebars)

The easiest way is to let npm add the module directly to your modules
(from within you node modules directory):

``` sh
npm install alinex-handlebars --save
```

And update it to the latest version later:

``` sh
npm update alinex-handlebars --save
```

Always have a look at the latest [changes](Changelog.md).


Usage
-------------------------------------------------

This library is implemented completely asynchronous, to allow io based checks
and references within the structure.

To use the handlebars you have to only include it and register it with your handlebars
module:

``` coffee
handlebars = require 'handlebars'
require('alinex-handlebars').register handlebars
```

That's all.


Comparison helper
-------------------------------------------------

### is

Given one argument, is acts exactly like `if`:

``` handlebars
{{#is x}} ... {{else}} ... {{/is}}
```

Given two arguments, `is` compares the two are equal:

``` handlebars
{{#is x y}} ... {{else}} ... {{/is}}
```

Given three arguments, the second argument becomes the comparator:

``` handlebars
{{#is x "not" y}} ... {{else}} ... {{/is}}
{{#is 5 ">=" 2}} ... {{else}} ... {{/is}}
```

The following comparators are supported:

- `==` or (no comparator) - equality checking
- `!=` or `not` - not equal
- `>`, `>=`, `<`, `<=` - greater/less number operators
- `in`, `!in` - check a value exists in either a comma-separated string or an array

If you use this helper with an object or array as it's first parameter it will
base the calculation on the number of entries.

``` handlebars
{{#is list 3}} ... {{else}} ... {{/is}}
```

This will use the if part if the array list contains exactly 3 entries.


String helpers
-------------------------------------------------

### lowercase

Turns a string to lowercase.

Usage:

``` handlebars
{{lowercase "THIS SHOULD BE LOWERCASE"}}
```

Result:

    this should be lowercase

### uppercase

Turns a string to uppercase.

Usage:

``` handlebars
{{uppercase "this should be lowercase"}}
```

Result:

    THIS SHOULD BE LOWERCASE

### capitalizeFirst

Capitalizes the first word in a string.

Usage:

``` handlebars
{{lowercase "this should be lowercase"}}
```

Result:

    This should be lowercase

### capitalizeEach

Capitalizes each word in a string.

Usage:

``` handlebars
{{lowercase "this should be lowercase"}}
```

Result:

    This Should Be Lowercase

### shorten

This will shorten the given text and add ellipsis if it is too long. This is done
word aware.

_Parameter:_

* test to modify
* (integer) max number oof characters

_Examples:_

``` handlebars
{{truncate "this should be lowercase" 18}}
# this should be...
```

### nobr

Transforms all spaces in non breaking spaces (UTF-8) for display. This helps in
displaying table data in narrow html view.

_Parameter:_

* test to modify

_Examples:_

``` handlebars
{{nobr "15 886"}}
```


Format helpers
-------------------------------------------------

### date

_Parameter:_

- date - to be printed (alternatively given as content)
- format (string) - defining the display format
- locale (string) - additionally specify a locale to use

_Examples:_

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

### format

_Parameter:_

- number - to be printed (alternatively given as content)
- format (string) - defining the display format
- locale (string) - additionally specify a locale to use

_Examples:_

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

_Parameter:_

- text - the text id or original text to be translated
- context - object with context
- locale - optional locale, changed from the current one

_Examples:_

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

_Parameter:_

- number - as numeric value or string with unit
- unit - the numeric value is given
- toUnit - unit to use
- format (string) - defining the display format
- locale (string) - additionally specify a locale to use

You can call it without the last parameters but don't forget one in the middle.

_Examples:_

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


Math helpers
-------------------------------------------------

### add

_Parameter:_

- base - to be changed (alternatively given as content)
- number - value to be added

_Examples:_

``` handlebars
{{#add 1}}15{{/add 1}}
# 16
```

### addDate

_Parameter:_

- date - to be changed (alternatively given as content)
- number - value to be added
- unit - (for dates only) type of interval steps like 'seconds', 'minutes', 'hours', 'days'...

_Examples:_

``` handlebars
{{#format "LL"}}{{addDate "1974-01-23" 1 "month"}}{{/format}}
# February 23, 1974

{{#addDate 1}}15{{/addDate 1}}
# 16
```

### subtract

_Parameter:_

- object - to be changed (alternatively given as content)
- number - value to be added
- unit - (for dates only) type of interval steps like 'seconds', 'minutes', 'hours', 'days'...

_Examples:_

``` handlebars
{{#subtract 1}}15{{/subtract 1}}
# 14
```
### subtractDate

_Parameter:_

- object - to be changed (alternatively given as content)
- number - value to be added
- unit - (for dates only) type of interval steps like 'seconds', 'minutes', 'hours', 'days'...

_Examples:_

``` handlebars
{{#format "LL"}}{{subtractDate "1974-01-23" 1 "month"}}{{/format}}
# December 23, 1973
```


Collection helpers
-------------------------------------------------

### interate

_Examples:_

``` handlebars
# list = ['a', 'b', 'c']
{{#iterate list}}
{{index}}: {{value}}
{{/iterate}}
# 0: a
# 1: b
# 2: c

# list = {a: 1, b: 2, c: 3}
{{#iterate list}}
{{key}}: {{value}}
{{/iterate}}
# a: 1
# b: 2
# c: 3
```

### join

_Parameter:_

- array - to be joined
- separator - to be used to join elements

_Examples:_

``` handlebars
# list = [1, 2, 3]
{{join list}}
# 1 2 3

# list = [1, 2, 3]
{{join list "-"}}
# 1-2-3

# list = {a: 1, b: 2, c: 3}
{{join list}}
# a b c
```

### count

_Examples:_

``` handlebars
# list = [1, 2, 3]
{{count list}}
# 3

# list = {a: 1, b: 2, c: 3}
{{count list}}
# 3
```


Other helpers
-------------------------------------------------

### include

This is used to include another file as it is.

> It is not interpreted as handlebars template itself but output as is.

``` handlebars
{{include "myfile.txt" }}
```

This will search for the file from the current directory. So best to use absolute
paths here.


License
-------------------------------------------------

(C) Copyright 2016 Alexander Schilling

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

>  <http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
