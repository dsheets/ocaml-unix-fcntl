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

module C(F: Cstubs.Types.TYPE) = struct

  let o_accmode = F.(constant "O_ACCMODE" int)
  let o_rdonly = F.(constant "O_RDONLY" int)
  let o_wronly = F.(constant "O_WRONLY" int)
  let o_rdwr = F.(constant "O_RDWR" int)
  let o_creat = F.(constant "O_CREAT" int)
  let o_excl = F.(constant "O_EXCL" int)
  let o_noctty = F.(constant "O_NOCTTY" int)
  let o_trunc = F.(constant "O_TRUNC" int)
  let o_append = F.(constant "O_APPEND" int)
  let o_nonblock = F.(constant "O_NONBLOCK" int)
  let o_sync = F.(constant "O_SYNC" int)
  let o_async = F.(constant "O_ASYNC" int)
  let o_dsync = F.(constant "O_DSYNC" int)
  let o_rsync = F.(constant "O_RSYNC" int)
  let o_directory = F.(constant "O_DIRECTORY" int)
  let o_nofollow = F.(constant "O_NOFOLLOW" int)
  let o_cloexec = F.(constant "O_CLOEXEC" int)
  let o_direct = F.(constant "O_DIRECT" int)
  let o_noatime = F.(constant "O_NOATIME" int)
  let o_path = F.(constant "O_PATH" int)
  let o_tmpfile = F.(constant "O_TMPFILE" int)

end
