library(Rlibstemmer)
w = "anné"
w = "ann\u00E9e"

print(wordStem(w, "french"))

print(wordStem("\u00E0", "french"))

print(wordStem("\u00DCbung", language = "german"))




