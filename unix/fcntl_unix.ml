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

module Type = Unix_fcntl_types.C(Unix_fcntl_types_detected)
module C = Unix_fcntl_bindings.C(Unix_fcntl_generated)

module Oflags = struct
  open Fcntl

  let to_unix_exn = Oflags.(function
    | O_RDONLY    -> Unix.O_RDONLY
    | O_WRONLY    -> Unix.O_WRONLY
    | O_RDWR      -> Unix.O_RDWR
    | O_CREAT     -> Unix.O_CREAT
    | O_EXCL      -> Unix.O_EXCL
    | O_NOCTTY    -> Unix.O_NOCTTY
    | O_TRUNC     -> Unix.O_TRUNC
    | O_APPEND    -> Unix.O_APPEND
    | O_NONBLOCK  -> Unix.O_NONBLOCK
    | O_SYNC      -> Unix.O_SYNC
    | O_DSYNC     -> Unix.O_DSYNC
    | O_RSYNC     -> Unix.O_RSYNC
    | O_CLOEXEC   -> Unix.O_CLOEXEC
    | O_DIRECTORY
    | O_NOFOLLOW
    | O_DIRECT
    | O_NOATIME
    | O_PATH
    | O_TTY_INIT
    | O_EXEC
    | O_SEARCH
    | O_TMPFILE
    | O_SHLOCK
    | O_EXLOCK
    | O_EVTONLY
    | O_SYMLINK
    | O_ASYNC     -> raise Not_found
  )

  let to_unix t =
    try Some (to_unix_exn t)
    with Not_found -> None

  let of_unix_exn = Oflags.(function
    | Unix.O_RDONLY   -> O_RDONLY
    | Unix.O_WRONLY   -> O_WRONLY
    | Unix.O_RDWR     -> O_RDWR
    | Unix.O_NONBLOCK -> O_NONBLOCK
    | Unix.O_APPEND   -> O_APPEND
    | Unix.O_CREAT    -> O_CREAT
    | Unix.O_TRUNC    -> O_TRUNC
    | Unix.O_EXCL     -> O_EXCL
    | Unix.O_NOCTTY   -> O_NOCTTY
    | Unix.O_DSYNC    -> O_DSYNC
    | Unix.O_SYNC     -> O_SYNC
    | Unix.O_RSYNC    -> O_RSYNC
    | Unix.O_CLOEXEC  -> O_CLOEXEC
    | Unix.O_KEEPEXEC
    | Unix.O_SHARE_DELETE -> raise Not_found
  )

  let of_unix t =
    try Some (of_unix_exn t)
    with Not_found -> None

  let host =
    let option f = match f () with -1 -> None | x -> Some x in
    let defns = Oflags.(Type.({
      o_accmode   = o_accmode;
      o_rdonly    = Some o_rdonly;
      o_wronly    = Some o_wronly;
      o_rdwr      = Some o_rdwr;
      o_creat     = Some o_creat;
      o_excl      = Some o_excl;
      o_noctty    = Some o_noctty;
      o_trunc     = Some o_trunc;
      o_append    = Some o_append;
      o_nonblock  = Some o_nonblock;
      o_sync      = Some o_sync;
      o_async     = Some o_async;
      o_dsync     = option C.o_dsync;
      o_rsync     = option C.o_rsync;
      o_directory = Some o_directory;
      o_nofollow  = Some o_nofollow;
      o_cloexec   = Some o_cloexec;
      o_direct    = option C.o_direct;
      o_noatime   = option C.o_noatime;
      o_path      = option C.o_path;
      o_tmpfile   = option C.o_tmpfile;
      o_shlock    = option C.o_shlock;
      o_exlock    = option C.o_exlock;
      o_evtonly   = option C.o_evtonly;
      o_symlink   = option C.o_symlink;
      o_exec      = option C.o_exec;
      o_search    = option C.o_search;
      o_tty_init  = option C.o_tty_init;
    })) in
    Oflags.Host.of_defns defns

end

let host = {
  Fcntl.Host.oflags = Oflags.host;
}

let open_ path ?perms oflags =
  let oflags = Fcntl.(Oflags.to_code_exn ~host:host.Host.oflags oflags) in
  Errno_unix.raise_on_errno ~call:"open" ~label:path (fun () ->
    let fd = match perms with
      | None       -> C.open_ (Some path) oflags
      | Some perms -> C.open_perms (Some path) oflags perms
    in
    if fd < 0
    then None
    else Some (Unix_representations.file_descr_of_int fd)
  )
