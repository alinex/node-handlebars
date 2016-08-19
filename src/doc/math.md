Math helpers
=================================================

### add (inline/block)

__Parameter:__

- `Number` to be changed (alternatively given as content)
- `Number` value to be added

``` handlebars
{{#add 1}}15{{/add 1}}
# 16
```

### addDate (inline/block)

__Parameter:__

- `Date` to be changed (alternatively given as content)
- `Number` value to be added
- `String` type of interval steps like 'seconds', 'minutes', 'hours', 'days'...

``` handlebars
{{#format "LL"}}{{addDate "1974-01-23" 1 "month"}}{{/format}}
# February 23, 1974

{{#addDate 1}}15{{/addDate 1}}
# 16
```

### subtract (inline/block)

__Parameter:__

- `Number` to be changed (alternatively given as content)
- `Number` value to be added

``` handlebars
{{#subtract 1}}15{{/subtract 1}}
# 14
```
### subtractDate (inline/block)

__Parameter:__

- `Date` to be changed (alternatively given as content)
- `Number` value to be subtracted
- `String` type of interval steps like 'seconds', 'minutes', 'hours', 'days'...

``` handlebars
{{#format "LL"}}{{subtractDate "1974-01-23" 1 "month"}}{{/format}}
# December 23, 1973
```
