#include <iostream>
#include <cmath>
#include <cstdio>

int main(int argc, char* argv[])
{
	for (int argi=1; argi<argc; argi++){
		std::cout << argv[argi] << std::endl;
	}
	return 0;
}
