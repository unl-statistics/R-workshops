
# ![A Week of R at UNL](header.png)

[Join our Google Group for updates and future course
announcements](mailto:R-at-UNL+subscribe@googlegroups.com?Subject=subscribe-github)

# R Workshops

The schedule listed below is for the next set of workshops. Workshops
are typically offered just before the classes start in the Spring as
well as the week after Spring finals. We anticipate that these classes
will be offered in person, with no online option.

## January 2023 - A Week of R

\*\* Schedule is tentative and subject to change due to enrollment and
lab availability \*\*

<!-- Workshops will be held in **Keim 214**.-->
<!-- Workshops will be held in Hardin 162 (North wing, basement). -->

Register for the workshops [here](https://forms.gle/7gS6phh6UHCcFLd1A).
We will send you an email about a week before the workshops are held
with additional details (location, what to expect, how to set up your
computer).

| Date   |   Time    | Course                                                                                             | Description                                                                                                                                                                                                                                                                                                                                                                                                                               |
|--------|:---------:|----------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Jan 16 |           |                                                                                                    | Martin Luther King, Jr. Day                                                                                                                                                                                                                                                                                                                                                                                                               |
| Jan 17 | 9am - 4pm | [Introduction to R](https://unl-statistics.github.io/R-workshops/01-r-intro/index.html)            | Learn the basics of R & Rstudio, how to write your own R scripts and get an introduction to the tidyverse. We’ll start with the beginning and quickly get you up to speed with the basic tools of data exploration. You will learn how to import and manage data sets, create R objects, install and load R packages, and how to ask for help in R.                                                                                       |
| Jan 18 | 9am - 4pm | [Graphics with `ggplot2`](https://unl-statistics.github.io/R-workshops/02-r-graphics/index.html)   | `ggplot2` provides a framework to produce elegant, high-end graphical displays using the Grammar of Graphics. You will learn how to create a wide variety of graphical displays in R. We will use lots of data examples to wok through the basic plots as well as more advanced tools, such as facetting, colors, themes and more.                                                                                                        |
| Jan 19 | 9am - 4pm | [Data Wrangling](https://unl-statistics.github.io/R-workshops/03-r-format/index.html)              | This workshop will to prepare you for dealing with messy data by walking you through real-life examples. We will help you to automate cleaning your data, fixing spelling errors, transforming variables, and generating data summaries using the split-apply-combine paradigm. We will also talk about wide and long format data and help you to convert between these formats and to know when each format is useful.                   |
| Jan 20 | 9am - 4pm | [Statistical Modeling in R](https://unl-statistics.github.io/R-workshops/06-r-modeling/index.html) | Learn how to fit models, test hypotheses, create model output tables and plots, and more! In the morning, we will cover model-fitting basics (linear regression, mixed models), and in the afternoon we will look into more advanced types of models (generalized linear mixed models, etc.). <br/> The last part of this session is designed as a workshop, so bring your data to analyze (we will have some data sets if you need one!) |

## Learning Outcomes

After the end of the this one week course, we expect you to be able to
do the following:

<div>

> **Introduction to R**
>
> - Use R for scientific/statistical calculations
> - Be able to create or read in data
> - Be able to manipulate data using common patterns
> - Explore data set characteristics and calculate summary statistics
>   for real data sets
> - Use the help functionality to find the functions you need to do what
>   you want to do
> - Install, use, and search for helpful external packages

</div>

<div>

> **Graphics with `ggplot2`**
>
> - Visualize data using the ggplot2 package
>   - create basic plots
>   - understand the layer system
>   - be able to structure complex graphics
> - Take a dataset and use static graphics to look for interesting
>   features.
> - Know about some aspects of human perception and what to avoid when
>   plotting data.

</div>

<div>

> **Data Wrangling**
>
> - Read data into R from different formats
> - Investigate and work with different types of objects
> - Use `dplyr` verbs such as summarize, group_by, mutate, filter, and
>   select to modify and summarize data
> - Use `tidyr` to convert data to wide and long formats, join related
>   data sets, and clean messy data

</div>

<div>

> **Statistical Modeling**
>
> - Fit linear and mixed models
> - Create model summary output tables and plots
> - Fit generalized additive models and generalized linear mixed models

</div>

<div>

> **Dynamic Documents with <code>knitr</code> and
> <code>rmarkdown</code>**
>
> - Create documents that incorporate R code, R output, and text
> - Write documents using markdown or LaTeX
> - Use templates to structure markdown output into pdf, html, and docx
>   formats
> - Create slides using markdown and/or LaTeX with R output

</div>

<div>

> **Web Scraping**
>
> - Understand the structure of HTML web pages (DOM, tags, attributes)
> - Use CSS and XPATH to navigate HTML pages and select HTML nodes
> - Extract data from HTML nodes
> - Use APIs and other programmatic methods of accessing web-based data

</div>

<div>

> **Shiny**
>
> - Design a user interface
> - Create R code to respond to interactive elements of the UI
> - Connect the user interface to reactive R code to create an
>   interactive applet

</div>

# Sign Up

[Register](https://forms.gle/qyq68vnZCUhfT8MU9)

## Pricing

These workshops are developed and hosted by graduate students in the
Statistics department at University of Nebraska-Lincoln, primarily to
assist UNL students and staff with developing R skills necessary for
research and data analysis. Individuals from outside the university are
welcome to participate. Proceeds from the workshops directly fund
graduate student activities.

| Workshop Type | Student | UNL Affiliate | Corporate |
|---------------|---------|---------------|-----------|
| Full Day      | \$40    | \$60          | \$200     |
| Half Day      | \$20    | \$30          | \$120     |
| Full Week     | \$120   | \$240         | \$800     |

We accept exact cash, checks, or a University cost object. We cannot
accept N-cards.

If you are anticipating registering more than 4 people who are **not UNL
Affiliates** as a group, please feel free to contact [Susan
Vanderplas](mailto:svanderplas2@unl.edu?subject=R%20Workshops%20Pricing)
for a group rate.

If you are an independent student (e.g. not part of a research lab), and
cannot afford the prices we’ve set, please contact [Susan
Vanderplas](mailto:svanderplas2@unl.edu?subject=R%20Workshops%20Pricing)
to see if scholarships are available.

# First Day Setup!

You will need to bring a laptop with the following software installed:

- [R](https://cloud.r-project.org/) (version 4.0.0 or greater)
- [RStudio](https://www.rstudio.com/products/rstudio/download/#download)
  (version 2021.09 or greater)
- Windows only:  
  [Rtools](https://cloud.r-project.org/bin/windows/Rtools/)
- In R, please run the following code:

``` r
# this may take a LONG time...
install.packages(c("knitr", "rmarkdown", "tidyverse", "rvest", "xml2", "tinytex", "lme4", "emmeans")) 

tinytex::install_tinytex()
```

You will need to make sure that you have sufficient permissions on your
machine to install R packages from CRAN. If you do not have admin access
to your own machine, please work with your administrator to ensure that
you can install R packages during the workshop if necessary, as this is
an important skill to learn.
