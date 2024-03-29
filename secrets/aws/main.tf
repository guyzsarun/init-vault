resource "vault_aws_secret_backend" "aws" {
  access_key = var.aws.access_key
  secret_key = var.aws.secret_key
  region     = var.aws.region

  default_lease_ttl_seconds = 21600

  path        = var.path
  description = "aws secret engine"
}

resource "vault_aws_secret_backend_role" "aws_role" {
  backend         = vault_aws_secret_backend.aws.path
  name            = split(".", each.value)[0]
  credential_type = "iam_user"

  policy_document = file("${path.module}/templates/${each.value}")

  for_each = fileset("${path.module}/templates", "*.json")
}
