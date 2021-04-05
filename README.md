# Alec Jacobson’s impbcopy and impbpaste
**(ported to Swift 5)**

This repository contains copies of Alec Jacobson’s impbcopy and impbpaste
programs for copying and pasting images from the command line on macOS.  You
can read more about them in [his original blog post][1].

*The Objective-C source files can be found under the `OldSources/` directory.*

## Installing

Universal Binaries are included in the repo, you can just copy them to a directory like `/usr/local/bin`

```shell
cp bin/impbcopy /usr/local/bin/impbcopy
cp bin/impbpaste /usr/local/bin/impbpaste
```

## Building

```shell
swift build
```

## Related Projects

As Alec mentioned in his original post, you may want to use [pngpaste][2]
instead because it has more features than impbpaste.

[1]: http://www.alecjacobson.com/weblog/?p=3816
[2]: https://github.com/jcsalterego/pngpaste
