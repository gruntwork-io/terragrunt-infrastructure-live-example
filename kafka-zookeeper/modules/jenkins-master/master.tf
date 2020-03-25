resource "aws_instance" "jenkins-master" {
    ami                         = "${var.jenkins-master-ami}"
    instance_type               = "${var.jenkins_master_instance_type}"
    key_name                    = "${var.aws_key_name}"
    vpc_security_group_ids      = ["${aws_security_group.jenkins-master-sg.id}"]
    #count                      = "${length(var.public_sub_cidr)}"
    #user_data                  = "${data.template_file.userdata-jenkins.rendered}"
    subnet_id                   = "${var.pub_sub_id}"
    associate_public_ip_address = true
    source_dest_check           = false
    // Implicit dependency
    iam_instance_profile        = "${aws_iam_instance_profile.jenkins_profile.name}"
    root_block_device {
      volume_type = "gp2"
      volume_size = 30
      delete_on_termination = true
      //delete_on_termination = false
        }
     volume_tags = {
                Name = "Jenkins_Master"
                }

    tags = {
      Name        = "Jenkins_Master"
      Role        = "jenkins"
      Environment = "${var.environment}"
      Stack       = "Supporting-mongo"
    }

}
