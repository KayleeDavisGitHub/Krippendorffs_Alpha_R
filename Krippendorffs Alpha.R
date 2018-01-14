####
##
## Tutorial on Krippendorff's Alpha: by Kyle Davis
## Ohio State University
##
## Be sure to cite the creators article:
##   Hayes, A. F., & Krippendorff, K. (2007).
##   Answering the call for a standard reliability measure for coding data.
##   Communication Methods and Measures, 1, 77-89.
##
##   Krippendorff, K. (1980). Content analysis: An introduction to its methodology. Beverly Hills, CA: Sage
##
## And the R: Package's Creator:
##   Jim Lemon, found here: https://cran.r-project.org/web/packages/irr/irr.pdf
##
####

# install.packages("irr")
library(irr)

# the "C" data from Krippendorff
nmm <- matrix(c(1,1,NA,1,2,2,3,2,3,3,3,3,3,3,3,3,2,2,2,2,1,2,3,4,4,4,4,4,
                1,1,2,1,2,2,2,2,NA,5,5,5,NA,NA,1,1,NA,NA,3,NA), nrow=4)
nmm
# Here we have 4 coders (rows), and 12 data, with some NA's
# One of the benefits of Krippendorff's Alpha is it's ability to work through missing data

# first assume the default nominal classification
kripp.alpha(nmm)

# now use the same data with the other three methods:
kripp.alpha(nmm,"ordinal")
kripp.alpha(nmm,"interval")
kripp.alpha(nmm,"ratio")

# Some cool options here:
alpha <- kripp.alpha(nmm)

# See the basic stats:
alpha$method    # Krippendorf's Alpha (irr can calculate other reliability measures)
alpha$subjects  # n subjects
alpha$raters    # n raters
alpha$irr.name  # alpha
alpha$value     # the sum value

# and the components used in the calculation itself:
alpha$cm        # concordance/discordance matrix used in the calculation of alpha
alpha$data.values # all unique data values
alpha$nmatchval # number of matches used in Krippendorff calculation


## Then you can use your favorite bootstrapping function to account for errors:
# Empty matrix, enter blank template
results <- matrix(nrow = 1000, ncol = 1)

for (i in 1:1000)
{
     data <- nmm # swap this out for your data
     results[i] <- kripp.alpha(data)$value
}

head(results)

##
##  These testing data give the same result, so plotting the bootstrap is unintuitive
##

quantile(results,  probs = c(.1, .5, .9))

library(ggplot2)
p1 <- qplot(results)+
     geom_vline(xintercept = , col="Red")+
     geom_vline(xintercept = , col="Red")+
     ggtitle("1000 Bootstrapped Simulated Results")+
     xlab(" Results ")+
     theme_bw()