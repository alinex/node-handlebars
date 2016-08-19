###
API Usage
=================================================
###


# Node modules
# -------------------------------------------------
moment = null # load on demand
chrono = null # load on demand
numeral = null # load on demand
math = null # load on demand
i18n = null # load on demand
# alinex modules
util = require 'alinex-util'
fs = require 'fs'


# External Methods
# -------------------------------------------------

###
This method will add all the handlebars helper methods to the given handlebars
instance.

@param {Handlebars} handlebars instance
###
exports.register = (handlebars) ->
  # register helper
  for key, fn of helper
    handlebars.registerHelper key, fn


# Handlebars Helper
# -------------------------------------------------

helper =

  # @param {Array} args the normal handlebars parameters
  # - left operand and right operand
  # - left operand, `String` operator, right operand
  # @param {Function} fn the body function
  # @param {Function} inverse the body function from the `else` part
  is: ->
    {args, fn, inverse} = argParse arguments
    if args.length is 2
      [left, right] = args
      operator = '=='
    else
      [left, operator, right] = args
    # use count of entries for array
    if typeof left is 'object'
      left = Object.keys(left).length
    # call comparison
    result = switch operator
      when '>' then left > right
      when '<' then left < right
      when '>=' then left >= right
      when '<=' then left <= right
      when '==' then left is right
      when 'not', '!=' then left isnt right
      when 'in'
        right = right.split /\s*,\s*/ unless Array.isArray right
        ~right.indexOf left
      when '!in'
        right = right.split /\s*,\s*/ unless Array.isArray right
        not ~right.indexOf left
      else left
    # execute content or else part
    if result then fn this else inverse this

  # String methods
  # -------------------------------------------------------

  # @param {Array} args the normal handlebars parameters
  # - `String` text to be formatted
  lowercase: ->
    {args} = argParse arguments
    args[0].toLowerCase()

  # @param {Array} args the normal handlebars parameters
  # - `String` text to be formatted
  uppercase: ->
    {args} = argParse arguments
    args[0].toUpperCase()

  # @param {Array} args the normal handlebars parameters
  # - `String` text to be formatted
  capitalizeFirst: ->
    {args} = argParse arguments
    args[0].charAt(0).toUpperCase() + args[0].slice(1)

  # @param {Array} args the normal handlebars parameters
  # - `String` text to be formatted
  capitalizeEach: ->
    {args} = argParse arguments
    args[0].replace /\w\S*/g, (txt) -> txt.charAt(0).toUpperCase() + txt.substr(1)

  # @param {Array} args the normal handlebars parameters
  # - `String` text to be formatted
  # - `Number` maximum length to use
  shorten: ->
    {args} = argParse arguments
    [text, len] = args
    util.string.shorten text, len

  # @param {Array} args the normal handlebars parameters
  # - `String` text to be formatted
  nobr: ->
    {args} = argParse arguments
    [text] = args
    text.replace /[ ]/g, "\u00A0"


  # Format methods
  # --------------------------------------------------------

  # @param {Array} args the normal handlebars parameters
  # - `Number` to format (alternatively given as content of block)
  # - `String` format for output
  # - `String` locale to use
  # @param {Function} fn the body function
  # @param {Object} data current context
  format: ->
    {args, fn, data} = argParse arguments
    if fn
      obj = fn data
      [format, locale] = args
    else
      [obj, format, locale] = args
    # format numbers
    if format
      numeral ?= require 'numeral'
      if locale
        try
          numeral.language locale, require "numeral/languages/#{locale}"
          numeral.language locale
      obj = numeral(obj).format format
      numeral.language 'en' if locale
    obj

  # @param {Array} args the normal handlebars parameters
  # - `Date` to format (alternatively given as content of block)
  # - `String` format for output
  # - `String` locale to use
  # @param {Function} fn the body function
  # @param {Object} data current context
  date: ->
    {args, fn, data} = argParse arguments
    if fn
      obj = fn data
      [format, locale] = args
    else
      [obj, format, locale] = args
    # format date
    initMoment()
    m = moment obj
    if m.isValid
      m.locale locale if locale
      return m.format format ? 'YYYY-MM-DD'
    obj

  # @param {Array} args the normal handlebars parameters
  # - `Number` the inline number to convert (alternatively given as content of block)
  # - `String` unit from of the base value
  # - `String` unit format to convert into
  # - `String` locale to use
  # @param {Function} fn the body function
  # @param {Object} data current context
  unit: ->
    {args, fn, data} = argParse arguments
    if fn
      num = fn data
      [from, to, format, locale] = args
    else
      [num, from, to, format, locale] = args
    format ?= '0.00'
    # change unit
    try
      math ?= require 'mathjs'
      num = "#{num}#{from}" if from
      value = math.unit num
      value = value.to to if to
      value = value.format()
    catch error
      return error
    # format value
    numeral ?= require 'numeral'
    if locale
      try
        numeral.language locale, require "numeral/languages/#{locale}"
        numeral.language locale
    [v, p] = value.split /[ ]/
    value = numeral(v).format(format) + ' ' + p
    numeral.language 'en' if locale
    value

  # @param {Array} args the normal handlebars parameters
  # - `0` - `String` text to translate
  # - `1` - `String` context for text retrieval
  # - `2` - `String` locale to use
  i18n: ->
    {args} = argParse arguments
    [text, context, locale] = args
    # format
    i18n ?= require 'i18n'
    if locale
      return i18n.__
        phrase: text
        locale: locale
      , context
    i18n.__ text, context


  # Math methods
  # ----------------------------------------------------

  # @param {Array} args the normal handlebars parameters
  # - `Number` with the number to add
  # - `Number`, `Number` same with an inline base number
  # @param {Function} fn the body function
  # @param {Object} data current context
  add: ->
    {args, fn, data} = argParse arguments
    if fn
      obj = fn data
      [num] = args
    else
      [obj, num] = args
    # work with numbers
    return Number(obj) + num

  # @param {Array} args the normal handlebars parameters
  # - `Number`, 'String' with the number to add and its unit
  # - `Date`, `Number`, 'String' same with an inline date object
  # @param {Function} fn the body function
  # @param {Object} data current context
  addDate: ->
    {args, fn, data} = argParse arguments
    if fn
      obj = fn data
      [num, unit] = args
    else
      [obj, num, unit] = args
    # format date
    initMoment()
    m = moment obj
    if m.isValid()
      return m.add num, unit
      .toDate()
    # fallback
    obj

  # @param {Array} args the normal handlebars parameters
  # - `Number` with the number to subtract
  # - `Number`, `Number` same with an inline base number
  # @param {Function} fn the body function
  # @param {Object} data current context
  subtract: ->
    {args, fn, data} = argParse arguments
    if fn
      obj = fn data
      [num] = args
    else
      [obj, num] = args
    # work with numbers
    return Number(obj) - num

  # @param {Array} args the normal handlebars parameters
  # - `Number`, 'String' with the number to subtract and its unit
  # - `Date`, `Number`, 'String' same with an inline date object
  # @param {Function} fn the body function
  # @param {Object} data current context
  subtractDate: ->
    {args, fn, data} = argParse arguments
    if fn
      obj = fn data
      [num, unit] = args
    else
      [obj, num, unit] = args
    # format date
    initMoment()
    m = moment obj
    if m.isValid()
      return m.subtract num, unit
      .toDate()
    # fallback
    obj


  # Collections
  # --------------------------------------------------

  # Include other files.
  #
  # @param {Array} args the normal handlebars parameters
  # - `0` - should contain the file to include
  iterate: ->
    {args, fn, data} = argParse arguments
    [obj] = args
    result = ''
    # array
    if Array.isArray obj
      for v, i in obj
        result += fn util.extend util.clone(data),
          value: v
          index: i
    # object
    else
      for k, v of obj
        result += fn util.extend util.clone(data),
          key: k
          value: v
    # return result
    result

  # Include other files.
  #
  # @param {Array} args the normal handlebars parameters
  # - `0` - should contain the file to include
  join: ->
    {args} = argParse arguments
    [obj, separator] = args
    separator ?= ' '
    # array
    if Array.isArray obj
      return obj.join separator
    # object
    if typeof obj is 'object'
      return Object.keys(obj).join separator
    obj

  # Count number of elements in collection.
  #
  # @param {Array} args the normal handlebars parameters
  # - `0` - should contain the object to be counted
  count: ->
    {args} = argParse arguments
    [obj] = args
    # array
    if obj?.length?
      return obj.length
    # object
    if typeof obj is 'object'
      return Object.keys(obj).length
    obj


  # Other methods
  # --------------------------------------------------

  # Include other files.
  #
  # @param {Array} args the normal handlebars parameters
  # - `0` - should contain the file to include
  include: ->
    {args} = argParse arguments
    [file] = args
    try
      return fs.readFileSync file
    catch error
      return error.message


# Helper Methods
# ---------------------------------------------------

# This will load {@link moment} and {@link chrono} on demand and also add
# chrono as fallback input parser in the `moment` library.
initMoment = ->
  # stop if already loaded
  return if moment
  moment = require 'moment'
  chrono ?= require 'chrono-node'
  moment.createFromInputFallback = (config) ->
    config._d = switch config._i.toLowerCase()
      when 'now' then new Date()
      else chrono.parseDate config._i

# Get the function arguments as parameter object.
#
# @param {Array} arguments to be parsed
# @return {Object} with named entries
# - `name` - {String} name of the function
# - `args` - {Array} the normal handlebars parameters
# - `hash` - {Object} named handlebars parameters
# - `fn` - {Function} content function in block helpers
# - `inverse` - {Function} else part of block helpers
# - `data` - {Object} current context
argParse = (args) ->
  args = [].slice.call(args)
  options = args[args.length-1]
  options.args = args[0..-2]
  options.data = options.data.root
  options
