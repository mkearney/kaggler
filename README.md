
<!-- README.md is generated from README.Rmd. Please edit that file -->

# kaggle <img src="man/figures/logo.png" width="160px" align="right" />

🏁 API client for [Kaggle](https://www.kaggle.com)

## Installation

You can install the dev version of kaggle from
[CRAN](https://github.com/mkearney/kaggle) with:

``` r
## install kaggle package from github
devtools::install_packages("mkearney/kaggle")
```

## API authorization

1.  Go to [https://www.kaggle.com/](kaggle.com) and sign in

2.  Click `Account` or navigate to
    `https://www.kaggle.com/{username}/account`

3.  Scroll down to the `API` section and click `Create New API Token`
    (which should cause you to download a `kaggle.json` file with your
    username and API key)

4.  There are a few different ways to store your credentials
    
      - Save/move the `kaggle.json` file as `~/.kaggle/kaggle.json`
      - Save/move the `kaggle.json` file to your current working
        directory
      - Enter your `username` and `key` and use the `kaggle_auth()`
        function like in the example below

<!-- end list -->

``` r
kaggle_auth
#> Your Kaggle key has been recorded for this session and saved as `KAGGLE_PAT` environment variable for future sessions.
```

## `kaggle_competitions_list_.*()`

Browse or search for Kaggle compeitions.

``` r
## look through all competitions (paginated)
comps1 <- kaggle_competitions_list()
comps1 
#> # A tibble: 20 x 23
#>    ref    description     id title  url   deadline category reward organizationName organizationRef
#>  * <chr>  <chr>        <int> <chr>  <chr> <chr>    <chr>    <chr>  <chr>            <chr>          
#>  1 house… Predict sal…  5407 House… http… 2030-01… Getting… Knowl… Kaggle           kaggle         
#>  2 digit… Learn compu…  3004 Digit… http… 2030-01… Getting… Knowl… Kaggle           kaggle         
#>  3 titan… Start here!…  3136 Titan… http… 2030-01… Getting… Knowl… Kaggle           kaggle         
#>  4 image… Identify an…  6796 Image… http… 2029-12… Research Knowl… ImageNet         image-net      
#>  5 image… Identify an…  6800 Image… http… 2029-12… Research Knowl… ImageNet         image-net      
#>  6 image… Identify th…  6799 Image… http… 2029-12… Research Knowl… ImageNet         image-net      
#>  7 compe… "Final proj…  8587 Predi… http… 2019-01… Playgro… Kudos  <NA>             <NA>           
#>  8 flavo… Identify a … 10014 Flavo… http… 2018-09… Playgro… Knowl… <NA>             <NA>           
#>  9 fores… Use cartogr…  9985 Fores… http… 2018-09… Playgro… Knowl… Kaggle           kaggle         
#> 10 whats… Use recipe … 10012 What'… http… 2018-09… Playgro… Knowl… Kaggle           kaggle         
#> # ... with 10 more rows, and 13 more variables: kernelCount <int>, teamCount <int>,
#> #   userHasEntered <lgl>, userRank <lgl>, mergerDeadline <chr>, newEntrantDeadline <chr>,
#> #   enabledDate <chr>, maxDailySubmissions <int>, maxTeamSize <int>, evaluationMetric <chr>,
#> #   awardsPoints <lgl>, isKernelsSubmissionsOnly <lgl>, submissionsDisabled <lgl>

## it's paginated, so to see page two:
comps2 <- kaggle_competitions_list(page = 2)
comps2
#> # A tibble: 20 x 23
#>    ref    description     id title  url   deadline category reward organizationName organizationRef
#>  * <chr>  <chr>        <int> <chr>  <chr> <chr>    <chr>    <chr>  <chr>            <chr>          
#>  1 cvpr-… Can you seg…  8899 CVPR … http… 2018-06… Research $2,500 CVPR 2018 WAD    cvpr-wad       
#>  2 inatu… Long tailed…  8243 " iNa… http… 2018-06… Research Kudos  <NA>             <NA>           
#>  3 imate… Image class…  8219 iMate… http… 2018-05… Research $2,500 <NA>             <NA>           
#>  4 imate… Image Class…  8220 iMate… http… 2018-05… Research $2,500 <NA>             <NA>           
#>  5 landm… Given an im…  8396 Googl… http… 2018-05… Research $2,500 Google           google         
#>  6 landm… Label famou…  7456 Googl… http… 2018-05… Research $2,500 Google           google         
#>  7 talki… Can you det…  8540 Talki… http… 2018-05… Featured $25,0… TalkingData      talkingdata    
#>  8 donor… Predict whe…  8426 Donor… http… 2018-04… Playgro… Swag   DonorsChoose.org donorschoose   
#>  9 data-… Find the nu…  8089 "2018… http… 2018-04… Featured $100,… Booz Allen Hami… BoozAllenHamil…
#> 10 mens-… Apply Machi…  8310 Googl… http… 2018-04… Featured $50,0… Google Cloud     google-cloud   
#> # ... with 10 more rows, and 13 more variables: kernelCount <int>, teamCount <int>,
#> #   userHasEntered <lgl>, userRank <lgl>, mergerDeadline <chr>, newEntrantDeadline <chr>,
#> #   enabledDate <chr>, maxDailySubmissions <int>, maxTeamSize <lgl>, evaluationMetric <chr>,
#> #   awardsPoints <lgl>, isKernelsSubmissionsOnly <lgl>, submissionsDisabled <lgl>

## search by keyword for competitions
imagecomps <- kaggle_competitions_list(search = "image")
imagecomps
#> # A tibble: 3 x 23
#>   ref    description      id title url    deadline category reward organizationName organizationRef
#> * <chr>  <chr>         <int> <chr> <chr>  <chr>    <chr>    <chr>  <chr>            <chr>          
#> 1 drape… "Can you put…  5229 Drap… https… 2016-06… Featured $75,0… <NA>             <NA>           
#> 2 carva… Automaticall…  6927 Carv… https… 2017-09… Featured $25,0… Carvana          carvana        
#> 3 cdisc… Categorize e…  7115 Cdis… https… 2017-12… Featured $35,0… Cdiscount        cdiscount      
#> # ... with 13 more variables: kernelCount <int>, teamCount <int>, userHasEntered <lgl>,
#> #   userRank <lgl>, mergerDeadline <chr>, newEntrantDeadline <chr>, enabledDate <chr>,
#> #   maxDailySubmissions <int>, maxTeamSize <int>, evaluationMetric <chr>, awardsPoints <lgl>,
#> #   isKernelsSubmissionsOnly <lgl>, submissionsDisabled <lgl>
```

## `kaggle_competitions_data_.*()`

Look up the datalist for a given Kaggle competition. **IF you’ve already
accepted the competition rules, then you should be able to download the
dataset too (I haven’t gotten there yet to test it)**

``` r
## data list for a given competition
c1_datalist <- kaggle_competitions_data_list(comps1$id[1])
c1_datalist
#> # A tibble: 7 x 6
#>   ref                      description name                     totalBytes url         creationDate
#> * <chr>                    <lgl>       <chr>                         <int> <chr>       <chr>       
#> 1 data_description.txt     NA          data_description.txt          13370 https://ww… 2016-08-25T…
#> 2 train.csv.gz             NA          train.csv.gz                  91387 https://ww… 2016-08-29T…
#> 3 train.csv                NA          train.csv                    460676 https://ww… 2016-08-29T…
#> 4 test.csv.gz              NA          test.csv.gz                   83948 https://ww… 2016-08-29T…
#> 5 test.csv                 NA          test.csv                     451405 https://ww… 2016-08-29T…
#> 6 sample_submission.csv.gz NA          sample_submission.csv.gz      15685 https://ww… 2016-08-30T…
#> 7 sample_submission.csv    NA          sample_submission.csv         31939 https://ww… 2016-08-30T…

## download set sets (IF YOU HAVE ACCEPTED COMPETITION RULES)
c1_data <- kaggle_competitions_data_download(
  comps1$id[1], c1_datalist$name[1])
#> Warning in kaggle_api_get(glue::glue("competitions/data/download/{id}/{fileName}")): Forbidden (HTTP
#> 403).
#> You must accept this competition's rules before you can continue
```

## `kaggle_datasets_.*()`

Get a list of all of the datasets.

``` r
## get competitions data list
datasets <- kaggle_datasets_list()
datasets
#> # A tibble: 20 x 20
#>    ref     creatorName creatorUrl totalBytes url     lastUpdated downloadCount isPrivate isReviewed
#>  * <chr>   <chr>       <chr>           <int> <chr>   <chr>               <int> <lgl>     <lgl>     
#>  1 alxmam… Timo Bozso… timoboz     235781000 https:… 2018-06-28…          2638 FALSE     TRUE      
#>  2 passny… Chris Craw… crawford       167711 https:… 2018-06-26…          2661 FALSE     TRUE      
#>  3 open-p… Aleksey Bi… residentm…    9277520 https:… 2018-02-02…          1324 FALSE     TRUE      
#>  4 shruti… Shruti Meh… shrutimeh…    5732263 https:… 2018-03-13…          5746 FALSE     TRUE      
#>  5 abeckl… Andre Beck… abecklas       357590 https:… 2018-04-23…         11855 FALSE     TRUE      
#>  6 heesoo… Randi H Gr… heesoo37      5690692 https:… 2018-06-15…           550 FALSE     TRUE      
#>  7 yingwu… JifuZhao    yingwuren…  660000420 https:… 2018-02-26…           915 FALSE     TRUE      
#>  8 nicapo… Nick Brooks nicapotato    2924080 https:… 2018-02-03…          2969 FALSE     TRUE      
#>  9 slothk… Timo Bozso… timoboz     573619422 https:… 2018-06-28…          1585 FALSE     TRUE      
#> 10 ramame… Ramanathan  ramamet4      5904947 https:… 2018-06-10…           860 FALSE     TRUE      
#> # ... with 10 more rows, and 11 more variables: isFeatured <lgl>, licenseName <chr>,
#> #   description <chr>, ownerName <chr>, ownerRef <chr>, kernelCount <int>, title <chr>,
#> #   topicCount <int>, viewCount <int>, voteCount <int>, currentVersionNumber <int>
```

## `kaggle_competitions_leaderboard_.*()`

View the leaderboard for a given competition.

``` r
## get competitions data list
c1_leaderboard <- kaggle_competitions_leaderboard_view(comps1$id[1])
c1_leaderboard
#> # A tibble: 50 x 4
#>     teamId teamName             submissionDate               score  
#>  *   <int> <chr>                <chr>                        <chr>  
#>  1 1780632 GroundTruth          2018-06-14T06:59:25.1433333Z 0.00000
#>  2  439244 DSXL                 2018-05-26T15:30:35.25Z      0.06628
#>  3 1752010 chi7moveon           2018-06-05T01:28:52.66Z      0.10677
#>  4  365763 Paulo Pinto          2018-06-13T19:18:42.9966667Z 0.10910
#>  5 1363349 Dmitry Storozhenko   2018-06-12T04:34:11.0366667Z 0.10915
#>  6 1792427 LegenDaD             2018-07-07T10:15:24.59Z      0.10919
#>  7 1498491 Yinghui Jiang        2018-07-02T12:24:42.7066667Z 0.10928
#>  8 1424929 Aleksandrs Gehsbargs 2018-06-17T00:30:41.17Z      0.10943
#>  9 1162377 hanxiaoyang          2018-06-30T14:31:07.84Z      0.10964
#> 10 1851064 dines_1997           2018-07-06T19:57:58.4433333Z 0.10982
#> # ... with 40 more rows
```

## Note(s)

  - The author is in no way affiliated with Kaggle.com, and, as such,
    makes no assurances that there won’t be breaking changes to the API
    at any time.

  - Although I am not affiliated, it’s good practice to be informed, so
    here is the link to Kaggle’s terms of service:
    <https://www.kaggle.com/terms>
