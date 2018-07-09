
<!-- README.md is generated from README.Rmd. Please edit that file -->

# kaggler <img src="man/figures/logo.png" width="160px" align="right" />

> 🏁 An R client for accessing [Kaggle](https://www.kaggle.com)’s API

## Installation

You can install the dev version of kaggler from
[CRAN](https://github.com/mkearney/kaggler) with:

``` r
## install kaggler package from github
devtools::install_packages("mkearney/kaggler")
```

## API authorization

<span>1.</span> Go to [https://www.kaggle.com/](kaggle.com) and sign in

<span>2.</span> Click `Account` or navigate to
`https://www.kaggle.com/{username}/account`

<span>3.</span> Scroll down to the `API` section and click `Create New
API Token` (which should cause you to download a `kaggle.json` file with
your username and API key)

<p style="align:center">

<img src='tools/readme/kag.png' />

</p>

<span>4.</span> There are a few different ways to store your credentials

  - Save/move the `kaggle.json` file as `~/.kaggle/kaggle.json`
  - Save/move the `kaggle.json` file to your current working directory
  - Enter your `username` and `key` and use the `kgl_auth()` function
    like in the example
below

<!-- end list -->

``` r
kgl_auth(username = "mkearney", key = "9as87f6faf9a8sfd76a9fsd89asdf6dsa9f8")
#> Your Kaggle key has been recorded for this session and saved as `KAGGLE_PAT` environment variable for future sessions.
```

## `kgl_competitions_list_.*()`

Browse or search for Kaggle compeitions.

``` r
## look through all competitions (paginated)
comps1 <- kgl_competitions_list()
comps1
#> # A tibble: 20 x 23
#>   ref     description       id title   url     deadline            category reward organizationName
#> * <chr>   <chr>          <int> <chr>   <chr>   <dttm>              <chr>    <chr>  <chr>           
#> 1 house-~ Predict sales~  5407 House ~ https:~ 2030-01-01 00:00:00 Getting~ Knowl~ Kaggle          
#> 2 digit-~ Learn compute~  3004 Digit ~ https:~ 2030-01-01 00:00:00 Getting~ Knowl~ Kaggle          
#> 3 titanic Start here! P~  3136 Titani~ https:~ 2030-01-01 00:00:00 Getting~ Knowl~ Kaggle          
#> 4 imagen~ Identify and ~  6796 ImageN~ https:~ 2029-12-31 07:00:00 Research Knowl~ ImageNet        
#> 5 imagen~ Identify and ~  6800 ImageN~ https:~ 2029-12-31 07:00:00 Research Knowl~ ImageNet        
#> # ... with 15 more rows, and 14 more variables: organizationRef <chr>, kernelCount <int>,
#> #   teamCount <int>, userHasEntered <lgl>, userRank <lgl>, mergerDeadline <dttm>,
#> #   newEntrantDeadline <dttm>, enabledDate <dttm>, maxDailySubmissions <int>, maxTeamSize <int>,
#> #   evaluationMetric <chr>, awardsPoints <lgl>, isKernelsSubmissionsOnly <lgl>,
#> #   submissionsDisabled <lgl>

## it's paginated, so to see page two:
comps2 <- kgl_competitions_list(page = 2)
comps2
#> # A tibble: 20 x 23
#>   ref     description       id title   url     deadline            category reward organizationName
#> * <chr>   <chr>          <int> <chr>   <chr>   <dttm>              <chr>    <chr>  <chr>           
#> 1 cvpr-2~ Can you segme~  8899 CVPR 2~ https:~ 2018-06-11 23:59:00 Research $2,500 CVPR 2018 WAD   
#> 2 inatur~ Long tailed c~  8243 " iNat~ https:~ 2018-06-04 23:59:00 Research Kudos  <NA>            
#> 3 imater~ Image classif~  8219 iMater~ https:~ 2018-05-30 23:59:00 Research $2,500 <NA>            
#> 4 imater~ Image Classif~  8220 iMater~ https:~ 2018-05-30 23:59:00 Research $2,500 <NA>            
#> 5 landma~ Given an imag~  8396 Google~ https:~ 2018-05-29 23:59:00 Research $2,500 Google          
#> # ... with 15 more rows, and 14 more variables: organizationRef <chr>, kernelCount <int>,
#> #   teamCount <int>, userHasEntered <lgl>, userRank <lgl>, mergerDeadline <dttm>,
#> #   newEntrantDeadline <dttm>, enabledDate <dttm>, maxDailySubmissions <int>, maxTeamSize <lgl>,
#> #   evaluationMetric <chr>, awardsPoints <lgl>, isKernelsSubmissionsOnly <lgl>,
#> #   submissionsDisabled <lgl>

## search by keyword for competitions
imagecomps <- kgl_competitions_list(search = "image")
imagecomps
#> # A tibble: 3 x 23
#>   ref     description       id title   url     deadline            category reward organizationName
#> * <chr>   <chr>          <int> <chr>   <chr>   <dttm>              <chr>    <chr>  <chr>           
#> 1 draper~ "Can you put ~  5229 Draper~ https:~ 2016-06-27 23:59:00 Featured $75,0~ <NA>            
#> 2 carvan~ Automatically~  6927 Carvan~ https:~ 2017-09-27 23:59:00 Featured $25,0~ Carvana         
#> 3 cdisco~ Categorize e-~  7115 "Cdisc~ https:~ 2017-12-14 23:59:00 Featured $35,0~ Cdiscount       
#> # ... with 14 more variables: organizationRef <chr>, kernelCount <int>, teamCount <int>,
#> #   userHasEntered <lgl>, userRank <lgl>, mergerDeadline <dttm>, newEntrantDeadline <dttm>,
#> #   enabledDate <dttm>, maxDailySubmissions <int>, maxTeamSize <int>, evaluationMetric <chr>,
#> #   awardsPoints <lgl>, isKernelsSubmissionsOnly <lgl>, submissionsDisabled <lgl>
```

## `kgl_competitions_data_.*()`

Look up the datalist for a given Kaggle competition. **IF you’ve already
accepted the competition rules, then you should be able to download the
dataset too (I haven’t gotten there yet to test it)**

``` r
## data list for a given competition
c1_datalist <- kgl_competitions_data_list(comps1$id[1])
c1_datalist
#> # A tibble: 7 x 6
#>   ref                  description name                 totalBytes url          creationDate       
#> * <chr>                <lgl>       <chr>                     <int> <chr>        <dttm>             
#> 1 data_description.txt NA          data_description.txt      13370 https://www~ 2016-08-25 20:29:24
#> 2 train.csv.gz         NA          train.csv.gz              91387 https://www~ 2016-08-29 20:43:35
#> 3 train.csv            NA          train.csv                460676 https://www~ 2016-08-29 20:43:54
#> 4 test.csv.gz          NA          test.csv.gz               83948 https://www~ 2016-08-29 20:44:10
#> 5 test.csv             NA          test.csv                 451405 https://www~ 2016-08-29 20:44:14
#> # ... with 2 more rows

## download set sets (IF YOU HAVE ACCEPTED COMPETITION RULES)
c1_data <- kgl_competitions_data_download(
  comps1$id[1], c1_datalist$name[1])
#> Warning in kgl_api_get(glue::glue("competitions/data/download/{id}/{fileName}")): Forbidden (HTTP
#> 403).
#> You must accept this competition's rules before you can continue
```

## `kgl_datasets_.*()`

Get a list of all of the datasets.

``` r
## get competitions data list
datasets <- kgl_datasets_list()
datasets
#> # A tibble: 20 x 20
#>   ref       creatorName creatorUrl totalBytes url       lastUpdated         downloadCount isPrivate
#> * <chr>     <chr>       <chr>           <int> <chr>     <dttm>                      <int> <lgl>    
#> 1 passnyc/~ Chris Craw~ crawford       167711 https://~ NA                           2789 FALSE    
#> 2 ramamet4~ Ramanathan  ramamet4      5904947 https://~ NA                            955 FALSE    
#> 3 shrutime~ Shruti Meh~ shrutimeh~    5732263 https://~ NA                           5934 FALSE    
#> 4 heesoo37~ Randi H Gr~ heesoo37      5690692 https://~ NA                            655 FALSE    
#> 5 abecklas~ Andre Beck~ abecklas       357590 https://~ NA                          12143 FALSE    
#> # ... with 15 more rows, and 12 more variables: isReviewed <lgl>, isFeatured <lgl>,
#> #   licenseName <chr>, description <chr>, ownerName <chr>, ownerRef <chr>, kernelCount <int>,
#> #   title <chr>, topicCount <int>, viewCount <int>, voteCount <int>, currentVersionNumber <int>
```

## `kgl_competitions_leaderboard_.*()`

View the leaderboard for a given competition.

``` r
## get competitions data list
c1_leaderboard <- kgl_competitions_leaderboard_view(comps1$id[1])
c1_leaderboard
#> # A tibble: 50 x 4
#>    teamId teamName           submissionDate      score  
#> *   <int> <chr>              <dttm>              <chr>  
#> 1 1780632 GroundTruth        NA                  0.00000
#> 2  439244 DSXL               NA                  0.06628
#> 3 1752010 chi7moveon         NA                  0.10677
#> 4  365763 Paulo Pinto        NA                  0.10910
#> 5 1363349 Dmitry Storozhenko NA                  0.10915
#> # ... with 45 more rows
```

## Note(s)

  - The author is in no way affiliated with Kaggle.com, and, as such,
    makes no assurances that there won’t be breaking changes to the API
    at any time.

  - Although I am not affiliated, it’s good practice to be informed, so
    here is the link to Kaggle’s terms of service:
    <https://www.kaggle.com/terms>
