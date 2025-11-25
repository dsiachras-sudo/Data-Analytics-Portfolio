# Project: Advanced Regression for Censored Data (Tobit Model)
# Purpose: Analyze data that is "censored" (cut off) at zero or a specific limit.
# Standard regression fails here; Tobit models correct the bias.

# Install package if missing: install.packages("censReg")
library(censReg)

# 1. Load Data
# We use the standard 'aer' or 'survival' datasets for demonstration
# Simulating data: 'y' is spending, 'x' is income. 
# Spending cannot be negative (it is censored at 0).
set.seed(123)
x <- rnorm(200)
y_theoretical <- 1 + 2*x + rnorm(200)
y <- pmax(0, y_theoretical) # Censor any negative values to 0

data_censored <- data.frame(y = y, x = x)

# 2. The Problem: Standard Linear Regression (Naive Approach)
# This model will be biased because it treats 0s as actual values
naive_model <- lm(y ~ x, data = data_censored)
summary(naive_model)

# 3. The Solution: Tobit Regression
# This model accounts for the fact that data below 0 is hidden
tobit_model <- censReg(y ~ x, left = 0, right = Inf, data = data_censored)

# 4. Compare Results
# Notice how the Tobit coefficients are closer to the "True" values (1 and 2)
summary(tobit_model)
