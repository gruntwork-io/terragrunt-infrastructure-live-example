output "jenkins-master-sg" {
   value = "${aws_security_group.jenkins-master-sg.id}"
}
output "jenkins_master_id" {
   value = "${aws_instance.jenkins-master.id}"
}
