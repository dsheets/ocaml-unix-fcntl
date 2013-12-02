module Oflags : sig
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

  type host

  val to_open_flag_exn : t -> Unix.open_flag
  val to_open_flag : t -> Unix.open_flag option
  val of_open_flag : Unix.open_flag -> t

  val host : host
  val to_code : host:host -> t list -> int32
  val of_code : host:host -> int32 -> t list

  val is_set : host:host -> t -> int32 -> bool
  val set : host:host -> t -> int32 -> int32
end

