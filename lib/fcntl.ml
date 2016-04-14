(*
 * Copyright (c) 2014-2016 David Sheets <sheets@alum.mit.edu>
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

  type oflag = t

  type defns = {
    o_accmode   : int;
    o_cloexec   : int option;
    o_creat     : int option;
    o_directory : int option;
    o_excl      : int option;
    o_noctty    : int option;
    o_nofollow  : int option;
    o_trunc     : int option;
    o_tty_init  : int option;
    o_append    : int option;
    o_dsync     : int option;
    o_nonblock  : int option;
    o_rsync     : int option;
    o_sync      : int option;
    o_exec      : int option;
    o_rdonly    : int option;
    o_rdwr      : int option;
    o_search    : int option;
    o_wronly    : int option;
    o_async     : int option;
    o_direct    : int option;
    o_noatime   : int option;
    o_path      : int option;
    o_tmpfile   : int option;
    o_shlock    : int option;
    o_exlock    : int option;
    o_evtonly   : int option;
    o_symlink   : int option;
  }

  let empty_defns o_accmode = {
    o_accmode;
    o_cloexec   = None;
    o_creat     = None;
    o_directory = None;
    o_excl      = None;
    o_noctty    = None;
    o_nofollow  = None;
    o_trunc     = None;
    o_tty_init  = None;
    o_append    = None;
    o_dsync     = None;
    o_nonblock  = None;
    o_rsync     = None;
    o_sync      = None;
    o_exec      = None;
    o_rdonly    = None;
    o_rdwr      = None;
    o_search    = None;
    o_wronly    = None;
    o_async     = None;
    o_direct    = None;
    o_noatime   = None;
    o_path      = None;
    o_tmpfile   = None;
    o_shlock    = None;
    o_exlock    = None;
    o_evtonly   = None;
    o_symlink   = None;
  }

  let iter_defns defns f_accmode f_exist f_missing =
    begin
      f_accmode defns.o_accmode;
      (match defns.o_cloexec with
       | Some x -> f_exist x O_CLOEXEC | None -> f_missing O_CLOEXEC);
      (match defns.o_creat with
       | Some x -> f_exist x O_CREAT | None -> f_missing O_CREAT);
      (match defns.o_directory with
       | Some x -> f_exist x O_DIRECTORY | None -> f_missing O_DIRECTORY);
      (match defns.o_excl with
       | Some x -> f_exist x O_EXCL | None -> f_missing O_EXCL);
      (match defns.o_noctty with
       | Some x -> f_exist x O_NOCTTY | None -> f_missing O_NOCTTY);
      (match defns.o_nofollow with
       | Some x -> f_exist x O_NOFOLLOW | None -> f_missing O_NOFOLLOW);
      (match defns.o_trunc with
       | Some x -> f_exist x O_TRUNC | None -> f_missing O_TRUNC);
      (match defns.o_tty_init with
       | Some x -> f_exist x O_TTY_INIT | None -> f_missing O_TTY_INIT);
      (match defns.o_append with
       | Some x -> f_exist x O_APPEND | None -> f_missing O_APPEND);
      (match defns.o_dsync with
       | Some x -> f_exist x O_DSYNC | None -> f_missing O_DSYNC);
      (match defns.o_nonblock with
       | Some x -> f_exist x O_NONBLOCK | None -> f_missing O_NONBLOCK);
      (match defns.o_rsync with
       | Some x -> f_exist x O_RSYNC | None -> f_missing O_RSYNC);
      (match defns.o_sync with
       | Some x -> f_exist x O_SYNC | None -> f_missing O_SYNC);
      (match defns.o_exec with
       | Some x -> f_exist x O_EXEC | None -> f_missing O_EXEC);
      (match defns.o_rdonly with
       | Some x -> f_exist x O_RDONLY | None -> f_missing O_RDONLY);
      (match defns.o_rdwr with
       | Some x -> f_exist x O_RDWR | None -> f_missing O_RDWR);
      (match defns.o_search with
       | Some x -> f_exist x O_SEARCH | None -> f_missing O_SEARCH);
      (match defns.o_wronly with
       | Some x -> f_exist x O_WRONLY | None -> f_missing O_WRONLY);
      (match defns.o_async with
       | Some x -> f_exist x O_ASYNC | None -> f_missing O_ASYNC);
      (match defns.o_direct with
       | Some x -> f_exist x O_DIRECT | None -> f_missing O_DIRECT);
      (match defns.o_noatime with
       | Some x -> f_exist x O_NOATIME | None -> f_missing O_NOATIME);
      (match defns.o_path with
       | Some x -> f_exist x O_PATH | None -> f_missing O_PATH);
      (match defns.o_tmpfile with
       | Some x -> f_exist x O_TMPFILE | None -> f_missing O_TMPFILE);
      (match defns.o_shlock with
       | Some x -> f_exist x O_SHLOCK | None -> f_missing O_SHLOCK);
      (match defns.o_exlock with
       | Some x -> f_exist x O_EXLOCK | None -> f_missing O_EXLOCK);
      (match defns.o_evtonly with
       | Some x -> f_exist x O_EVTONLY | None -> f_missing O_EVTONLY);
      (match defns.o_symlink with
       | Some x -> f_exist x O_SYMLINK | None -> f_missing O_SYMLINK);
    end

  let to_string = function
    | O_CLOEXEC -> "O_CLOEXEC"
    | O_CREAT -> "O_CREAT"
    | O_DIRECTORY -> "O_DIRECTORY"
    | O_EXCL -> "O_EXCL"
    | O_NOCTTY -> "O_NOCTTY"
    | O_NOFOLLOW -> "O_NOFOLLOW"
    | O_TRUNC -> "O_TRUNC"
    | O_TTY_INIT -> "O_TTY_INIT"
    | O_APPEND -> "O_APPEND"
    | O_DSYNC -> "O_DSYNC"
    | O_NONBLOCK -> "O_NONBLOCK"
    | O_RSYNC -> "O_RSYNC"
    | O_SYNC -> "O_SYNC"
    | O_EXEC -> "O_EXEC"
    | O_RDONLY -> "O_RDONLY"
    | O_RDWR -> "O_RDWR"
    | O_SEARCH -> "O_SEARCH"
    | O_WRONLY -> "O_WRONLY"
    | O_ASYNC -> "O_ASYNC"
    | O_DIRECT -> "O_DIRECT"
    | O_NOATIME -> "O_NOATIME"
    | O_PATH -> "O_PATH"
    | O_TMPFILE -> "O_TMPFILE"
    | O_SHLOCK -> "O_SHLOCK"
    | O_EXLOCK -> "O_EXLOCK"
    | O_EVTONLY -> "O_EVTONLY"
    | O_SYMLINK -> "O_SYMLINK"

  let of_string = function
    | "O_CLOEXEC" -> Some O_CLOEXEC
    | "O_CREAT" -> Some O_CREAT
    | "O_DIRECTORY" -> Some O_DIRECTORY
    | "O_EXCL" -> Some O_EXCL
    | "O_NOCTTY" -> Some O_NOCTTY
    | "O_NOFOLLOW" -> Some O_NOFOLLOW
    | "O_TRUNC" -> Some O_TRUNC
    | "O_TTY_INIT" -> Some O_TTY_INIT
    | "O_APPEND" -> Some O_APPEND
    | "O_DSYNC" -> Some O_DSYNC
    | "O_NONBLOCK" -> Some O_NONBLOCK
    | "O_RSYNC" -> Some O_RSYNC
    | "O_SYNC" -> Some O_SYNC
    | "O_EXEC" -> Some O_EXEC
    | "O_RDONLY" -> Some O_RDONLY
    | "O_RDWR" -> Some O_RDWR
    | "O_SEARCH" -> Some O_SEARCH
    | "O_WRONLY" -> Some O_WRONLY
    | "O_ASYNC" -> Some O_ASYNC
    | "O_DIRECT" -> Some O_DIRECT
    | "O_NOATIME" -> Some O_NOATIME
    | "O_PATH" -> Some O_PATH
    | "O_TMPFILE" -> Some O_TMPFILE
    | "O_SHLOCK" -> Some O_SHLOCK
    | "O_EXLOCK" -> Some O_EXLOCK
    | "O_EVTONLY" -> Some O_EVTONLY
    | "O_SYMLINK" -> Some O_SYMLINK
    | _ -> None

  let _to_code ~host = let defns = host in function
    | O_CLOEXEC   -> defns.o_cloexec
    | O_CREAT     -> defns.o_creat
    | O_DIRECTORY -> defns.o_directory
    | O_EXCL      -> defns.o_excl
    | O_NOCTTY    -> defns.o_noctty
    | O_NOFOLLOW  -> defns.o_nofollow
    | O_TRUNC     -> defns.o_trunc
    | O_TTY_INIT  -> defns.o_tty_init
    | O_APPEND    -> defns.o_append
    | O_DSYNC     -> defns.o_dsync
    | O_NONBLOCK  -> defns.o_nonblock
    | O_RSYNC     -> defns.o_rsync
    | O_SYNC      -> defns.o_sync
    | O_EXEC      -> defns.o_exec
    | O_RDONLY    -> defns.o_rdonly
    | O_RDWR      -> defns.o_rdwr
    | O_SEARCH    -> defns.o_search
    | O_WRONLY    -> defns.o_wronly
    | O_ASYNC     -> defns.o_async
    | O_DIRECT    -> defns.o_direct
    | O_NOATIME   -> defns.o_noatime
    | O_PATH      -> defns.o_path
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
  let set_exn ~host t =
    let bit = match _to_code ~host t with
      | Some bit -> bit | None -> raise Not_found
    in fun code -> bit lor code
  let set ~host t code =
    try Some (set_exn ~host t code) with Not_found -> None

  (* This can't roundtrip [] because O_RDONLY is 0 *)
  let to_code_exn ~host = List.fold_left (fun code t -> set_exn ~host t code) 0

  let to_code ~host l =
    try Some (to_code_exn ~host l) with Not_found -> None

  let with_code defns symbol code = match symbol with
    | O_CLOEXEC   -> { defns with o_cloexec = code }
    | O_CREAT     -> { defns with o_creat = code }
    | O_DIRECTORY -> { defns with o_directory = code }
    | O_EXCL      -> { defns with o_excl = code }
    | O_NOCTTY    -> { defns with o_noctty = code }
    | O_NOFOLLOW  -> { defns with o_nofollow = code }
    | O_TRUNC     -> { defns with o_trunc = code }
    | O_TTY_INIT  -> { defns with o_tty_init = code }
    | O_APPEND    -> { defns with o_append = code }
    | O_DSYNC     -> { defns with o_dsync = code }
    | O_NONBLOCK  -> { defns with o_nonblock = code }
    | O_RSYNC     -> { defns with o_rsync = code }
    | O_SYNC      -> { defns with o_sync = code }
    | O_EXEC      -> { defns with o_exec = code }
    | O_RDONLY    -> { defns with o_rdonly = code }
    | O_RDWR      -> { defns with o_rdwr = code }
    | O_SEARCH    -> { defns with o_search = code }
    | O_WRONLY    -> { defns with o_wronly = code }
    | O_ASYNC     -> { defns with o_async = code }
    | O_DIRECT    -> { defns with o_direct = code }
    | O_NOATIME   -> { defns with o_noatime = code }
    | O_PATH      -> { defns with o_path = code }
    | O_TMPFILE   -> { defns with o_tmpfile = code }
    | O_SHLOCK    -> { defns with o_shlock = code }
    | O_EXLOCK    -> { defns with o_exlock = code }
    | O_EVTONLY   -> { defns with o_evtonly = code }
    | O_SYMLINK   -> { defns with o_symlink = code }

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
        O_SHLOCK;
        O_EXLOCK;
        O_EVTONLY;
        O_SYMLINK;
      ]

  module Host = struct
    type t = defns

    let of_defns defns = defns
    let to_defns host  = host

    let iter = iter_defns

    let to_string defns =
      let buf = Buffer.create 1024 in
      iter defns
        (fun o_accmode ->
           let line = Printf.sprintf "O_ACCMODE\t%d\n" o_accmode in
           Buffer.add_string buf line
        )
        (fun code symbol ->
           let line = Printf.sprintf "%s\t%d\n" (to_string symbol) code in
           Buffer.add_string buf line
        )
        (fun symbol ->
           let line = Printf.sprintf "%s\t\n" (to_string symbol) in
           Buffer.add_string buf line
        );
      Buffer.contents buf

    let of_string s =
      let o_accmode = Scanf.sscanf s "O_ACCMODE\t%d\n" (fun code -> code) in
      let rec read_lines defns s =
        match Scanf.sscanf s "%s\t%s\n"
                (fun symbol_s code_s ->
                   of_string symbol_s,
                   (if code_s = ""
                    then None
                    else Some (int_of_string code_s)),
                   String.(length symbol_s + 1 + length code_s + 1)
                )
        with
        | exception End_of_file -> defns
        | Some symbol, code, off ->
          read_lines (with_code defns symbol code)
            String.(sub s off (length s - off))
        | None, code, off ->
          read_lines defns String.(sub s off (length s - off))
      in
      read_lines (empty_defns o_accmode) s

  end

end

module Host = struct
  type t = {
    oflags : Oflags.Host.t;
  }

  let to_string { oflags } = Oflags.Host.to_string oflags
  let of_string s = { oflags = Oflags.Host.of_string s }

  let iter { oflags=oflags_host } ~oflags =
    let (f_accmode, f_exist, f_missing) = oflags in
    Oflags.Host.iter oflags_host f_accmode f_exist f_missing
end
