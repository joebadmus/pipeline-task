# output "s3_back_name" {
#   value = "http://${aws_instance.JenkinsBox.public_ip}:8080  To connect ssh -i key ec2-user@${aws_instance.JenkinsBox.public_ip}"
# }


output "s3_backend_id" {
  value = "${aws_s3_bucket.s3backend.id}"
}

output "s3_backend_region" {
  value = "${aws_s3_bucket.s3backend.region}"
}


output "s3_backend_Environment" {
  value = "${aws_s3_bucket.s3backend.tags.Environment}"
}

