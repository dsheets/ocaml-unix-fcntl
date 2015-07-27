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
  | O_TTY_INIT (* Can be 0 by POSIX *)
  | O_APPEND
  | O_DSYNC
  | O_NONBLOCK
  | O_RSYNC
  | O_SYNC
  | O_EXEC
  | O_RDONLY (* Can be 0 in practice *)
  | O_RDWR
  | O_SEARCH
  | O_WRONLY
  | O_ASYNC (* Linux *)
  | O_DIRECT (* Linux *)
  | O_NOATIME (* Linux *)
  | O_PATH (* Linux *)
  | O_TMPFILE (* Linux *)

  type defns = {
    o_accmode   : int option;
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
  }

  type host

  val host_of_defns : defns -> host
  val defns_of_host : host -> defns

  val to_code : host:host -> t list -> int
  val of_code : host:host -> int -> t list

  val is_set : host:host -> t -> int -> bool
  val set : host:host -> t -> int -> int
end

type host = {
  oflags : Oflags.host;
}
