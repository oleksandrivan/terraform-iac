
module "master" {
  source     = "./modules/master"
  project_id = var.project_id
  region     = var.region
}

module "worker" {
  source     = "./modules/worker"
  project_id = var.project_id
  region     = var.region
}
