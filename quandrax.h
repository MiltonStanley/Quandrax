//Quandrax.h
#include <iostream>

class Header {
 public:
  void SetDate(new_date);
  std::string GetDate() const;
 private:
  std::string date;
};