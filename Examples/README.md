Example project of what a modular project would look like, except written to
use the parent directory rather than a sub directory as the path to sxecmake.

```
./bootstrap.sh
cmake --build build --package
```

This example defines a library (include, library), a program that uses it
(src), and the necessary cmake and project support around it.

