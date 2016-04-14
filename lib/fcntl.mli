(*
 * Copyright (c) 2014-2015 David Sheets <sheets@alum.mit.edu>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 *)

module Oflags : sig
  type t =
  | O_CLOEXEC
  | O_CREAT
  | O_DIRECTORY
  | O_EXCL
  | O_NOCTTY
  | O_NOFOLLOW
  | O_TRUNC
  | O_TTY_INIT (* POSIX: can be 0; UNAVAILABLE in OS X and Linux *)
  | O_APPEND
  | O_DSYNC
  | O_NONBLOCK
  | O_RSYNC (* NOT OS X *)
  | O_SYNC
  | O_EXEC (* UNAVAILABLE in OS X and Linux *)
  | O_RDONLY (* Can be 0 in practice *)
  | O_RDWR
  | O_SEARCH (* UNAVAILABLE in OS X and Linux *)
  | O_WRONLY
  (* Non-POSIX below *)
  | O_ASYNC
  | O_DIRECT (* ONLY Linux *)
  | O_NOATIME (* ONLY Linux *)
  | O_PATH (* ONLY Linux *)
  | O_TMPFILE (* ONLY Linux *)
  | O_SHLOCK (* NOT Linux *)
  | O_EXLOCK (* NOT Linux *)
  | O_EVTONLY (* ONLY OS X *)
  | O_SYMLINK (* ONLY OS X *)

  type oflag = t

  type defns = {
    o_accmode   : int;
    o_rdonly    : int option;
    o_wronly    : int option;
    o_rdwr      : int option;
    o_creat     : int option;
    o_excl      : int option;
    o_noctty    : int option;
    o_trunc     : int option;
    o_append    : int option;
    o_nonblock  : int option;
    o_sync      : int option;
    o_async     : int option;
    o_dsync     : int option;
    o_rsync     : int option;
    o_directory : int option;
    o_nofollow  : int option;
    o_cloexec   : int option;
    o_direct    : int option;
    o_noatime   : int option;
    o_path      : int option;
    o_tty_init  : int option;
    o_exec      : int option;
    o_search    : int option;
    o_tmpfile   : int option;
    o_shlock    : int option;
    o_exlock    : int option;
    o_evtonly   : int option;
    o_symlink   : int option;
  }

  module Host : sig
    type t

    val of_defns : defns -> t
    val to_defns : t -> defns

    val to_string : t -> string
    val of_string : string -> t

    val iter : t
      -> (int -> unit) -> (int -> oflag -> unit) -> (oflag -> unit) -> unit
  end

  val to_code : host:Host.t -> t list -> int option
  val to_code_exn : host:Host.t -> t list -> int
  val of_code : host:Host.t -> int -> t list

  val is_set : host:Host.t -> t -> int -> bool
  val set : host:Host.t -> t -> int -> int option
  val set_exn : host:Host.t -> t -> int -> int

  val to_string : t -> string

  val of_string : string -> t option
end

module Host : sig
  type t = {
    oflags : Oflags.Host.t;
  }

  val to_string : t -> string

  val of_string : string -> t

  val iter : t
    -> oflags:((int -> unit) * (int -> Oflags.t -> unit) * (Oflags.t -> unit))
    -> unit
end
