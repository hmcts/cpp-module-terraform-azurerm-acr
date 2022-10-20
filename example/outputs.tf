 output "acr" {
  description = "This prints the Resource group Name and id"
  value       = values(module.acr)[*]
} 
