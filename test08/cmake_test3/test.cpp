
#include <iostream>
#include <string>
 
using namespace std;
 
int main()
{
    int a = 100;
    string strTest;
 
    strTest = to_string(a) + " is a string.";
 
    cout << "a is: " << a << endl;
    cout << "pszTest is: " << strTest << endl;
 
    return 0;
}
