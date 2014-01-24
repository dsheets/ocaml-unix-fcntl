(*
 * Copyright (c) 2014 David Sheets <sheets@alum.mit.edu>
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
  | O_ACCMODE
  | O_RDONLY
  | O_WRONLY
  | O_RDWR
  | O_CREAT
  | O_EXCL
  | O_NOCTTY
  | O_TRUNC
  | O_APPEND
  | O_NONBLOCK
  | O_SYNC
  | O_ASYNC
  | O_DSYNC
  | O_RSYNC
  | O_LARGEFILE
  | O_DIRECTORY
  | O_NOFOLLOW
  | O_CLOEXEC
  | O_DIRECT
  | O_NOATIME
  | O_PATH

  external o_accmode   : unit -> int32 = "unix_fcntl_o_accmode"
  external o_rdonly    : unit -> int32 = "unix_fcntl_o_rdonly"
  external o_wronly    : unit -> int32 = "unix_fcntl_o_wronly"
  external o_rdwr      : unit -> int32 = "unix_fcntl_o_rdwr"
  external o_creat     : unit -> int32 = "unix_fcntl_o_creat"
  external o_excl      : unit -> int32 = "unix_fcntl_o_excl"
  external o_noctty    : unit -> int32 = "unix_fcntl_o_noctty"
  external o_trunc     : unit -> int32 = "unix_fcntl_o_trunc"
  external o_append    : unit -> int32 = "unix_fcntl_o_append"
  external o_nonblock  : unit -> int32 = "unix_fcntl_o_nonblock"
  external o_sync      : unit -> int32 = "unix_fcntl_o_sync"
  external o_async     : unit -> int32 = "unix_fcntl_o_async"
  external o_dsync     : unit -> int32 = "unix_fcntl_o_dsync"
  external o_rsync     : unit -> int32 = "unix_fcntl_o_rsync"
  external o_largefile : unit -> int32 = "unix_fcntl_o_largefile"
  external o_directory : unit -> int32 = "unix_fcntl_o_directory"
  external o_nofollow  : unit -> int32 = "unix_fcntl_o_nofollow"
  external o_cloexec   : unit -> int32 = "unix_fcntl_o_cloexec"
  external o_direct    : unit -> int32 = "unix_fcntl_o_direct"
  external o_noatime   : unit -> int32 = "unix_fcntl_o_noatime"
  external o_path      : unit -> int32 = "unix_fcntl_o_path"

  type defns = {
    o_accmode   : int32 option;
    o_rdonly    : int32 option;
    o_wronly    : int32 option;
    o_rdwr      : int32 option;
    o_creat     : int32 option;
    o_excl      : int32 option;
    o_noctty    : int32 option;
    o_trunc     : int32 option;
    o_append    : int32 option;
    o_nonblock  : int32 option;
    o_sync      : int32 option;
    o_async     : int32 option;
    o_dsync     : int32 option;
    o_rsync     : int32 option;
    o_largefile : int32 option;
    o_directory : int32 option;
    o_nofollow  : int32 option;
    o_cloexec   : int32 option;
    o_direct    : int32 option;
    o_noatime   : int32 option;
    o_path      : int32 option;
  }

  type host = defns

  let to_open_flag_exn = function
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
    | O_LARGEFILE
    | O_ASYNC
    | O_ACCMODE   -> raise Not_found

  let to_open_flag t =
    try Some (to_open_flag_exn t)
    with Not_found -> None

  let of_open_flag = function
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
    | Unix.O_SHARE_DELETE -> raise Not_found

  let _to_code ~host = let defns = host in Unix.(function
    | O_ACCMODE   -> defns.o_accmode
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
    | O_LARGEFILE -> defns.o_largefile
    | O_DIRECTORY -> defns.o_directory
    | O_NOFOLLOW  -> defns.o_nofollow
    | O_CLOEXEC   -> defns.o_cloexec
    | O_DIRECT    -> defns.o_direct
    | O_NOATIME   -> defns.o_noatime
    | O_PATH      -> defns.o_path
  )

  let is_set ~host t =
    let exist, bit = match _to_code ~host t with
      | Some bit -> true, bit | None -> false, 0l
    in fun code -> exist && (Int32.(logand bit code) = bit)
  let set ~host t =
    let bit = match _to_code ~host t with
      | Some bit -> bit | None -> raise Not_found
    in fun code -> Int32.(logor bit code)

  let to_code ~host = List.fold_left (fun code t -> set ~host t code) 0l

  let host =
    let option f = match f () with -1l -> None | x -> Some x in
    let defns = {
      o_accmode   = option o_accmode;
      o_rdonly    = option o_rdonly;
      o_wronly    = option o_wronly;
      o_rdwr      = option o_rdwr;
      o_creat     = option o_creat;
      o_excl      = option o_excl;
      o_noctty    = option o_noctty;
      o_trunc     = option o_trunc;
      o_append    = option o_append;
      o_nonblock  = option o_nonblock;
      o_sync      = option o_sync;
      o_async     = option o_async;
      o_dsync     = option o_dsync;
      o_rsync     = option o_rsync;
      o_largefile = option o_largefile;
      o_directory = option o_directory;
      o_nofollow  = option o_nofollow;
      o_cloexec   = option o_cloexec;
      o_direct    = option o_direct;
      o_noatime   = option o_noatime;
      o_path      = option o_path;
    } in
    defns

  let of_code ~host code = List.filter
    (fun t -> is_set ~host t code)
    [
      O_ACCMODE;
      O_RDONLY;
      O_WRONLY;
      O_RDWR;
      O_CREAT;
      O_EXCL;
      O_NOCTTY;
      O_TRUNC;
      O_APPEND;
      O_NONBLOCK;
      O_SYNC;
      O_ASYNC;
      O_DSYNC;
      O_RSYNC;
      O_LARGEFILE;
      O_DIRECTORY;
      O_NOFOLLOW;
      O_CLOEXEC;
      O_DIRECT;
      O_NOATIME;
      O_PATH;
    ]
end
