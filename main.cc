/* main.cc */

#include "main.h"

// prototype of bison-generated parser function
typedef struct yy_buffer_state * YY_BUFFER_STATE;
extern int yyparse();
extern YY_BUFFER_STATE yy_scan_string (const char * yystr);
extern void yy_delete_buffer(YY_BUFFER_STATE buffer);

int main(int argc, char **argv) {
  YY_BUFFER_STATE buffer = yy_scan_string(argv[1]);
  yyparse();
  yy_delete_buffer(buffer);

  return 0;
}

