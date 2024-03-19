# https://downloads.ceicdata.com/R/documentation/CEIC+R+Package+-+Quick+Start+Guide.pdf
# API portal
# https://developer.isimarkets.com/en/CEIC/Documentation/ShowMethod?pathKey=GET%20%2Fseries%2Fsearch&queryStringParams=%26keyword%3DGDP%26status%3DT,C,B%26alternative%3DhighFrequency%26lang%3Den
# https request
# https://api.ceicdata.com/v2/series/search?keyword=GDP&status=T,C,B&alternative=highFrequency&lang=en&token=<TOKEN>

library("ceic")
# Warning messages:
#   1: replacing previous import ‘curl::handle_reset’ by ‘httr::handle_reset’ when loading ‘ceic’
# 2: In fun(libname, pkgname) :
#   couldn't connect to display "/private/tmp/com.apple.launchd.gR5prctPds/org.xquartz:0"
ceic.login()
# Error in file(file, ifelse(append, "a", "w")) :
#   cannot open the connection
# In addition: Warning message:
#   In file(file, ifelse(append, "a", "w")) :
#   cannot open file '/Users/johngavin/R/ceicsession.xml': No such file or directory

ceic.search(keyword = "GDP",
  status = c("T", "C", "B"),
  alternative = c("highFrequency"),
  lang = "en")
ceic.series()
ceic.timepoints() # data
ceic.metadata() #  metadata
ceic.update() #  updates

# hosts: https://api.ceicdata.com/v2
# Open port 443
# Powerful search through CEIC data time series
# + Time-points and metadata extraction
# + Time series location references (layout tree replication)
# + Full insights document retrieval
# + Footnotes document retrieval
# + Dictionary reference resources
# + CDMNext UI for managing R package access and generating R calls
# + ZOO and TS output formats
# + Data feed ability – retrieve and compare data time point changes


install.packages ("ceic",
  repos = "https://downloads.ceicdata.com/R/",
  type = "source")

library(dplyr)
deps <- c("xml2", "R6", "zoo", "httr", "getPass")
# install.packages(deps, dependencies = TRUE)
deps |>
  sapply(library, character.only = TRUE) |>
  invisible()
