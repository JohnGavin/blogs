# https://downloads.ceicdata.com/R/documentation/CEIC+R+Package+-+Quick+Start+Guide.pdf
# API portal
# https://developer.isimarkets.com/en/CEIC/Documentation/ShowMethod?pathKey=GET%20%2Fseries%2Fsearch&queryStringParams=%26keyword%3DGDP%26status%3DT,C,B%26alternative%3DhighFrequency%26lang%3Den
# https request
# https://api.ceicdata.com/v2/series/search?keyword=GDP&status=T,C,B&alternative=highFrequency&lang=en&token=<TOKEN>

c("ceic", "dplyr", "fs", "glue", "stringr") |>
  sapply(library, character.only = TRUE) |>
  invisible()
# ceic requires tmp folder ('R') in ~
dir_ceic <- '~/R'
fs::dir_create(dir_ceic)
on.exit(fs::dir_delete(dir_ceic))
ceic.login(
  username = Sys.getenv('CEIC_userid'),
  password = Sys.getenv('CEIC_password'))
getOption("ceic.lang") |>
  identical('en') |>
  stopifnot('filter results to en only' = _)

# https://support.ceicdata.com/support/solutions/articles/1000264211-how-to-build-the-ceic-layout-tree-through-the-ceic-r-package
# database -> topic==country -> section==ts set ->
#   series==ts
subscribed <- function(df){
  df |>
  tibble() |>
  filter(subscribed == 'true') |>
  select(-subscribed) |>
  mutate(seriesCount = as.integer(seriesCount)) |>
  arrange(desc(seriesCount))
}
dbs <- ceic.layout.databases() |> subscribed()
dbs
ceic.regions()
# country codes
ceic.geo() |> # accepted geo IDs.
  as_tibble() ->
  ceic_geo
ceic_geo |> pull(name) |> table() |> sort(decreasing = TRUE)
ceic_geo |>
  filter(
    name # title
    |> tolower() |> str_detect(
      c('country', 'province', 'china|asia')[1])
  ) # |> View()
# ID, name, source, in subscription
# ' AND ' ';' (XOR) ' NOT '
# TODO: all topics are countries?
topics <- ceic.layout.topics("GLOBAL") |>
  seriesCount_as_int()
sub_head <- function(df, n = 6){
  df |>

  head(n)
}
topics |> sub_head()
# topic id -> sections
sections <-
  ceic.layout.sections(topics_head$id[1]) |>
  seriesCount_as_int()
sections |> sub_head() |> pull(name)
?ceic.layout.tables
c('GDP')[1] |>
  ceic.search(
    status = c(Active = "T", Discontinued = "C", Rebased = "B")[1],
    frequency = "D,W,M,Q",
    data_source = c(orig_ceic = 'CEIC'),
    order = c(default = 'relevance',
      'popular', last_updated = 'updated',
      'new', 'unit', 'status', 'frequency',
      'percentage_change', 'source',
      'last_value', 'first_date', 'last_date')[1],
    start_date_before = '2020-01-01',
    end_date_after = Sys.Date() - lubridate::years(1),
    lang = "en") |>
  dplyr::as_tibble() ->
  search_gdp
# id -> metadata
list(210438802, 279311303, 279311403) |>
  ceic.metadata() |>
  as_tibble() |>
  glimpse()
ceic.series() # data + metadata
x1 = ceic.series(210438802)
str(x1)
title = glue(
  '{x1$metadata$name}; ',
  '{x1$metadata$frequency}; ',
  'Source: {x1$metadata$source}')
x1 |>
  zoo::plot.zoo(_$timepoints,
  xlab = 'Date',
  ylab = x1$metadata$unit,
  main = title)


ceic.timepoints(format = c('ts', 'zoo')[1]) # data
ceic.update() #  update existing objects

ceic.logout()

# hosts: https://api.ceicdata.com/v2 ----
# Open port 443

# Search CEIC data time series ----
# + Time-points and metadata extraction
# + Time series location references (layout tree replication)
# + Full insights document retrieval
# + Footnotes document retrieval
# + Dictionary reference resources
# + CDMNext UI for managing R package access and generating R calls
# + ZOO and TS output formats
# + Data feed ability – retrieve and compare data time point changes

# CEIC install ----
install.packages ("ceic",
  repos = "https://downloads.ceicdata.com/R/",
  type = "source")

library(dplyr)
deps <- c("xml2", "R6", "zoo", "httr", "getPass")
# install.packages(deps, dependencies = TRUE)
deps |>
  sapply(library, character.only = TRUE) |>
  invisible()
