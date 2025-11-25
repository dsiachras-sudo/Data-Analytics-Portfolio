# Project: High-Performance Data Processing with NumPy
# Purpose: Calculate metrics on large datasets without using slow 'for loops'.
# This demonstrates "Vectorization" - a key skill for Big Data analytics.

import numpy as np
import pandas as pd

# 1. Generate Large Financial Dataset
# Simulating 1 million transaction records
np.random.seed(42)
transactions = np.random.rand(1000000) * 1000  # Transactions up to $1000

# 2. Task: Find High-Value Outliers (Z-Score)
# Traditional loops would be too slow. We use vectorization.

# Calculate Mean and Standard Deviation
mean_val = np.mean(transactions)
std_dev = np.std(transactions)

# Calculate Z-scores for all 1 million rows instantly
z_scores = (transactions - mean_val) / std_dev

# Filter: Find transactions more than 3 standard deviations from the mean
outliers = transactions[np.abs(z_scores) > 3]

# 3. Task: Euclidean Distance Calculation
# Often used to find "similar" financial profiles
profile_a = np.array([100, 200, 500, 50, 0])
profile_b = np.array([110, 210, 480, 60, 10])

# Calculate distance in one line (No loops)
distance = np.sqrt(np.sum((profile_a - profile_b) ** 2))

# 4. Output Results
print(f"Processed {len(transactions)} records.")
print(f"Found {len(outliers)} high-risk outliers.")
print(f"Similarity Score (Distance): {distance:.2f}")
