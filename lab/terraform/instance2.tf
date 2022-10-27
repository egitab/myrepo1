### SECURITY GROUP
resource "aws_security_group" "sg2" {
  name        = "labsecgroup2"
  description = "labsecgroup2"
  vpc_id      = aws_vpc.vpc1.id

  // Inbound: allow ssh
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Outbound: allow all
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

### EC2
resource "aws_instance" "instance2" {
  ami                         = var.aws_ami_ubuntu_euw1
  instance_type               = var.aws_itype
  subnet_id                   = aws_subnet.subnet_0_0.id
  associate_public_ip_address = var.aws_public_ip
  key_name                    = aws_key_pair.deployer_key.key_name
  vpc_security_group_ids      = [aws_security_group.sg2.id]

  root_block_device {
    delete_on_termination = true
    volume_size = 20
  }
  tags = {
    Name ="labserver2"
    OS = "ubuntu"
  }
  depends_on = [aws_security_group.sg2]
}

output "aws_instance2_public_ip" {
  value = aws_instance.instance2.public_ip
}
