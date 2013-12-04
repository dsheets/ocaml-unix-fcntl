module Oflags = struct
  include Unix_fcntl_common.Oflags

  let view ~host = Ctypes.(
    view ~read:(of_code ~host) ~write:(to_code ~host) int32_t
  )
end

type host = {
  oflags : Oflags.host;
}

open Ctypes
open Foreign
open Unsigned
