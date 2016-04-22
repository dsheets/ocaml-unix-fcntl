/*
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
 */

#include <errno.h>
#include <string.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "caml/memory.h"
#include "caml/alloc.h"

#include "lwt_unix.h"

struct job_open {
  struct lwt_unix_job job;
  int flags;
  int has_perms;
  int perms;
  int fd;
  int error_code;
  char *name;
  char data[];
};


static void worker_open(struct job_open *job)
{
  job->fd = job->has_perms
    ? open(job->name, job->flags, job->perms)
    : open(job->name, job->flags);
  job->error_code = errno;
}

static value result_open(struct job_open *job)
{
  value result = caml_alloc_tuple(2);
  Field(result, 0) = Val_int(job->fd);
  Field(result, 1) = Val_int(job->error_code);
  lwt_unix_free_job(&job->job);
  return result;
}

CAMLprim
value unix_fcntl_lwt_open_job(value name, value flags, value perms)
{
  CAMLparam3(name, flags, perms);
  LWT_UNIX_INIT_JOB_STRING(job, open, 0, name);

  job->flags = Int_val(flags);
  job->has_perms = perms != Val_int(0);
  if (job->has_perms) {
    job->perms = Int_val(Field (perms, 0));
  }

  CAMLreturn(lwt_unix_alloc_job(&(job->job)));
}
