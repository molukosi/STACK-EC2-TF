variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-1"
}
variable "DB_PASSWORD" {}

variable "DB_NAME" {}

variable "DB_USER" {}

variable "DB_SNAP_ID" {}

variable "OLD_ENDPOINT" {}

variable "server" {
  default = "serv"
}
variable "ami" {
  default = "ami-08f3d892de259504d"
}
variable "vpc_id" {
  default = "vpc-0ebe1b889a03334ce"
}
variable "availability_zone" {
  default = "us-east-1c"
}
variable "instance_type" {
  default = "t2.micro"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "subnet_ids" {
  type = list(string)
  default = [
    "subnet-07d136d042a92949c",
    "subnet-07f498d640e8f4f4d",
    "subnet-0b4d3333ae8d8ac67",
    "subnet-0bb11bbbaa52f867b",
    "subnet-0df2401a7d9a544c4",
  "subnet-0f57b55fc4b44986f"]
}

variable "environment" {
  default = "dev"
}

variable "OwnerEmail" {
  default = "mikeo.olukosi@gmail.com"
}

variable "Session" {
  default = "stackcloud10"
}

variable "Backup" {
  default = "No"
}

variable "Organization" {
  default = "Stack IT Solutions"
}

variable "Subsystem" {
  default = "Clixx"
}

variable "number_of_asgs" {
  description = "The number of Auto Scaling Groups to create"
  type        = number
  default     = 1 # Set a default or provide a value elsewhere in your Terraform configuration
}

variable "shared_snapshot_arn" {
  description = "ARN of the shared snapshot"
  default     = "arn:aws:rds:us-east-1:541478845275:snapshot:clixx-app-snap-restore"
}

variable "EC2_DETAILS" {
  type = map (string)
  default = {
    volume_size = 30
    volume_type = "gp2"
    delete_on_termination = "false"
    encrypted = "false"
  }
}

variable "bootstrap_file" {
  default = "scripts/bootstrap.tpl"
}