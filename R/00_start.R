## ADD DOCUMENTATION TO YOUR PROJECT ----

## Add meta data about your project to DESCRIPTION
d6::fill_desc(
  pkg_title = "PVA of the Northern Bald Ibis",         ## The Full Title of the Project
  pkg_description = "Analysis of the survival, fecundity and population viability of reintroduced Northern Bald Ibises in Germany and Austria",   ## The Description of Your Project
  author_first_name = "Sinah", ## Your First Name
  author_last_name = "Drenske",  ## Your Last Name
  author_email = "sinah.drenske@campus.tu-berlin.de",      ## Your Email
  repo_url = "https://github.com/SinahDre/Drenske_2020_PVA_NBI"         ## The URL of the GitHub Repo (optional)
)

## Add and fill the readme
usethis::use_readme_md()

## Add license if needed
## See ?usethis::use_mit_license for more information
usethis::use_mit_license( name = "Sinah Drenske" )
# Name = name of the copyright holder(s)

## ADD PACKAGE DEPENDENCIES ----

## Add one line by package you want to add as dependency
usethis::use_package("tidyverse", type = "depends")
