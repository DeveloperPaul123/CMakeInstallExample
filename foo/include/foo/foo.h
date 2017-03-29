#pragma once

#include <string>

class Foo {
public:
	explicit Foo(int val = 0);
	int getVal() const;
	std::string bar() const;
private:
	int _val;
};