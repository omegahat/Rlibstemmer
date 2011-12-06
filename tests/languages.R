library(Rlibstemmer)

langs = getStemLanguages()
langs = setdiff(langs, c("romanian", "turkish"))

snowballDir = "~/Downloads/snowball_all"
if(file.exists(snowballDir)) {
  prefix = sprintf("%s/algorithms", snowballDir)
} else
  prefix = "http://snowball.tartarus.org"

urls = sprintf("%s/%s/voc.txt", prefix, langs)
outputs = sprintf("%s/%s/output.txt", prefix, langs)

names(urls) = langs
names(outputs) = langs

ans = mapply(function(u, lang, output) {
               input = iconv(readLines(u), "", "latin1")
               out = wordStem(input, lang)
               correct = iconv(readLines(output), "", "latin1")          
               all(out == correct)
             }, urls, langs, outputs)


if(FALSE) {
snowballDir = "~/Downloads/snowball_all/"
if(file.exists(snowballDir)) {
  
  french = iconv(readLines(sprintf("%s/algorithms/french/voc.txt", snowballDir)), "", "latin1")
  out = wordStem(french, "french")
  correct = iconv(readLines("~/Downloads/snowball_all/algorithms/french/output.txt"), "", "latin1")
  all(correct  == out)

  i = c(2, 7, 240, 1298) # These have accents.
  out[i]

  italian = iconv(readLines(sprintf("%s/algorithms/italian/voc.txt", snowballDir)), "", "latin1")
  out = wordStem(italian, "italian")

  all(correct  == out)
  sum(italian != out)/length(italian)
}
}
