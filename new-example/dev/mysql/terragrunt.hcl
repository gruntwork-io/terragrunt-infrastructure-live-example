dependency "vpc" {
  config_path = "${get_terragrunt_dir()}/../vpc"
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
}
