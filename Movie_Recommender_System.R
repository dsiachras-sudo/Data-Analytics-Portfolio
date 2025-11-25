# Project: Collaborative Filtering Recommendation Engine
# Purpose: Suggest items to users based on similarity to other users.

library(recommenderlab)
library(ggplot2)

# 1. Load Data
# Using the standard MovieLense dataset as an example
data(MovieLense)

# 2. Visualize Raw Ratings
hist(getRatings(MovieLense), main="Distribution of User Ratings")

# 3. Build the Model (User-Based Collaborative Filtering)
# We use Cosine similarity to find users with similar tastes
rec_model <- Recommender(MovieLense, method = "UBCF", 
                         param=list(method="Cosine", nn=30))

# 4. Generate Predictions
# Predict top 10 movies for the first 5 users
top_recommendations <- predict(rec_model, MovieLense[1:5], n=10)

# 5. View Results
as(top_recommendations, "list")
