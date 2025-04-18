variable "ecr_name" {
  type    = list(string)
  default = [ "adservice", "cartservice", "checkoutservice", "currencyservice", "emailservice", "frontend", "loadgenerator", "paymentservice", "productcatalogservice", "recommendationservice", "shippingservice", "shoppingassistantservice"]
}
