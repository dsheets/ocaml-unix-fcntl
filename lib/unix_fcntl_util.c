#include <fcntl.h>

#define FORCE_CHECK 0

int unix_fcntl_o_search() {
#if !FORCE_CHECK && defined(__linux__) && !defined(O_SEARCH)
  return -1;
#else
  return O_SEARCH;
#endif
}

int unix_fcntl_o_exec() {
#if !FORCE_CHECK &&  defined(__linux__) && !defined(O_EXEC)
  return -1;
#else
  return O_EXEC;
#endif
}

int unix_fcntl_o_tty_init() {
#if !FORCE_CHECK && defined(__linux__) && !defined(O_TTY_INIT)
  return -1;
#else
  return O_TTY_INIT;
#endif
}
