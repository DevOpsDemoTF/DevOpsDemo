module "DEV" {
  source            = "git::https://github.com/butzist/DevOpsDemo-k8s?ref=v0.1.1"
  prefix            = var.prefix
  letsencrypt_email = var.letsencrypt_email
  environment       = "DEV"
  k8s_agent_count   = "1"
  k8s_agent_size    = "Standard_E2s_v3"
  location          = var.location
}

module "PROD" {
  source            = "git::https://github.com/butzist/DevOpsDemo-k8s?ref=v0.1.1"
  prefix            = var.prefix
  letsencrypt_email = var.letsencrypt_email
  environment       = "PROD"
  k8s_agent_count   = "1"
  k8s_agent_size    = "Standard_D1_v2"
  location          = var.location
}

module "Spinnaker" {
  source       = "git::https://github.com/butzist/DevOpsDemo-Spinnaker?ref=v0.1.0"
  environments = [module.DEV.environment, module.PROD.environment]

  prefix   = var.prefix
  location = var.location
  domain   = module.DEV.fqdn

  providers = {
    kubernetes = kubernetes.kubernetes_dev
    helm       = helm.helm_dev
  }
}

output "dashboards" {
  value = {
    "DEV": module.DEV.dashboard_url
    "PROD": module.PROD.dashboard_url
  }
}