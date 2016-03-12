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


module Open =
struct
  let nofollow () =
    let symlink = Printf.sprintf "symlink.%f" (Unix.time ()) in
    let cleanup () = try Unix.unlink symlink with Unix.Unix_error _ -> () in
    begin try
        let () = Unix.symlink "/dev/null" symlink in

        (* Opening a symlink with O_NOFOLLOW should fail with ELOOP *)
        Alcotest.check_raises "O_NOFOLLOW fails with ELOOP"
          (Unix.Unix_error (Unix.ELOOP, "open", symlink))
          (fun () ->
             ignore @@
             Lwt_unix.run
               (Fcntl_unix_lwt.open_ symlink Fcntl.Oflags.[O_NOFOLLOW]))
        ;

        (* Opening a symlink with O_NOFOLLOW|OPATH should succeed *)
        ignore @@
        Lwt_unix.run
          (Fcntl_unix_lwt.open_ symlink Fcntl.Oflags.[O_NOFOLLOW;
                                                      O_PATH]);
      with e ->
        cleanup ();
        raise e
    end;
    cleanup ()
      

  let tests = [
    "nofollow", `Quick, nofollow;
  ]
end


let tests = [
  "open", Open.tests;
]


let () = Alcotest.run "Dirent_unix" tests
