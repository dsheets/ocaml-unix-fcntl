int unix_fcntl_o_search() {
#if defined(__linux__) && !defined(O_SEARCH)
  return -1;
#else
  return O_SEARCH;
#endif
}

int unix_fcntl_o_exec() {
#if defined(__linux__) && !defined(O_EXEC)
  return -1;
#else
  return O_EXEC;
#endif
}

int unix_fcntl_o_tty_init() {
#if defined(__linux__) && !defined(O_TTY_INIT)
  return -1;
#else
  return O_TTY_INIT;
#endif
}
