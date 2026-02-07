#pragma once

#include "defines.h"


namespace Requiem {
  enum class LogLevel {
    FATAL = 0,
    ERROR,
    WARN,
    INFO,
    DEBUG,
    TRACE
  };
  struct RQAPI Logger {
  public:
    Logger();
    ~Logger();
  private:
  };
};