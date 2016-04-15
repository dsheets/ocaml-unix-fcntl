ocaml-unix-fcntl
================

[ocaml-unix-fcntl](https://github.com/dsheets/ocaml-unix-fcntl) provides
access to the features exposed in [`fcntl.h`][fcntl.h] in a way that is not
tied to the implementation on the host system.

The [`Fcntl`][fcntl] module provides functions for translating between the
names of the flags exposed in `fcntl.h` and their values on particular
systems.  The [`Fcntl_host`][fcntl_host] module exports representations of
various hosts.

The [`Fcntl_unix`][fcntl_unix] provides bindings to functions that use the
flags in `Fcntl` along with a representation of the host system.  The bindings
support a more comprehensive range of flags than the corresponding functions
in the standard OCaml `Unix` module.  The [`Fcntl_unix_lwt`][fcntl_unix_lwt]
module exports non-blocking versions of the functions in `Fcntl_unix` based on
the [`Lwt`][lwt] cooperative threading library.

[fcntl.h]: http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/fcntl.h.html
[fcntl]: https://github.com/dsheets/ocaml-unix-fcntl/blob/master/lib/fcntl.mli
[fcntl_host]: https://github.com/dsheets/ocaml-unix-fcntl/blob/master/lib/fcntl_host.mli
[fcntl_unix]: https://github.com/dsheets/ocaml-unix-fcntl/blob/master/unix/fcntl_unix.mli
[fcntl_unix_lwt]: https://github.com/dsheets/ocaml-unix-fcntl/blob/master/lwt/fcntl_unix_lwt.mli
[lwt]: http://ocsigen.org/lwt/
