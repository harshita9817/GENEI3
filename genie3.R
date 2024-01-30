library(GENIE3)
result1 <- GENIE3(
  exprMatrix = exprMatrix,
  regulators = regulators,
  targets = targets,
  treeMethod = "RF",
  K = "sqrt",
  nTrees = 1000,
  nCores = 1,
  returnMatrix = TRUE,
  verbose = FALSE
)

edge_list <- as.data.frame(as.table(result1))
colnames(edge_list) <- c("regulator", "target", "weight")
library(igraph)

#####################################################################################################################
# Define a threshold
threshold <- 0.015

# Filter edges with lower weights
filtered_edge_list <- edge_list[edge_list$weight > threshold, ]

# Get a subset of nodes (regulator and target genes)
selected_nodes <- unique(c(filtered_edge_list$regulator, filtered_edge_list$target))

# Create a subgraph with the selected nodes and filtered edges
subgraph <- induced_subgraph(graph, selected_nodes)

# Set vertex color attribute based on whether the gene is in the outer circle or inner circle
V(subgraph)$color <- ifelse(V(subgraph)$name %in% targets, "lightblue", "pink")

# Set edge color attribute based on the direction (regulation)
E(subgraph)$color <- ifelse(E(subgraph)$weight > 0, "darkblue", "red")

# Set vertex label and size attributes
V(subgraph)$label.cex <- 1  # Adjust label size
V(subgraph)$label.color <- "black"  # Label color
V(subgraph)$size <- 8  # Adjust the size of the circles

# Plot the subgraph
plot(
  subgraph,
  layout = layout_nicely(subgraph),
  edge.arrow.size = 0.3,
  vertex.color = V(subgraph)$color,
  edge.color = E(subgraph)$color,
  vertex.label.cex = V(subgraph)$label.cex,
  vertex.label.color = V(subgraph)$label.color,
  vertex.size = V(subgraph)$size
)
