# ![A Week of R at UNL](figure/header.png)

- [<span class="toc-section-number">1</span> January 2024 - A Week of
  R](#january-2024---a-week-of-r)
  - [<span class="toc-section-number">1.1</span> Schedule](#schedule)
  - [<span class="toc-section-number">1.2</span> Pricing](#pricing)
  - [<span class="toc-section-number">1.3</span> Sign Up](#sign-up)
- [<span class="toc-section-number">2</span> Learning
  Outcomes](#learning-outcomes)
- [<span class="toc-section-number">3</span> Computer Setup](#sec-setup)

# January 2024 - A Week of R

The schedule listed below is for the next set of workshops. Workshops
are typically offered just before the classes start in the Spring as
well as the week after Spring finals. We anticipate that these classes
will be offered in person, with no online option.

## Schedule

**Schedule is tentative and subject to change due to enrollment and lab
availability**

- Location: Hardin 163 (North wing)
- Required materials: Laptop with [software installed](@sec-setup)

Register for the workshops [here](https://forms.gle/Lj9DfWFoySMRytUP8).

We will send you an email about a week before the workshops are held
with additional details.

| Date   |   Time    | Course                                                                                             | Description                                                                                                                                                                                                                                                                                                                                                                                                                               |
|--------|:---------:|----------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Jan 15 |           |                                                                                                    | Martin Luther King, Jr. Day                                                                                                                                                                                                                                                                                                                                                                                                               |
| Jan 16 | 9am - 4pm | [Introduction to R](r-intro/index.html)                                                            | Learn the basics of R & Rstudio, how to write your own R scripts and get an introduction to the tidyverse. We’ll start with the beginning and quickly get you up to speed with the basic tools of data exploration. You will learn how to import and manage data sets, create R objects, install and load R packages, and how to ask for help in R.                                                                                       |
| Jan 17 | 9am - 4pm | [Graphics with `ggplot2`](r-graphics/index.html)                                                   | `ggplot2` provides a framework to produce elegant, high-end graphical displays using the Grammar of Graphics. You will learn how to create a wide variety of graphical displays in R. We will use lots of data examples to wok through the basic plots as well as more advanced tools, such as facetting, colors, themes and more.                                                                                                        |
| Jan 18 | 9am - 4pm | [Data Wrangling](r-format/index.html)                                                              | This workshop will to prepare you for dealing with messy data by walking you through real-life examples. We will help you to automate cleaning your data, fixing spelling errors, transforming variables, and generating data summaries using the split-apply-combine paradigm. We will also talk about wide and long format data and help you to convert between these formats and to know when each format is useful.                   |
| Jan 19 | 9am - 4pm | [Statistical Modeling in R](https://unl-statistics.github.io/R-workshops/06-r-modeling/index.html) | Learn how to fit models, test hypotheses, create model output tables and plots, and more! In the morning, we will cover model-fitting basics (linear regression, mixed models), and in the afternoon we will look into more advanced types of models (generalized linear mixed models, etc.). <br/> The last part of this session is designed as a workshop, so bring your data to analyze (we will have some data sets if you need one!) |

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
about 1 week before the workshops are scheduled to see if scholarships
are available. Include how much you can afford to pay, why you need the
workshops, and any other details you think are relevant. Scholarships
will depend on the number of registered participants. We charge just
enough to ensure that the instructors are paid for their time and
effort - most semesters, we barely break even.

Note that half-day workshops are those which are only offered from
e.g. 9-12 or 1-4. We do not allow you to register and pay for only half
of a full-day workshop.

## Sign Up

[Register here](https://forms.gle/Lj9DfWFoySMRytUP8)

# Learning Outcomes

After the end of the this one week course, we expect you to be able to
do the following:

> [!TIP]
>
> ### Introduction to R
>
> - Use R for scientific/statistical calculations
> - Be able to create or read in data
> - Be able to manipulate data using common patterns
> - Explore data set characteristics and calculate summary statistics
>   for real data sets
> - Use the help functionality to find the functions you need to do what
>   you want to do
> - Install, use, and search for helpful external packages

> [!TIP]
>
> ### Graphics with `ggplot2`
>
> - Visualize data using the ggplot2 package
>   - create basic plots
>   - understand the layer system
>   - be able to structure complex graphics
> - Take a dataset and use static graphics to look for interesting
>   features.
> - Know about some aspects of human perception and what to avoid when
>   plotting data.

> [!TIP]
>
> ### Data Wrangling
>
> - Read data into R from different formats
> - Investigate and work with different types of objects
> - Use `dplyr` verbs such as summarize, group_by, mutate, filter, and
>   select to modify and summarize data
> - Use `tidyr` to convert data to wide and long formats, join related
>   data sets, and clean messy data

> [!TIP]
>
> ### Statistical Modeling
>
> - Fit linear and mixed models
> - Create model summary output tables and plots
> - Fit generalized additive models and generalized linear mixed models

# Computer Setup

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
