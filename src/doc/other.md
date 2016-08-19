Other helpers
=================================================

### include

This is used to include another file as it is.

> It is not interpreted as handlebars template itself but output as is.

__Parameter:__

- `String` file path to include

``` handlebars
{{include "myfile.txt" }}
```

This will search for the file from the current directory. So best to use absolute
paths here.
