#ifndef CLASS_HPP
#define CLASS_HPP
// template<typename T1, typename T2, ...>
class Class {
  public:
    Class() = default;
    ~Class() = default;
    Class(const Class&) = default;
    Class& operator=(const Class&) = default;
  protected:
    // inherited member variables
    // inherited and overridable (polymorphic) member functions
  private:
    // base member variables and functions

  // example templated functionality
  public:
    void executeFunction(); // public interface
  protected:
    virtual void _executeFunction() = 0; // unimplemented inheritable interface
};
#endif /* CLASS_HPP */
