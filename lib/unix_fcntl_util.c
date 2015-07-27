#define _GNU_SOURCE
#define _POSIX_C_SOURCE 200809L
#define _DARWIN_C_SOURCE

#include <fcntl.h>

#define FORCE_CHECK 0

#define LINUX defined(__linux__)
#define APPLE defined(__APPLE__)

int unix_fcntl_o_shlock() {
#define O_SHLOCK_UNAVAILABLE (LINUX)
#if !FORCE_CHECK && O_SHLOCK_UNAVAILABLE && !defined(O_SHLOCK)
  return -1;
#else
  return O_SHLOCK;
#endif
}

int unix_fcntl_o_exlock() {
#define O_EXLOCK_UNAVAILABLE (LINUX)
#if !FORCE_CHECK && O_EXLOCK_UNAVAILABLE && !defined(O_EXLOCK)
  return -1;
#else
  return O_EXLOCK;
#endif
}

int unix_fcntl_o_evtonly() {
#define O_EVTONLY_AVAILABLE (APPLE)
#if !FORCE_CHECK && !O_EVTONLY_AVAILABLE && !defined(O_EVTONLY)
  return -1;
#else
  return O_EVTONLY;
#endif
}

int unix_fcntl_o_symlink() {
#define O_SYMLINK_AVAILABLE (APPLE)
#if !FORCE_CHECK && !O_SYMLINK_AVAILABLE && !defined(O_SYMLINK)
  return -1;
#else
  return O_SYMLINK;
#endif
}

int unix_fcntl_o_search() {
#define O_SEARCH_UNAVAILABLE (LINUX || APPLE)
#if !FORCE_CHECK && O_SEARCH_UNAVAILABLE && !defined(O_SEARCH)
  return -1;
#else
  return O_SEARCH;
#endif
}

int unix_fcntl_o_exec() {
#define O_EXEC_UNAVAILABLE (LINUX || APPLE)
#if !FORCE_CHECK && O_EXEC_UNAVAILABLE && !defined(O_EXEC)
  return -1;
#else
  return O_EXEC;
#endif
}

int unix_fcntl_o_tty_init() {
#define O_TTY_INIT_UNAVAILABLE (LINUX || APPLE)
#if !FORCE_CHECK && O_TTY_INIT_UNAVAILABLE && !defined(O_TTY_INIT)
  return -1;
#else
  return O_TTY_INIT;
#endif
}
