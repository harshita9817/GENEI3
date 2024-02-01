# Assuming 'result' is the output from GENIE3

# Get the names of regulators (rows) and targets (columns)
regulators <- rownames(result)
targets <- colnames(result)

# Create a data frame to store the top regulators for each target
top_regulators_df <- data.frame(Target = character(), Regulator1 = character(), Regulator2 = character(), Regulator3 = character(), stringsAsFactors = FALSE)

# Loop through each target
for (target in targets) {
  # Get the scores for the target
  target_scores <- result[, target]
  
  # Order the regulators based on scores (descending order)
  ordered_regulators <- regulators[order(target_scores, decreasing = TRUE)]
  
  # Take the top five regulators
  top_five_regulators <- head(ordered_regulators, 3)
  
  # Append the information to the data frame
  top_regulators_df <- rbind(top_regulators_df, c(Target = target, Regulator1 = top_five_regulators[1], Regulator2 = top_five_regulators[2], Regulator3 = top_five_regulators[3]))
}



colnames(top_regulators_df) <- c("Target", "Regulator1", "Regulator2", "Regulator3")
# Print or inspect the result
print(top_regulators_df)
