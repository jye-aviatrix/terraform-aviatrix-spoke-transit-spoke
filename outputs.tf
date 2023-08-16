output "dev-pub" {
  value = module.dev-pub
}

output "dev-priv" {
  value = var.deploy_private_instance ? module.dev-priv : null
}

output "prd-pub" {
  value = module.prd-pub
}

output "prd-priv" {
  value = var.deploy_private_instance ? module.prd-priv : null
}

output "transit_local_as_number" {
  value = module.mc_transit.transit_gateway.local_as_number
}

output "transit_gw_name" {
  value = module.mc_transit.transit_gateway.gw_name
}

output "transit_vpc_id" {
  value = module.mc_transit.vpc.vpc_id
}