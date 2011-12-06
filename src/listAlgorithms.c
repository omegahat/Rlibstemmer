#include "libstemmer.h"
#include <Rdefines.h>

SEXP
R_sb_stemmer_list()
{
    const char **ans, **ptr;
    unsigned int n = 0, i;
    SEXP r_ans;
    ptr = ans = sb_stemmer_list();
    
    while(ptr && *ptr) {
	ptr++; n++;
    }

    PROTECT(r_ans = NEW_CHARACTER(n));
    for(i = 0; i < n; i++)
	SET_STRING_ELT(r_ans, i, mkChar(ans[i]));
    UNPROTECT(1);
    return(r_ans);
}
