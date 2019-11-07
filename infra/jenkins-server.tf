data "template_file" "jenkins_data" {
  template = "${file("template/jenkins-data.tpl")}"
}


terraform {
  backend "s3" {
    bucket = "joeb-s3-backend-dev"
    key    = "dev/s3state.tfstate"
    # dynamodb_table = "terraform-state-lock-dynamo"
    region = "eu-west-1"
  }
}

# data "terraform_remote_state" "s3state" {
#   backend = "s3"
#   config = {
#     bucket = "joeb-s3-backend-dev"
#     key    = "dev/jenkinsSF.tfstate"
#     # dynamodb_table = "terraform-state-lock-dynamo"
#     region = "eu-west-1"
#   }
# }



resource "aws_instance" "JenkinsBox" {
  ami                         = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = true
  ebs_optimized               = false
  key_name                    = "${var.key_name}"
  user_data                   = "${data.template_file.jenkins_data.rendered}"
  #subnet_id                   = "${aws_subnet.public[0]}"
  subnet_id              = "${element(aws_subnet.public.*.id, 0)}"
  vpc_security_group_ids = ["${aws_security_group.jenkins_allow.id}"]

  tags = {
    Name = "JenkinsBox"
  }
}

resource "aws_security_group" "jenkins_allow" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "JenkinsBox SG"
  }
}

