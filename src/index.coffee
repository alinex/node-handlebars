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
fs = require 'alinex-fs'


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

helper =

  # ### Comparison

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

  # ### String

  lowercase: ->
    {args} = argParse arguments
    args[0].toLowerCase()

  uppercase: ->
    {args} = argParse arguments
    args[0].toUpperCase()

  capitalizeFirst: ->
    {args} = argParse arguments
    args[0].charAt(0).toUpperCase() + args[0].slice(1)

  capitalizeEach: ->
    {args} = argParse arguments
    args[0].replace /\w\S*/g, (txt) -> txt.charAt(0).toUpperCase() + txt.substr(1)

  shorten: ->
    {args} = argParse arguments
    [text, len] = args
    util.string.shorten text, len

  nobr: ->
    {args} = argParse arguments
    [text] = args
    text.replace /[ ]/g, "\u00A0"

  # ### Format

  # format an ISO date using Moment.js - http://momentjs.com/
  #
  #     date = new Date()
  #     {{dateFormat date "MMMM YYYY"}}
  #     # January 2016
  #     {{dateFormat date "LL"}}
  #     # January 18, 2016
  #     {{#dateFormat "LL"}}2016-01-18{{/dateFormat}}
  #     # January 18, 2016
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

  # ### Math helper

  add: ->
    {args, fn, data} = argParse arguments
    if fn
      obj = fn data
      [num] = args
    else
      [obj, num] = args
    # work with numbers
    return Number(obj) + num

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

  subtract: ->
    {args, fn, data} = argParse arguments
    if fn
      obj = fn data
      [num] = args
    else
      [obj, num] = args
    # work with numbers
    return Number(obj) - num

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


  # ### Collection

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

  # ### Other

  include: ->
    {args} = argParse arguments
    [file] = args
    try
      return fs.readFileSync file
    catch error
      return error.message

# Handlebars Helper
# -------------------------------------------------

initMoment = ->
  return if moment
  moment = require 'moment'
  chrono ?= require 'chrono-node'
  moment.createFromInputFallback = (config) ->
    config._d = switch config._i.toLowerCase()
      when 'now' then new Date()
      else chrono.parseDate config._i

# ### Get arguments
# - name - name of the function
# - args - the normal parameters
# - hash - named parameters
# - fn - content function in block helpers
# - inverse - else part of block helpers
# - data - current context
argParse = (args) ->
  args = [].slice.call(args)
  options = args[args.length-1]
  options.args = args[0..-2]
  options.data = options.data.root
  options
