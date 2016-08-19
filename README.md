Alinex Handlebars: Readme
=================================================

[![GitHub watchers](
  https://img.shields.io/github/watchers/alinex/node-handlebars.svg?style=social&label=Watch&maxAge=2592000)](
  https://github.com/alinex/node-handlebars/subscription)<!-- {.hidden-small} -->
[![GitHub stars](
  https://img.shields.io/github/stars/alinex/node-handlebars.svg?style=social&label=Star&maxAge=2592000)](
  https://github.com/alinex/node-handlebars)
[![GitHub forks](
  https://img.shields.io/github/forks/alinex/node-handlebars.svg?style=social&label=Fork&maxAge=2592000)](
  https://github.com/alinex/node-handlebars)<!-- {.hidden-small} -->
<!-- {p:.right} -->

[![npm package](
  https://img.shields.io/npm/v/alinex-handlebars.svg?maxAge=2592000&label=latest%20version)](
  https://www.npmjs.com/package/alinex-handlebars)
[![latest version](
  https://img.shields.io/npm/l/alinex-handlebars.svg?maxAge=2592000)](
  #license)<!-- {.hidden-small} -->
[![Travis status](
  https://img.shields.io/travis/alinex/node-handlebars.svg?maxAge=2592000&label=develop)](
  https://travis-ci.org/alinex/node-handlebars)
[![Coveralls status](
  https://img.shields.io/coveralls/alinex/node-handlebars.svg?maxAge=2592000)](
  https://coveralls.io/r/alinex/node-handlebars?branch=master)
[![Gemnasium status](
  https://img.shields.io/gemnasium/alinex/node-handlebars.svg?maxAge=2592000)](
  https://gemnasium.com/alinex/node-handlebars)
[![GitHub issues](
  https://img.shields.io/github/issues/alinex/node-handlebars.svg?maxAge=2592000)](
  https://github.com/alinex/node-handlebars/issues)<!-- {.hidden-small} -->


This is a collection of helper methods extending the [handlebars](http://handlebarsjs.com/)
template system.

- powerful helper
- easy to use
- easy to integrate

> It is one of the modules of the [Alinex Namespace](https://alinex.github.io/code.html)
> following the code standards defined in the [General Docs](https://alinex.github.io/develop).

__Read the complete documentation under
[https://alinex.github.io/node-handlebars](https://alinex.github.io/node-handlebars).__
<!-- {p: .hidden} -->


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
