#include <foo/foo.h>
#include <iostream>

void main(int argc, char* arcv[])
{
	auto arg = 14;
	Foo m_foo(arg);
	std::cout << "Arg: " << arg << std::endl;
	std::cout << "Foo output: " << m_foo.getVal() << std::endl;
	std::cout << m_foo.bar() << std::endl;
}