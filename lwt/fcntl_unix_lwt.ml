(*
 * Copyright (c) 2016 Jeremy Yallop <yallop@docker.com>
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

external make_open_job :
  name:string -> flags:int -> perms:int option -> (Unix.file_descr * int) Lwt_unix.job =
  "unix_fcntl_lwt_open_job"

let raise_errno_error ~call ~label errno =
  let error_list = Errno.of_code ~host:Errno_unix.host errno in
  Lwt.fail Errno.(Error { errno = error_list; call; label })

let open_ : string -> ?perms:int -> Fcntl.Oflags.t list -> Unix.file_descr Lwt.t
  = fun name ?perms flags ->
    let open Lwt in
    let flags = Fcntl.Oflags.to_code ~host:Fcntl_unix.host.Fcntl.Host.oflags flags in
    Lwt_unix.run_job (make_open_job ~name ~flags ~perms) >>= fun (fd, errno) ->
    if Unix_representations.int_of_file_descr fd < 0
    then raise_errno_error ~call:"open" ~label:name errno
    else return fd
