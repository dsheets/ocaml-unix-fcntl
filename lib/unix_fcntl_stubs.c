/*
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
 */

#define _DEFAULT_SOURCE
#define _POSIX_C_SOURCE 200809L

#include <stdint.h>
#include <fcntl.h>
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/threads.h>

#define UNUSED(x) (void)(x)

#ifndef O_ACCMODE
#define O_ACCMODE (-1)
#endif
#ifndef O_RDONLY
#define O_RDONLY (-1)
#endif
#ifndef O_WRONLY
#define O_WRONLY (-1)
#endif
#ifndef O_RDWR
#define O_RDWR (-1)
#endif
#ifndef O_CREAT
#define O_CREAT (-1)
#endif
#ifndef O_EXCL
#define O_EXCL (-1)
#endif
#ifndef O_NOCTTY
#define O_NOCTTY (-1)
#endif
#ifndef O_TRUNC
#define O_TRUNC (-1)
#endif
#ifndef O_APPEND
#define O_APPEND (-1)
#endif
#ifndef O_NONBLOCK
#define O_NONBLOCK (-1)
#endif
#ifndef O_SYNC
#define O_SYNC (-1)
#endif
#ifndef O_ASYNC
#define O_ASYNC (-1)
#endif
#ifndef O_DSYNC
#define O_DSYNC (-1)
#endif
#ifndef O_RSYNC
#define O_RSYNC (-1)
#endif
#ifndef O_LARGEFILE
#define O_LARGEFILE (-1)
#endif
#ifndef O_DIRECTORY
#define O_DIRECTORY (-1)
#endif
#ifndef O_NOFOLLOW
#define O_NOFOLLOW (-1)
#endif
#ifndef O_CLOEXEC
#define O_CLOEXEC (-1)
#endif
#ifndef O_DIRECT
#define O_DIRECT (-1)
#endif
#ifndef O_NOATIME
#define O_NOATIME (-1)
#endif
#ifndef O_PATH
#define O_PATH (-1)
#endif

CAMLprim value unix_fcntl_o_accmode() {
  return caml_copy_int32(O_ACCMODE);
}
CAMLprim value unix_fcntl_o_rdonly() {
  return caml_copy_int32(O_RDONLY);
}
CAMLprim value unix_fcntl_o_wronly() {
  return caml_copy_int32(O_WRONLY);
}
CAMLprim value unix_fcntl_o_rdwr() {
  return caml_copy_int32(O_RDWR);
}
CAMLprim value unix_fcntl_o_creat() {
  return caml_copy_int32(O_CREAT);
}
CAMLprim value unix_fcntl_o_excl() {
  return caml_copy_int32(O_EXCL);
}
CAMLprim value unix_fcntl_o_noctty() {
  return caml_copy_int32(O_NOCTTY);
}
CAMLprim value unix_fcntl_o_trunc() {
  return caml_copy_int32(O_TRUNC);
}
CAMLprim value unix_fcntl_o_append() {
  return caml_copy_int32(O_APPEND);
}
CAMLprim value unix_fcntl_o_nonblock() {
  return caml_copy_int32(O_NONBLOCK);
}
CAMLprim value unix_fcntl_o_sync() {
  return caml_copy_int32(O_SYNC);
}
CAMLprim value unix_fcntl_o_async() {
  return caml_copy_int32(O_ASYNC);
}
CAMLprim value unix_fcntl_o_dsync() {
  return caml_copy_int32(O_DSYNC);
}
CAMLprim value unix_fcntl_o_rsync() {
  return caml_copy_int32(O_RSYNC);
}
CAMLprim value unix_fcntl_o_largefile() {
  return caml_copy_int32(O_LARGEFILE);
}
CAMLprim value unix_fcntl_o_directory() {
  return caml_copy_int32(O_DIRECTORY);
}
CAMLprim value unix_fcntl_o_nofollow() {
  return caml_copy_int32(O_NOFOLLOW);
}
CAMLprim value unix_fcntl_o_cloexec() {
  return caml_copy_int32(O_CLOEXEC);
}
CAMLprim value unix_fcntl_o_direct() {
  return caml_copy_int32(O_DIRECT);
}
CAMLprim value unix_fcntl_o_noatime() {
  return caml_copy_int32(O_NOATIME);
}
CAMLprim value unix_fcntl_o_path() {
  return caml_copy_int32(O_PATH);
}

int unix_fcntl_open_perms(const char *path, int oflag, mode_t perms) {
  int retval;
  caml_release_runtime_system();
  retval = open(path, oflag, perms);
  caml_acquire_runtime_system();
  return retval;
}

value unix_fcntl_open_perms_ptr(value _) {
  UNUSED(_);
  return caml_copy_int64((intptr_t)(void *)unix_fcntl_open_perms);
}

int unix_fcntl_open_none(const char *path, int oflag) {
  int retval;
  caml_release_runtime_system();
  retval = open(path, oflag);
  caml_acquire_runtime_system();
  return retval;
}

value unix_fcntl_open_none_ptr(value _) {
  UNUSED(_);
  return caml_copy_int64((intptr_t)(void *)unix_fcntl_open_none);
}
