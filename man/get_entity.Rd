% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/accessors.R
\name{get_entity}
\alias{get_entity}
\title{Access named entities from an annotation object}
\usage{
get_entity(annotation)
}
\arguments{
\item{annotation}{an annotation object}
}
\value{
Returns an object of class \code{c("tbl_df", "tbl", "data.frame")}
 containing one row for every named entity mention in the corpus.

 The returned data frame includes the following columns:

\itemize{
 \item{"id"}{ - integer. Id of the source document.}
 \item{"sid"}{ - integer. Sentence id of the entity mention.}
 \item{"tid"}{ - integer. Token id at the start of the entity mention.}
 \item{"tid_end"}{ - integer. Token id at the end of the entity mention.}
 \item{"entity_type"}{ - character. See below from details.}
 \item{"entity"}{ - character. Raw words of the named entity in the text.}
}
}
\description{
Named entity recognition attempts to find the mentions of various
categories within the corpus of text. Common example include proper
references to location (e.g., "Boston", or "England") or people
(e.g., "Winston Churchill"), as well as
specific dates (e.g., "tomorrow", or "September 19th") times, or numbers.
}
\details{
When using CoreNLP, the default entity types are:
 \itemize{
   \item{"LOCATION"}{ Countries, cities, states, locations, mountain
      ranges, bodies of water.}
   \item{"PERSON"}{ People, including fictional.}
   \item{"ORGANIZATION"}{ Companies, agencies, institutions, etc.}
   \item{"MONEY"}{ Monetary values, including unit.}
   \item{"PERCENT"}{ Percentages.}
   \item{"DATE"}{ Absolute or relative dates or periods.}
   \item{"TIME"}{ Times smaller than a day.}
 }
 For the spaCy engine there is no generic LOCATION, ORGANIZATION is
 shortened to ORG, and the following categories are added:
 \itemize{
   \item{"NORP"}{ Nationalities or religious or political groups.}
   \item{"FACILITY"}{ Buildings, airports, highways, bridges, etc.}
   \item{"GPE"}{ Countries, cities, states.}
   \item{"LOC"}{ Non-GPE locations, mountain ranges, bodies of water.}
   \item{"PRODUCT"}{ Objects, vehicles, foods, etc. (Not services.)}
   \item{"EVENT"}{ Named hurricanes, battles, wars, sports events, etc.}
   \item{"WORK_OF_ART"}{ Titles of books, songs, etc.}
   \item{"LANGUAGE"}{ Any named language.}
   \item{"QUANTITY"}{ Measurements, as of weight or distance.}
   \item{"ORDINAL"}{ "first", "second", etc.}
   \item{"CARDINAL"}{ Numerals that do not fall under another type.}
 }
}
\examples{
require(dplyr)
data(obama)

# what are the most common entity types used in the addresses?
get_entity(obama)$entity_type \%>\%
 table()

# what are the most common locations mentioned?
res <- get_entity(obama) \%>\%
  filter(entity_type == "LOCATION")
res$entity \%>\%
  table() \%>\%
  sort(decreasing = TRUE) \%>\%
  head(n = 25)

# what are the most common organizations mentioned?
res <- get_entity(obama) \%>\%
  filter(entity_type == "ORGANIZATION")
res$entity \%>\%
  table() \%>\%
  sort(decreasing = TRUE) \%>\%
  head(n = 25)

}
\references{
Manning, Christopher D., Mihai Surdeanu, John Bauer, Jenny Finkel,
  Steven J. Bethard, and David McClosky. 2014.
  \href{http://nlp.stanford.edu/pubs/StanfordCoreNlp2014.pdf}{
  The Stanford CoreNLP Natural Language Processing Toolkit}.
  In: \emph{Proceedings of the 52nd Annual Meeting of the
  Association for Computational Linguistics: System Demonstrations,
  pp. 55-60.}

  Jenny Rose Finkel, Trond Grenager, and Christopher Manning. 2005.
  Incorporating Non-local Information into Information Extraction
  Systems by Gibbs Sampling. In: \emph{Proceedings of the 43nd
  Annual Meeting of the Association for Computational Linguistics
  (ACL 2005), pp. 363-370.}
}
\author{
Taylor B. Arnold, \email{taylor.arnold@acm.org}
}
