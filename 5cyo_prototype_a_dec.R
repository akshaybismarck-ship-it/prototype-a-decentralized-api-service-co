# 5cyo_prototype_a_dec.R

# Load required libraries
library(httr)
library(jsonlite)

# Define API endpoints
endpoints <- list(
  "users" = "https://example.com/users",
  "products" = "https://example.com/products",
  "orders" = "https://example.com/orders"
)

# Define decentralized API service controller function
dec_api_controller <- function(endpoint, method, body = NULL) {
  # Handle GET request
  if (method == "GET") {
    response <- GET(endpoints[[endpoint]])
    return(fromJSON(content(response, "text"), simplifyDataFrame = TRUE))
  }
  
  # Handle POST request
  if (method == "POST") {
    response <- POST(endpoints[[endpoint]], body = body, encode = "json")
    return(fromJSON(content(response, "text"), simplifyDataFrame = TRUE))
  }
  
  # Handle error
  stop("Invalid method")
}

# Test case: Get users
users <- dec_api_controller("users", "GET")
print(users)

# Test case: Create new order
new_order <- list(
  "user_id" = 1,
  "product_id" = 1,
  "quantity" = 2
)
created_order <- dec_api_controller("orders", "POST", toJSON(new_order, auto_unbox = TRUE))
print(created_order)