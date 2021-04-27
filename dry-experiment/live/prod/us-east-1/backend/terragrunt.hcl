include {
  path = "../../../_env/backend.hcl"
}

terraform {
  source = "../../../..//modules/ecs-fargate-service"
}

inputs = {
  docker_image_version = "v3"
  replicas             = 5
}