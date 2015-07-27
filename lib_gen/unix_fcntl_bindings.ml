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

(* blech Obj.magic! *)
let fd_of_int (x: int) : Unix.file_descr = Obj.magic x
let int_of_fd (x: Unix.file_descr) : int = Obj.magic x
let fd = view ~read:fd_of_int ~write:int_of_fd int

module C(F: Cstubs.FOREIGN) = struct

  (* Linux doesn't have these *)
  let o_symlink  = F.foreign "unix_fcntl_o_symlink"  (void @-> returning int)
  let o_evtonly  = F.foreign "unix_fcntl_o_evtonly"  (void @-> returning int)
  let o_exlock   = F.foreign "unix_fcntl_o_exlock"   (void @-> returning int)
  let o_shlock   = F.foreign "unix_fcntl_o_shlock"   (void @-> returning int)

  (* Linux and OS X don't have these *)
  let o_search   = F.foreign "unix_fcntl_o_search"   (void @-> returning int)
  let o_exec     = F.foreign "unix_fcntl_o_exec"     (void @-> returning int)
  let o_tty_init = F.foreign "unix_fcntl_o_tty_init" (void @-> returning int)

  let open_perms = F.foreign "open" (string_opt @-> int @-> int @-> returning fd)
  let open_      = F.foreign "open" (string_opt @-> int @-> returning fd)

end
