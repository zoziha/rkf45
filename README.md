# RKF45

`rkf45` is based on Fehlberg fourth-fifth order Runge-Kutta method.

|Term|Info|
|:-:|:-:|
|Version:|0.0.1|
|Author:|h.a.watts, l.f.shampine|
|Website:|http://www.netlib.org/ode/rkf45.f|
|License:|Public Domain|

## Get start

### Dependencies

- Git
- [fortran-lang/fpm](https://github.com/fortran-lang/fpm)

### Get the code

```sh
https://github.com/zoziha/rkf45.git
cd rkf45
```

### Build with [fortran-lang/fpm](https://github.com/fortran-lang/fpm)

Fortran Package Manager (fpm) is a package manager and build system for Fortran.<br>
You can build `rkf45` using provided `fpm.toml`:

```sh
fpm build --profile release
```

To sue `rkf45` within your `fpm` project, add the following to your `fpm.toml` file:

```toml
[dependencies]
rkf45 = { git=https://github.com/zoziha/rkf45.git }
```

## Links

- [netlib/rkf45](http://www.netlib.org/ode/rkf45.f)
- [John Burkardt/rkf45(Fixed Format)](https://people.math.sc.edu/Burkardt/f77_src/rkf45/rkf45.html)
- [John Burkardt/rkf45(Free Format)](https://people.math.sc.edu/Burkardt/f_src/rkf45/rkf45.html)