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
  include Unix_fcntl_common.Oflags

  let view ~host = Ctypes.(
    view ~read:(of_code ~host) ~write:(to_code ~host) int32_t
  )
end

type host = {
  oflags : Oflags.host;
}

let host = {
  oflags = Oflags.host;
}

open Ctypes
open Foreign
open Unsigned

let local ?check_errno addr typ =
  coerce (ptr void) (funptr ?check_errno typ) (ptr_of_raw_address addr)

let fd = Fd_send_recv.(view ~read:fd_of_int ~write:int_of_fd int)

external unix_fcntl_open_perms_ptr : unit -> int64 = "unix_fcntl_open_perms_ptr"
external unix_fcntl_open_none_ptr : unit -> int64 = "unix_fcntl_open_none_ptr"

let open_ =
  let perms = Unix_sys_stat.File_perm.(view ~host) in
  let oflags = Oflags.view ~host:host.oflags in
  let c_perms = local ~check_errno:true (unix_fcntl_open_perms_ptr ())
    PosixTypes.(string @-> oflags @-> perms @-> returning fd)
  in
  let c_none = local ~check_errno:true (unix_fcntl_open_none_ptr ())
    PosixTypes.(string @-> oflags @-> returning fd)
  in
  fun path ?perms oflags ->
    try begin match perms with
    | None      -> c_none path oflags
    | Some perms -> c_perms path oflags perms
    end
    with Unix.Unix_error(e,_,_) -> raise (Unix.Unix_error (e,"open",""))
