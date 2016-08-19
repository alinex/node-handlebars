Collection helpers
=================================================

### interate (block)

In contrast to the {@link index.md#each-block core each block} this can also iterate
over object key/value pairs and makes the index in arrays accessible.

__Parameter:__

- `Array|Object` to iterate over

Iterate over an array:

``` handlebars
# list = ['a', 'b', 'c']
{{#iterate list}}
  {{index}}: {{value}}
{{/iterate}}
# 0: a
# 1: b
# 2: c
```

Iterate over an object:

``` handlebars
# list = {a: 1, b: 2, c: 3}
{{#iterate list}}
  {{key}}: {{value}}
{{/iterate}}
# a: 1
# b: 2
# c: 3
```

### join

Join the collection's elements together into a single text element.

__Parameter:__

- `Array` to be joined
- `String` separator to be used to join elements

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

Count the number of elements in that collection.

__Parameter:__

- `Array|Object` to be counted

``` handlebars
# list = [1, 2, 3]
{{count list}}
# 3

# list = {a: 1, b: 2, c: 3}
{{count list}}
# 3
```
