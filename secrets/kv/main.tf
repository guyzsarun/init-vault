# Enable K/V v2 secrets engine at 'kv-v2'
resource "vault_mount" "kv-v2" {
  path = var.path
  type = "kv-v2"

  description = "kv version 2 secret engine"
}

resource "vault_kv_secret_backend_v2" "kv-v2_config" {
  mount        = vault_mount.kv-v2.path
  max_versions = 3
}

resource "vault_kv_secret_v2" "kv_secret" {
  mount               = vault_mount.kv-v2.path
  name                = split(".", each.value)[0]
  delete_all_versions = true

  for_each  = fileset("${path.module}/templates/", "**/*.json")
  data_json = file("${path.module}/templates/${each.value}")
}
