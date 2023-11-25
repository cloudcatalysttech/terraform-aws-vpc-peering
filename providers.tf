provider "aws" {
  alias  = "requester"
  region = var.requester_region
  assume_role {
    role_arn = "arn:aws:iam::310830963532:role/DevOps"
  }
}

provider "aws" {
  alias  = "accepter"
  region = var.accepter_region
  assume_role {
    role_arn = "arn:aws:iam::310830963532:role/DevOps"
  }
}
