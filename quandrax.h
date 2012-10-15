//Quandrax.h
#include <iostream>

class Header {
 public:
  void SetDate(std::lstring);
  std::string GetDate() const;
 private:
  std::string date;
};