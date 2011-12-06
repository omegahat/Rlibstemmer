#include "libstemmer.h"
#include <Rdefines.h>

typedef struct sb_stemmer * Stemmer_p;

#define CHAR_DEREF(a) CHAR(a)


SEXP 
R_stem_words(SEXP words, SEXP language, SEXP encoding, SEXP r_ans, SEXP r_outEncoding)
{
    unsigned int i, n;
    const char *char_encoding = NULL, *tmp;
    Stemmer_p stemmer;
    cetype_t outEncoding = INTEGER(r_outEncoding)[0];

    n = Rf_length(words);

    if(Rf_length(encoding)) {
	tmp = CHAR_DEREF(STRING_ELT(encoding, 0));
	if(tmp && tmp[0])
	    char_encoding = tmp;
    }
    stemmer = sb_stemmer_new(CHAR_DEREF(STRING_ELT(language, 0)), char_encoding);
    if(!stemmer) {
	PROBLEM "cannot create stemmer object"
	    ERROR;
    }

    for(i = 0; i < n; i++) {
	const sb_symbol *in, *out;
	SEXP tmp, el;
	unsigned int len;
	int unprotect_p = 0;

        in = CHAR_DEREF(STRING_ELT(words, i));
	len = strlen(in);
	out = sb_stemmer_stem(stemmer, in, len);
	if(!out)
	    tmp = R_NaString;
	else {
	    len = sb_stemmer_length(stemmer);
	    PROTECT(tmp = mkCharLenCE(out, len, outEncoding));
	    unprotect_p = 1;
	}
  	SET_STRING_ELT(r_ans, i, tmp);
	if(unprotect_p)
	    UNPROTECT(1);
    }   

    sb_stemmer_delete(stemmer);

    return(r_ans);
}
