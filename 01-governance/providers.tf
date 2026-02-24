provider "aws" {
  profile = "aws_lab"
  region  = var.primary_region
}

provider "aws" {
  alias   = "dr"
  profile = "aws_lab"
  region  = var.dr_region
}