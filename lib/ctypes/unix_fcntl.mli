module Oflags : sig
  include module type of Unix_fcntl_common.Oflags

  val view : host:host -> t list Ctypes.typ
end
