#include <iostream>
#include "Class.hpp"

// file-static helper variables and functions

// see http://en.cppreference.com/w/cpp/language/member_template
// for defining member functions outside of a templated class declaration

void Class::executeFunction() {
  std::cout << "Now executing possibly overriden template" << std::endl;
  _executeFunction();
}
