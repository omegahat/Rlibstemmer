SupportedEncodings = c( "UTF_8", "ISO_8859_1", "CP850", "KOI8_R")


wordStem =
function(words, language = "english", encoding = findEncoding(words))
{
    # if the encoding is UTF-8, we can leave it as empty.
    # Otherwise, we have to match to one of
    #   UTF_8, ISO_8859_1, CP850 or KOI8_R
    # See libstemmer.h and the docs. for sb_stemmer_new in particular.
  if(length(encoding) && nchar(encoding) > 0) {
     encoding = gsub("-", "_", encoding)
     if(encoding == "latin1")
        encoding = "ISO_8859_1"
     
     encoding = match.arg(encoding, SupportedEncodings)
  }
  
  outputEncoding = getEncodingValue(encoding)  
  if(is.character(outputEncoding))
     outputEncoding = getEncodingValue(outputEncoding)
  
  ans = character(length(words))
  .Call("R_stem_words", as.character(words), as.character(language), as.character(encoding), ans,
           as.integer(outputEncoding))
}

findEncoding =
function(x)
{
  els = setdiff(Encoding(x), "unknown")
  if(length(els) == 0)
    return("")
  
  if(length(els) > 1)
     warning("more than one encoding. Consider stemming the elements with different encodings separately")
  els[1]
}

CE_NATIVE = 0L
CE_UTF8 = 1L
CE_LATIN1 = 2L
CE_SYMBOL = 5L

getEncodingValue =
function(val)
{
 if(length(val) == 0)
   return(CE_NATIVE)

 if(is.character(val))
   switch(val, "UTF8"=, "UTF_8" = CE_UTF8, "latin1" =, "ISO_8859_1" = CE_LATIN1, CE_NATIVE)
 else
   as.integer(val)
}
  
