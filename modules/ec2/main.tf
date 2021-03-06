data "template_file" "user_data" {
  template = "${file("~/docker.sh")}"
}

resource "aws_instance" "rancher-server" {
  for_each                = var.instances
  ami                     = var.ami
  instance_type           = each.value.instance_type
  hibernation             = true
  disable_api_termination = false
  disable_api_stop        = false
  key_name                = var.key_name

  user_data    =  "${data.template_file.user_data.rendered}"

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
