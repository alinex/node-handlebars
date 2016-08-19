String helpers
=================================================

### lowercase

Turns a string to lowercase.

__Parameter:__

- `String` text to modify

``` handlebars
{{lowercase "THIS SHOULD BE LOWERCASE"}}
```

__Result:__

    this should be lowercase

### uppercase

Turns a string to uppercase.

__Parameter:__

- `String` text to modify

``` handlebars
{{uppercase "this should be lowercase"}}
```

__Result:__

    THIS SHOULD BE LOWERCASE

### capitalizeFirst

Capitalizes the first word in a string.

__Parameter:__

- `String` text to modify

``` handlebars
{{lowercase "this should be lowercase"}}
```

__Result:__

    This should be lowercase

### capitalizeEach

Capitalizes each word in a string.

__Parameter:__

- `String` text to modify

``` handlebars
{{lowercase "this should be lowercase"}}
```

__Result:__

    This Should Be Lowercase

### shorten

This will shorten the given text and add ellipsis if it is too long. This is done
word aware.

__Parameter:__

- `String` text to modify
- `Integer` max number oof characters

``` handlebars
{{truncate "this should be lowercase" 18}}
```

__Result:__

    # this should be...

### nobr

Transforms all spaces in non breaking spaces (UTF-8) for display. This helps in
displaying table data in narrow html view.

__Parameter:__

- `String` text to modify

``` handlebars
{{nobr "15 886"}}
```
