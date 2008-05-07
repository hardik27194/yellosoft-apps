// From http://www.cs.virginia.edu/~cs216/Fall2005/labs/helpdocs/system.string.html
// Included for all those who can't afford VisualStudio RichFuck Edition

#include "StdAfx.h"
#include "Muck.h"

#include "stdafx.h"

#include <iostream>
#include <string>
using namespace std;

#using <mscorlib.dll>
using namespace System;
using namespace System::Text;
using namespace System::Runtime::InteropServices;

//Converts a System::String to a std::string
//This code assumes that you have used the following namespace:
// using namespace System::Runtime::InteropServices;
std::string Muck::SysToStd(System::String^ managed) {
    //get a pointer to an array of ANSI chars
    char *chars = (char*) Marshal::StringToHGlobalAnsi(managed).ToPointer();

    //assign the array to an STL string
    std::string stl = chars;

    //free the memory used by the array
    //since the array is not managed, it will not be claimed by the garbage collector
    Marshal::FreeHGlobal(System::IntPtr(chars));

    return stl;
}

//Converts a std::string to a System::String
//This code assumes that you have used the following namespace:
// using namespace System::Runtime::InteropServices
System::String^ Muck::StdToSys(std::string stl) {
	//the c_str() function gets a char array from the STL string,
	//but the PtrToStringAnsi function wants a int array, so it gets casted

	return Marshal::PtrToStringAnsi(System::IntPtr((int*) stl.c_str()));
}