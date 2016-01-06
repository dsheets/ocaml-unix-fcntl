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
  val to_unix_exn : Fcntl.Oflags.t -> Unix.open_flag
  val to_unix : Fcntl.Oflags.t -> Unix.open_flag option

  val of_unix_exn : Unix.open_flag -> Fcntl.Oflags.t
  val of_unix : Unix.open_flag -> Fcntl.Oflags.t option

  val host : Fcntl.Oflags.Host.t
end

val host : Fcntl.Host.t

val open_ : string -> ?perms:int -> Fcntl.Oflags.t list -> Unix.file_descr
