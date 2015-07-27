#include <fcntl.h>

#define FORCE_CHECK 0

#define LINUX defined(__linux__)
#define APPLE defined(__APPLE__)

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
