(*
 * Copyright (c) 2015 David Sheets <sheets@alum.mit.edu>
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

open Ctypes

module C(F: Cstubs.FOREIGN) = struct

  (* OS X doesn't have these *)
  let o_direct   = F.(foreign "unix_fcntl_o_direct"   (void @-> returning int))

  (* OS X and FreeBSD don't have these *)
  let o_rsync    = F.(foreign "unix_fcntl_o_rsync"    (void @-> returning int))
  let o_noatime  = F.(foreign "unix_fcntl_o_noatime"  (void @-> returning int))
  let o_path     = F.(foreign "unix_fcntl_o_path"     (void @-> returning int))
  let o_tmpfile  = F.(foreign "unix_fcntl_o_tmpfile"  (void @-> returning int))

  (* FreeBSD doesn't have these *)
  let o_dsync    = F.(foreign "unix_fcntl_o_dsync"    (void @-> returning int))

  (* Linux doesn't have these *)
  let o_exlock   = F.(foreign "unix_fcntl_o_exlock"   (void @-> returning int))
  let o_shlock   = F.(foreign "unix_fcntl_o_shlock"   (void @-> returning int))

  (* OS X only *)
  let o_symlink  = F.(foreign "unix_fcntl_o_symlink"  (void @-> returning int))
  let o_evtonly  = F.(foreign "unix_fcntl_o_evtonly"  (void @-> returning int))

  (* Linux and OS X don't have these *)
  let o_exec     = F.(foreign "unix_fcntl_o_exec"     (void @-> returning int))
  let o_tty_init = F.(foreign "unix_fcntl_o_tty_init" (void @-> returning int))

  (* Linux, OS X, and FreeBSD don't have these *)
  let o_search   = F.(foreign "unix_fcntl_o_search"   (void @-> returning int))

  let open_perms =
    F.(foreign "open" (string_opt @-> int @-> int @-> returning int))
  let open_      = F.(foreign "open" (string_opt @-> int @-> returning int))

end
