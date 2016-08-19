Comparison Helper
=================================================

### is (block)

A block in this condition will only be rendered if the condition is true. This
may act like {@link index.md#if-block if} or be used instead of the
{@link index.md#unless-block unless}.

__Parameter:__

- element to be checked

Given one argument, `is` acts exactly like {@link index.md#if-block if}:

``` handlebars
{{#is x}} ... {{else}} ... {{/is}}
```

__Parameter:__

- element to be checked
- value to check against

Given two arguments, `is` compares the two are equal:

``` handlebars
{{#is x y}} ... {{else}} ... {{/is}}
```

__Parameter:__

- element to be checked
- `String` operator to use (see possibilities below)
- value to check against

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
