data "terraform_remote_state" "aurora" {
  backend = "local" # または "remote"（Terraform Cloudなど）
  config = {
    path = "../Database/terraform.tfstate"  # 相対パスでAurora側のstateファイルを指定
  }
}
