%{
#include <stdio.h>
#include "tokens.h"
uint32_t line_number=1;
%}

space [ ]
alphabet [a-zA-Z]
digit [0-9]
newline [\n]
tab [\t]
single_char "kiki"
underscore [_]
invalid [`@$]
string \"(\\[nt\"'\\]|[^"\n\\])*\"  
identifier ({alphabet}|{underscore})({alphabet}|{digit}|{underscore})*

%%
printf {printf("doneg\n");}
{identifier} {printf("niiv\n");}


%%

