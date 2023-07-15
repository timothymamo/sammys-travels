terraform {
  backend "local" {
    path = "./secrets.tfstate"
  }
}
