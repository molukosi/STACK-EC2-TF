module "CORE_INFO" {
    # source="./MODULES/CORE_INFO"
    source = "github.com/molukosi/STACK-EC2-TF.git?ref=terraform_modules/TF/MODULES/CORE_INFO"
    required_tags = {
    OwnerEmail = var.OwnerEmail,
    environment = var.environment
    Session = var.Session
    Subsystem = var.Subsystem
    Backup = var.Backup
    Organization = var.Organization
    }

}

module "EC2-BASE" {
 source="./MODULES/EC2"
 ami=var.ami
 EC2_DETAILS=var.EC2_DETAILS
 PATH_TO_PUBLIC_KEY = var.PATH_TO_PUBLIC_KEY
 required_tags = module.CORE_INFO.all_resource_tags
 vpc_id = var.vpc_id
 bootstrap_file = data.template_file.bootstrap.rendered
 }
