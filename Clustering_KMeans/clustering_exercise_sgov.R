# This mini-project is based on the K-Means exercise from 'R in Action'
# Go here for the original blog post and solutions
# http://www.r-bloggers.com/k-means-clustering-from-r-in-action/

# Exercise 0: Install these packages if you don't have them already

install.packages(c("cluster", "rattle.data","NbClust"))

# Now load the data and look at the first few rows
data(wine, package="rattle.data")
head(wine)

# Exercise 1: Remove the first column from the data and scale
# it using the scale() function

wine$Type <- NULL
scale(wine)


# Now we'd like to cluster the data using K-Means. 
# How do we decide how many clusters to use if you don't know that already?
# We'll try two methods.

# Method 1: A plot of the total within-groups sums of squares against the 
# number of clusters in a K-means solution can be helpful. A bend in the 
# graph can suggest the appropriate number of clusters. 

wssplot <- function(data, nc=15, seed=1234){
	              wss <- (nrow(wine)-1)*sum(apply(wine,2,var))
               	      for (i in 2:nc){
		        set.seed(seed)
               	        print(i)
	                wss[i] <- sum(kmeans(wine, centers=i)$withinss)}
	              print(wss[i])
	                
		      plot(1:nc, wss, type="b", xlab="Number of Clusters",
	                        ylab="Within groups sum of squares")
	   }

wssplot(df)

# Exercise 2:
#   * How many clusters does this method suggest?
####Answer
#2 clusters

#   * Why does this method work? What's the intuition behind it?
####Answer
#The graph shows how closely related clusters are given the number of groups. 
#For example the 8 cluster group isn't as simliar as a whole as the 4 cluster group. 
#Thus the 2 cluster group has the most similiarities within the group before combining to one.


#   * Look at the code for wssplot() and figure out how it works
####Answer
#Seed is set to 1234 which randomizing the data in this pattern. 
#The data is initially split into 15 clusters and clustered together using k-cluster. 
#Each cluster is plotted onto the graph against their within group difference value.




# Method 2: Use the NbClust library, which runs many experiments
# and gives a distribution of potential number of clusters.


library(NbClust)
set.seed(1234)
nc <- NbClust(wine, min.nc=2, max.nc=15, method="kmeans")
barplot(table(nc$Best.n[1,]),
	          xlab="Numer of Clusters", ylab="Number of Criteria",
		            main="Number of Clusters Chosen by 26 Criteria")


# Exercise 3: How many clusters does this method suggest?
#2 Clusters

# Exercise 4: Once you've picked the number of clusters, run k-means 
# using this number of clusters. Output the result of calling kmeans()
# into a variable fit.km

fit.km <- kmeans(wine, centers = 2)

# Now we want to evaluate how well this clustering does.

# Exercise 5: using the table() function, show how the clusters in fit.km$clusters
# compares to the actual wine types in wine$Type. Would you consider this a good
# clustering?

table(fit.km$cluster, wine$Type)
#This is not good clustering since it is not possilbe to predict group 3. In this version, 47 were predicted to be 2 when actually it should have been three.


# Exercise 6:
# * Visualize these clusters using  function clusplot() from the cluster library
# * Would you consider this a good clustering?
library(cluster)
clusplot(wine, fit.km$cluster)

#No since it seems like there could be three groups: Lower left, upper middle, lower right.