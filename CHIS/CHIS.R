library(ggplot2)
library(foreign)

#unable to load the CHIS2009_reduced_2 data. Unknown filetype. Tried using sas, csv, xlsx.

# The initial contingency table
# Load age and bmi into a data frame
DF <- as.data.frame.matrix(table(adult$SRAGE_P, adult$RBMI))

# Add the columns groupsSum, xmax and xmin. Remove groupSum again.
# Perform calculations. Get the group sup by summing the rows. Max is calculated by getting cumulative sum of the group. To get min, subtract the groupsum from the max.
DF$groupSum <- rowSums(DF)
DF$xmax <- cumsum(DF$groupSum)
DF$xmin <- DF$xmax - DF$groupSum

# The groupSum column needs to be removed, don't remove this line. 
# Only used for calculations above.
DF$groupSum <- NULL

# Copy row names to variable X
DF$X <- row.names(DF)

# Melt the dataset
library(reshape2)
DF_melted <- melt(DF, id.vars = c("X", "xmin", "xmax"), variable.name = "FILL")

# dplyr call to calculate ymin and ymax - don't change
library(dplyr)
DF_melted <- DF_melted %>%
  group_by(X) %>%
  mutate(ymax = cumsum(value/sum(value)),
         ymin = ymax - value/sum(value))

# Plot rectangles - don't change.
# Plot df_melted from above and use the respective min and maxs to create rectangles. Fill is determined through theme_tufte. OUtline of rectangles is white. 
# Scale is continous which cause rectangle to fill to top of chart.
library(ggthemes)
ggplot(DF_melted, aes(ymin = ymin,
                      ymax = ymax,
                      xmin = xmin,
                      xmax = xmax,
                      fill = FILL)) +
  geom_rect(colour = "white") +
  scale_x_continuous(expand = c(0,0)) +
  scale_y_continuous(expand = c(0,0)) +
  BMI_fill +
  theme_tufte()