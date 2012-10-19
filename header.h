//header.h
#include <iostream>

class Header {
 public:
  void SetDate(std::string newDate_);
  std::string GetDate() const;
 private:
  std::string date;
};