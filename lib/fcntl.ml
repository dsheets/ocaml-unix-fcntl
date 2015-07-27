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

module Oflags = struct
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
  | O_SHLOCK
  | O_EXLOCK
  | O_EVTONLY
  | O_SYMLINK

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
    o_shlock    : int option;
    o_exlock    : int option;
    o_evtonly   : int option;
    o_symlink   : int option;
  }

  type host = defns

  let host_of_defns defns = defns
  let defns_of_host host = host

  let _to_code ~host = let defns = host in function
    | O_RDONLY    -> defns.o_rdonly
    | O_WRONLY    -> defns.o_wronly
    | O_RDWR      -> defns.o_rdwr
    | O_CREAT     -> defns.o_creat
    | O_EXCL      -> defns.o_excl
    | O_NOCTTY    -> defns.o_noctty
    | O_TRUNC     -> defns.o_trunc
    | O_APPEND    -> defns.o_append
    | O_NONBLOCK  -> defns.o_nonblock
    | O_SYNC      -> defns.o_sync
    | O_ASYNC     -> defns.o_async
    | O_DSYNC     -> defns.o_dsync
    | O_RSYNC     -> defns.o_rsync
    | O_DIRECTORY -> defns.o_directory
    | O_NOFOLLOW  -> defns.o_nofollow
    | O_CLOEXEC   -> defns.o_cloexec
    | O_DIRECT    -> defns.o_direct
    | O_NOATIME   -> defns.o_noatime
    | O_PATH      -> defns.o_path
    | O_TTY_INIT  -> defns.o_tty_init
    | O_EXEC      -> defns.o_exec
    | O_SEARCH    -> defns.o_search
    | O_TMPFILE   -> defns.o_tmpfile
    | O_SHLOCK    -> defns.o_shlock
    | O_EXLOCK    -> defns.o_exlock
    | O_EVTONLY   -> defns.o_evtonly
    | O_SYMLINK   -> defns.o_symlink

  let is_set ~host t =
    let exist, bit = match _to_code ~host t with
      | Some bit -> true, bit | None -> false, 0
    in fun code -> exist && match t with
    | O_RDONLY | O_TTY_INIT -> code = bit
    | _ -> (bit land code) = bit
  let set ~host t =
    let bit = match _to_code ~host t with
      | Some bit -> bit | None -> raise Not_found
    in fun code -> bit lor code

  (* This can't roundtrip [] because O_RDONLY is 0 *)
  let to_code ~host = List.fold_left (fun code t -> set ~host t code) 0

  let of_code ~host code = List.filter
      (fun t -> is_set ~host t code)
      [
        O_CLOEXEC;
        O_CREAT;
        O_DIRECTORY;
        O_EXCL;
        O_NOCTTY;
        O_NOFOLLOW;
        O_TRUNC;
        O_TTY_INIT;
        O_APPEND;
        O_DSYNC;
        O_NONBLOCK;
        O_RSYNC;
        O_SYNC;
        O_EXEC;
        O_RDONLY;
        O_RDWR;
        O_SEARCH;
        O_WRONLY;
        O_ASYNC;
        O_DIRECT;
        O_NOATIME;
        O_PATH;
        O_TMPFILE;
    ]

end

type host = {
  oflags : Oflags.host;
}
