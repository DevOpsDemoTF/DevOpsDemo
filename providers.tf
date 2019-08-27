provider "azurerm" {
  version = "~>1.33"
}

provider "azuread" {
  version = "~>0.3"
}

provider "local" {
  version = "~>1.3"
}

provider "random" {
  version = "~>2.2"
}

provider "template" {
  version = "~>2.1"
}

provider "kubernetes" {
  version = "~>1.8"
  alias   = "kubernetes_dev"
  host    = module.DEV.login.host

  client_certificate     = base64decode(module.DEV.login.client_certificate)
  client_key             = base64decode(module.DEV.login.client_key)
  cluster_ca_certificate = base64decode(module.DEV.login.cluster_ca_certificate)
}

provider "helm" {
  version         = "~>0.10"
  alias           = "helm_dev"
  namespace       = module.DEV.helm.tiller_namespace
  service_account = module.DEV.helm.tiller_name

  kubernetes {
    host = module.DEV.login.host

    client_certificate     = base64decode(module.DEV.login.client_certificate)
    client_key             = base64decode(module.DEV.login.client_key)
    cluster_ca_certificate = base64decode(module.DEV.login.cluster_ca_certificate)
  }
}
