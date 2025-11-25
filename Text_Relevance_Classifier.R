# Project: Automated Document Classification
# Purpose: This script takes raw text (news/ads), cleans it, 
# and builds a logistic regression model to predict relevance.

library(tm)
library(textir) # For TF-IDF if needed
library(caret)  # For confusion matrix

# 1. Load and Preprocess Data
# Note: Ensure 'Ads.csv' and 'News.csv' are in the working directory
docs_source <- DirSource("path/to/your/data") 
corpus <- VCorpus(docs_source)

# 2. Text Cleaning Pipeline
# Convert to lower case, remove numbers, punctuation, and stopwords
clean_corpus <- tm_map(corpus, content_transformer(tolower))
clean_corpus <- tm_map(clean_corpus, removeNumbers)
clean_corpus <- tm_map(clean_corpus, removePunctuation)
clean_corpus <- tm_map(clean_corpus, removeWords, stopwords("english"))
clean_corpus <- tm_map(clean_corpus, stemDocument)

# 3. Create Term-Document Matrix (TDM)
tdm <- TermDocumentMatrix(clean_corpus)
matrix_dtm <- as.matrix(tdm)

# 4. Feature Extraction (Latent Semantic Analysis)
# Reducing thousands of words down to 20 key concepts
lsa_space <- lsa(tdm, dims=20)
doc_vectors <- as.data.frame(lsa_space$dk)

# 5. Build Logistic Regression Model
# Train model to distinguish between Document Type A and B
model_logit <- glm(y ~ ., data = doc_vectors, family = "binomial")

# 6. Output Accuracy
pred <- predict(model_logit, type="response")
print(table(Actual = doc_vectors$y, Predicted = pred > 0.5))
