#include <foo/foo.h>

Foo::Foo(int val)
	:_val(val)
{
	
}

int Foo::getVal() const
{
	return _val;
}

std::string Foo::bar() const
{
	return "Value: " + std::to_string(_val);
}
