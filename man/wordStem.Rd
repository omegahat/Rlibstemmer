\name{wordStem}
\alias{wordStem}
\title{Get the common root/stem of words}
\description{
  This function computes the stems of each of the
  given words in the vector.
  This reduces a word to its base component,
  making it easier to compare words
  like win, winning, winner.
  See \url{http://snowball.tartarus.org/} for
  more information about the concept and algorithms
  for stemming.

  Note that the turkish and romanian algorithms
  do not work for "latin1" encoding and give an error
  creating the stemmer object, i.e. before getting to stemming any words.
}
\usage{
wordStem(words, language = "english", encoding = findEncoding(words))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{words}{a character vector of words whose stems are to be
    computed.}
  \item{language}{the name of a recognized language for the package.
    This should either be a single string which is an element in the
    vector  returned by \code{\link{getStemLanguages}}, or
    alternatively a character vector of length 3
    giving the names of the routines for
    creating and closing a Snowball \code{SN\_env} environment
    and performing the stem (in that order).
    See the example below.
  }
  \item{encoding}{the name of the encoding to use. This will be computed
   from the values returned by a call to \code{Encoding} on
   \code{words}.
   However, the caller can specify the name of the encoding of the
   inputs directly.
   In the future, we might add a facility that handles elements
   with different encodings separately.  At present, they all
   use the same encoding.
 }
% \item{outputEncoding}{a character string or an integer identifying the
%   encoding of the output vector.  This should not be needed.}
}
\details{
  This uses Dr. Martin Porter's stemming algorithm
  and the interface generated by  Snowball
  \url{http://snowball.tartarus.org/}.
  
}
\value{
  A character vector with as many elements
  as there are in the input vector
  with the corresponding elements being the
  stem of the  word.
}
\references{
See \url{http://snowball.tartarus.org/}
}
\author{Duncan Temple Lang <duncan@wald.ucdavis.edu>}


\examples{

   # Simple example
   # "win"    "win"    "winner"
 wordStem(c("win", "winning", 'winner'))


  # test the supplied vocabulary.
 testWords = readLines(system.file("words", "english", "voc.txt", package = "Rstem"))
 validate = readLines(system.file("words", "english", "output.txt", package = "Rstem"))

\dontrun{
 # Read the test words directly from the snowball site over the Web
 testWords = readLines(url("http://snowball.tartarus.org/english/voc.txt"))
}


 testOut = wordStem(testWords)
 all(validate == testOut)

  # Specify the language from one of the built-in languages.
 testOut = wordStem(testWords, "english")
 all(validate == testOut)

 wordStem("\u1405")
}
\keyword{IO}
\keyword{utilities}
