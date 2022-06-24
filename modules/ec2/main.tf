resource "aws_instance" "rancher-server" {
  for_each                = var.instances
  ami                     = var.ami
  instance_type           = each.value.instance_type
  hibernation             = true
  disable_api_termination = false
  disable_api_stop        = false
  key_name                = var.key_name

  user_data = <<EOF
    #!/bin/bash
    set -ex
    sudo yum update -y
    sudo amazon-linux-extras install docker -y
    sudo service docker start
    sudo usermod -G docker ubuntu
    sudo curl -L https://github.com/docker/compose/releases/download/2.6.1/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
  EOF

  root_block_device {
    encrypted = true
  }

  subnet_id              = var.subnet_ids[each.value.instance_id]
  vpc_security_group_ids = ["${var.security_group}"]

  tags = {
    Name        = "${var.prefix}-${each.value.name}"
    Provisioner = "Terraform provisioner"
    Environment = "dev"
  }
}
