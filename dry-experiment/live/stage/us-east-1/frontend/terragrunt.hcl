include {
  path = "../../../_env/frontend.hcl"
}

terraform {
  source = "../../../..//modules/ecs-fargate-service"
}

inputs = {
  docker_image_version = "v12"
  replicas             = 1
}