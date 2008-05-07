//#pragma once

#include "StdAfx.h"

#include <string>
using namespace std;

class Muck {
	public:
		static std::string Muck::SysToStd(System::String^ managed);
		static System::String^ Muck::StdToSys(std::string stl);
};