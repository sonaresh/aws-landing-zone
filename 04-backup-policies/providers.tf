# Primary (us-east-1)
provider "aws" {
  region = var.primary_region
}

# DR (us-east-2)
provider "aws" {
  alias  = "dr"
  region = var.dr_region
}
