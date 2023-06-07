terraform {
  backend "local" {
    path = "./network.tfstate"
  }
}
