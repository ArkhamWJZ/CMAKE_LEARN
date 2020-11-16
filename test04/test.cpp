#include <stdio.h>
#include "add.h"
#include "sub.h"
#include "div.h"

int main(int argc, char* argv[]){
        int a = 20;
        int b = 10;
        printf("%d+%d=%d\n",a,b,add(a,b));
        printf("%d-%d=%d\n",a,b,sub(a,b));
        printf("%d/%d=%d\n",a,b,div(a,b));
        return 0;
}