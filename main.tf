module "mc_transit" {
  source                 = "terraform-aviatrix-modules/mc-transit/aviatrix"
  version                = "2.5.1"
  cloud                  = "AWS"
  name                   = "${var.region_code}-transit"
  region                 = var.region
  cidr                   = var.transit_cidr
  account                = var.account
  bgp_ecmp               = var.bgp_ecmp
  enable_transit_firenet = var.enable_transit_firenet
  gw_name                = "${var.region_code}-transit"
  insane_mode            = var.insane_mode
  local_as_number        = var.local_as_number
  instance_size          = var.instance_size
  ha_gw                  = var.ha_gw
  enable_segmentation    = var.enable_segmentation
}


module "mc_spoke_dev" {
  source             = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version            = "1.6.3"
  cloud              = "AWS"
  name               = "${var.region_code}-spoke-dev"
  region             = var.region
  cidr               = var.dev_spoke_cidr
  account            = var.account
  gw_name            = "${var.region_code}-spoke-dev"
  insane_mode        = var.insane_mode
  ha_gw              = var.ha_gw
  transit_gw         = module.mc_transit.transit_gateway.gw_name
  instance_size = var.instance_size
}


module "dev-pub" {
  source    = "jye-aviatrix/aws-linux-vm-public/aws"
  version   = "2.0.3"
  key_name  = var.key_name
  vm_name   = "${var.region_code}-dev-pub"
  vpc_id    = module.mc_spoke_dev.vpc.vpc_id
  subnet_id = module.mc_spoke_dev.vpc.public_subnets[0].subnet_id
  use_eip   = true
  instance_type = var.instance_size
}



module "dev-priv" {
  source    = "jye-aviatrix/aws-linux-vm-private/aws"
  version   = "2.0.1"
  count = var.deploy_private_instance ? 1 : 0
  key_name  = var.key_name
  vm_name   = "${var.region_code}-dev-priv"
  vpc_id    = module.mc_spoke_dev.vpc.vpc_id
  subnet_id = module.mc_spoke_dev.vpc.private_subnets[0].subnet_id
}




module "mc_spoke_prd" {
  source             = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version            = "1.6.3"
  cloud              = "AWS"
  name               = "${var.region_code}-spoke-pub"
  region             = var.region
  cidr               = var.prd_spoke_cidr
  account            = var.account
  # gw_name            = "${var.region_code}-spoke-pub"
  insane_mode        = var.insane_mode
  ha_gw              = var.ha_gw
  transit_gw         = module.mc_transit.transit_gateway.gw_name
  instance_size = var.instance_size
}


module "prd-pub" {
  source    = "jye-aviatrix/aws-linux-vm-public/aws"
  version   = "2.0.3"
  key_name  = var.key_name
  vm_name   = "${var.region_code}-prd-pub"
  vpc_id    = module.mc_spoke_prd.vpc.vpc_id
  subnet_id = module.mc_spoke_prd.vpc.public_subnets[0].subnet_id
  use_eip   = true
  instance_type = var.instance_size
}




module "prd-priv" {
  source    = "jye-aviatrix/aws-linux-vm-private/aws"
  version   = "2.0.1"
  count = var.deploy_private_instance ? 1 : 0
  key_name  = var.key_name
  vm_name   = "${var.region_code}-prd-priv"
  vpc_id    = module.mc_spoke_prd.vpc.vpc_id
  subnet_id = module.mc_spoke_prd.vpc.private_subnets[0].subnet_id
}

