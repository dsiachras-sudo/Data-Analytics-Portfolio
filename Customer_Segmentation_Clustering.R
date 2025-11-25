# Project: Unsupervised Market Segmentation (Clustering)
# Purpose: Group data points into distinct clusters to identify trends 
# (e.g., High Spenders vs. Low Spenders) without predefined labels.

set.seed(123)

# 1. Generate Sample Data
# Simulating customer data: Normalized Income vs Spending Score
# Group 1: Lower income, lower spending
# Group 2: Higher income, higher spending
data_points <- rbind(matrix(rnorm(100, sd = 0.3), ncol = 2),
                     matrix(rnorm(100, mean = 1, sd = 0.3), ncol = 2))
colnames(data_points) <- c("Income_Normalized", "Spending_Score_Normalized")

# 2. Elbow Method (Finding Optimal K)
# We run K-means for k=1 to k=15 to find where the error drops significantly
wss <- numeric(15)
for (i in 1:15) {
  wss[i] <- sum(kmeans(data_points, centers = i)$withinss)
}

# Optional: Visualize the Elbow plot to pick K
# plot(1:15, wss, type="b", xlab="Number of Clusters", ylab="Total Error")

# 3. Run K-Means Clustering
# Based on the data structure, we select k=2 clusters
final_clusters <- kmeans(data_points, centers = 2)

# 4. Output Results
# Show the center point (average profile) for each cluster
print(final_clusters$centers)

# Show which cluster each data point belongs to
head(final_clusters$cluster)
