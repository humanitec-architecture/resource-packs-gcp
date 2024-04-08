locals {
  # https://www.postgresql.org/docs/current/sql-syntax-lexical.html#SQL-SYNTAX-IDENTIFIERS
  default_name = trimsuffix(lower(substr(replace(var.res_id, ".", "-"), 0, 63)), "-")
}

resource "google_sql_database" "main" {
  instance = var.instance

  name = coalesce(var.name, local.default_name)
}

resource "random_password" "password" {
  length  = 16
  special = false
}

resource "google_sql_user" "main" {
  instance = var.instance

  name     = coalesce(var.name, local.default_name)
  password = random_password.password.result
}
