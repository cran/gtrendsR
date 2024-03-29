% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gtrends.R
\name{gtrends}
\alias{gtrends}
\title{Google Trends Query}
\usage{
gtrends(
  keyword = NA,
  geo = "",
  time = "today+5-y",
  gprop = c("web", "news", "images", "froogle", "youtube"),
  category = 0,
  hl = "en-US",
  compared_breakdown = FALSE,
  low_search_volume = FALSE,
  cookie_url = "http://trends.google.com/Cookies/NID",
  tz = 0,
  onlyInterest = FALSE
)
}
\arguments{
\item{keyword}{A character vector with the actual Google Trends query
keywords. Multiple keywords are possible using \code{gtrends(c("NHL",
"NBA", "MLB", "MLS"))}.}

\item{geo}{A character vector denoting geographic regions for the query,
default to \dQuote{all} for global queries. Multiple regions are possible
using \code{gtrends("NHL", c("CA", "US"))}.}

\item{time}{A string specifying the time span of the query. Possible values
  are:

  \describe{ \item{"now 1-H"}{Last hour} \item{"now 4-H"}{Last four hours}
  \item{"now 1-d"}{Last day} \item{"now 7-d"}{Last seven days} \item{"today
  1-m"}{Past 30 days} \item{"today 3-m"}{Past 90 days} \item{"today
  12-m"}{Past 12 months} \item{"today+5-y"}{Last five years (default)}
  \item{"all"}{Since the beginning of Google Trends (2004)} \item{"Y-m-d
  Y-m-d"}{Time span between two dates (ex.: "2010-01-01 2010-04-03")} }}

\item{gprop}{A character string defining the Google product for which the
  trend query if preformed. Valid options are:

  \itemize{ \item "web" (default) \item "news" \item "images" \item "froogle"
  \item "youtube" }}

\item{category}{A character denoting the category, defaults to \dQuote{0}.}

\item{hl}{A string specifying the ISO language code (ex.: \dQuote{en-US} or
\dQuote{fr}). Default is \dQuote{en-US}. Note that this is only influencing
the data returned by related topics.}

\item{compared_breakdown}{Logical. Should compare breakdown the results by
city and subregion? Can only be used if one `geo` is used conjointly with
more than one keyword. If `TRUE`, then the relative hits across the
keywords will be returned. `FALSE` by default.}

\item{low_search_volume}{Logical. Should include low search volume regions?}

\item{cookie_url}{A string specifying the URL from which to obtain cookies.
Default should work in general; should only be changed by advanced users.}

\item{tz}{A number specifying the minutes the returned dates should be offset
to UTC. Note the parameter 'time' above is specified in UTC. E.g. choosing
"time=2018-01-01T01 2018-01-01T03" and "tz=-120" will yield data between
2018-01-01T03 and 2018-01-01T05, i.e. data specified to be in UTC+2.}

\item{onlyInterest}{If you only want the interest over time set it to TRUE.}
}
\value{
An object of class \sQuote{gtrends} (basically a list of data
  frames).
}
\description{
The \code{gtrends} default method performs a Google Trends query for the
\sQuote{query} argument and session \sQuote{session}. Optional arguments for
geolocation and category can also be supplied.
}
\section{Categories}{
 The package includes a complete list of categories that
  can be used to narrow requests. These can be accessed using
  \code{data("categories")}.
}

\section{Related topics}{
 Note that *related topics* are not retrieved when
  more than one keyword is provided due to Google restriction.
}

\examples{
\dontrun{

head(gtrends("NHL")$interest_over_time)
head(gtrends("NHL")$related_topics)
head(gtrends("NHL")$related_queries)

head(gtrends(c("NHL", "NFL"))$interest_over_time)

head(gtrends(c("NHL", "NFL"), geo = c("CA", "US"))$interest_over_time)

## Interest by city

gtrends(keyword = "obama", geo = "US-AL-630")

## Sport category (20)
data(categories)
categories[grepl("^Sport", categories$name), ]
gtrends(c("NHL", "NFL"), geo = c("CA", "US"), category = 20)
gtrends(geo = c("CA"), category = 20)

## Playing with time format

gtrends(c("NHL", "NFL"), time = "now 1-H") # last hour
gtrends(c("NHL", "NFL"), time = "now 4-H") # last four hours
gtrends(c("NHL", "NFL"), time = "now 1-d") # last day
gtrends(c("NHL", "NFL"), time = "today 1-m") # last 30 days
gtrends(c("NHL", "NFL"), time = "today 3-m") # last 90 days
gtrends(c("NHL", "NFL"), time = "today 12-m") # last 12 months
gtrends(c("NHL", "NFL"), time = "today+5-y") # last five years (default)
gtrends(c("NHL", "NFL"), time = "all") # since 2004

## Custom date format

gtrends(c("NHL", "NFL"), time = "2010-01-01 2010-04-03")

## Search from various Google's services

head(gtrends(c("NHL", "NFL"), gprop = "news")$interest_over_time)
head(gtrends(c("NHL", "NFL"), gprop = "youtube")$interest_over_time)

## Language settings

head(gtrends("NHL", hl = "en")$related_topics)
head(gtrends("NHL", hl = "fr")$related_topics)

## Compared breakdown
head(gtrends(keyword = c("nhl", "nba"), geo = "CA", compared_breakdown = FALSE)$interest_by_region)
head(gtrends(keyword = c("nhl", "nba"), geo = "CA", compared_breakdown = TRUE)$interest_by_region)
}
}
