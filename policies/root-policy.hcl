# allow all access
path "*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}