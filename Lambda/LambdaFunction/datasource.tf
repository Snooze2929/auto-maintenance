data "terraform_remote_state" "psycopg2_layer" {
  backend = "remote"

  config = {
    organization = "Snoozeman-Portfolio"
    workspaces = {
      name = "auto-maintenance"
    }
  }
}