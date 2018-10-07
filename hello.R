#+ setup, include = FALSE, echo = FALSE
# ignore this part for now
knitr::opts_chunk$set(error = TRUE)
#'
#' # Zhian's quick introduction to R
#' 
#' date: 2018-10-07
#'
#' Here we will introduce the following concepts:
#' 
#' - packages
#' - getting help
#' - functions
#' - dynamic reports
#' - projects
#'
#' ## Part 1: Packages -----------------------------------
#'
#' R's base code is rich enough to do complex statistical analysis on its own,
#' but sometimes separate code is needed to run specialised procedures. This
#' code can be bundled up into a software package and distributed via CRAN (
#' the **C**entralised **R** **A**rchive **N**etwork). You can install packages
#' from CRAN by using the function `install.packages()` with a character vector
#' of the names of the packages you want to install:
#+ eval = FALSE
install.packages(c("rmarkdown", "here", "epiR"))

#' > **n.b.** you only need to do this once. 
#' 
#' When you install packages, they will be installed into a folder on your 
#' computer that is called your **Library**. You can write this library anywhere
#' on your computer. R will automatically choose a library for you, but if you
#' want details on setting up a custom library, you should read the following
#' article: <https://zkamvar.github.io/using-a-custom-library-in-r>.
#'
#' Once you have installed packages, you can load them by using the `library()`
#' function:

library("epiR")

#' These packages contain specialized functions that you can access by typing
#' `package::function()`. For example, if you wanted to use the `epi.2by2()` 
#' function from the epiR package to calculate the odds ratio that a group of
#' people got sick from eating fish, you would type:

sf <- data.frame(
  sick = c(0, 1, 1, 1, 0, 1, 0),
  fish = c(1, 0, 1, 1, 0, 1, 0)
)
epiR::epi.2by2(table(sick = sf$sick, fish = sf$fish))
 
#' R can be confusing sometimes, but luckily, all functions have an associated
#' manual page that you can access by typing a question mark (?) in front of any
#' function name. For example, if you wanted to know what the `epi.2by2()` 
#' function did, you would type:

?epiR::epi.2by2

#' The most important parts of the manual page are:
#'
#' 1. The arguments: this is the section that describes what arguments/parameters
#'    the function requires. 
#' 2. The examples (at the bottom): this is how you can figure out how any 
#'    function works. These will usually be short examples with built-in data
#'    sets showing common use-cases for the functions. You can copy and paste
#'    the code into your R console and use this to explore how the function works.
#'
#' ## Part 2: functions -----------------------------------
#' 
#' Functions are what makes R run. A function in R is like a recipe in a 
#' cookbook. Like any recipie, I should be able to move it around to different
#' kitchens and produce the exact same thing if I have the same ingredients.
#'
#' There are two parts to a function:
#' 
#' ### The arguments/parameters: 
#'
#' These are the basic ingredients to a function. For example, the first 
#' parameter for the `epiR::epi.2by2()` function is a two-by-two table of numbers.
#'
#' ### The body:
#' 
#' This is the instructions of how to combine or manipulate the ingredients to
#' create the product.
#'
#' ### An example
#'
#' As a simple example, we can create a function that will raise the power of
#' a number to a cube. 

cube <- function(x) {
  res <- x^3
  res
}

#' There is only one parameter, x, which should be a number. You can see that
#' the body of the function calculates x cubed, creates an object called res,
#' and returns res. Let's see how that works:

cube(3)
cube(1:5)

#' Great! One thing to notice, however is that functions are self-contained.
#' Any new variables that the function creates stay within the function itself.
#' For example, if we tried to access `res` or `x`, we would get an error:

res
x

#' One of the good things about functions is that we can use them to wrap around
#' more complex functions. For example, the `epiR::epi.2by2()` function above
#' needs a 2x2 table, which is created using the `table()` function. We can
#' save ourselves some typing by wrapping them both in a new function that takes
#' two arguments: our variable of interest and response:

my_2x2 <- function(var, sick) {
  the_table <- table(sick, var)
  epiR::epi.2by2(the_table)
}

my_2x2(var = sf$fish, sick = sf$sick)

#' This technique of writing functions will become handy when we need to perform
#' the same procedure over and over again. 
#'
#' ----------------------------------------------------------------------------
#'
#' ## Part 3: RMarkdown
#'
#' One thing that's great about R is the fact that there is a package that allows
#' you to write reports in R called RMarkdown. You can create a new RMarkdown
#' document by opening Rstudio, clicking on File > New File > R Markdown, add a 
#' title and then you can start working in the RMarkdown document. 
#' 
#' > n.b. This document can be converted to an RMarkdown document by running
#+ eval = FALSE

knitr::spin("hello.R", knit = FALSE)

#'
#' ## Part 4: Projects
#'
#' When you begin to work in R, it's a good idea to begin your organising 
#' before you do any code. This way, you can be sure that your code, your data,
#' and your outputs are all in different places. 
#' 
#' Unfortunately, computers are dumb. When we tell a computer to read in a data
#' set, we want it to know where to go. Combining Rstudio projects and the 
#' here package allows us to give the computer an anchor so that we can keep
#' our analyses nice and tidy.
#' 
#' During today's practical, we have set up folders and RMarkdown documents for 
#' you to use. Tomorrow, you will create your own RMarkdown documents, and the 
#' next day, you will create your own folder structure. Good luck!
