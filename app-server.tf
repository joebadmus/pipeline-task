data "template_file" "app_data" {
  template = "${file("template/appserver-data.tpl")}"
}

resource "aws_instance" "AppBox" {
  ami                         = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = true
  ebs_optimized               = false
  key_name                    = "${var.key_name}"
  user_data                   = "${data.template_file.app_data.rendered}"
  #subnet_id                   = "${aws_subnet.public[0]}"
  subnet_id              = "${element(aws_subnet.public.*.id, 0)}"
  vpc_security_group_ids = ["${aws_security_group.app_allow.id}"]

  tags = {
    Name = "AppBox"
  }
}

resource "aws_security_group" "app_allow" {
  name        = "allow_app"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # This should not be accessible from ouyr
  # ingress {
  #   from_port   = 8080
  #   to_port     = 8080
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "AppBox SG"
  }
}

