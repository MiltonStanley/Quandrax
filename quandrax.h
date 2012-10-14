//Quandrax.h
#include <iostream>

class Header {
 public:
  void SetDate(std::string);
  std::string GetDate() const;
 private:
  std::string date;
};