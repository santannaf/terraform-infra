resource "aws_key_pair" "my-key-pair" {
  key_name   = "rancher-kubernetes"
  public_key = file("~/.ssh/rancher-kubernetes.pub")
}