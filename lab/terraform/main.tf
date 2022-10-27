### VPC
resource "aws_vpc" "vpc1" {
  cidr_block = "10.110.0.0/16"

  tags = {
    Name = var.aws_vpcname
  }
}

### SUBNET
resource "aws_subnet" "subnet_0_0" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.110.0.0/24"

  tags = {
    Name = var.aws_subnetname
  }
}

### IGW
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = var.aws_igwname
  }
}

### ROUTING
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "lab-public-route"
  }
}

resource "aws_route_table_association" "public_route_association" {
  subnet_id      = aws_subnet.subnet_0_0.id
  route_table_id = aws_route_table.public_route.id
}

### SSH KEY
resource "aws_key_pair" "deployer_key" {
  key_name   = "deployer_key"
  public_key = file(var.aws_pubkey_path)
}

### SECURITY GROUP
resource "aws_security_group" "sg1" {
  name        = var.aws_secgroupname
  description = var.aws_secgroupname
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
resource "aws_instance" "instance1" {
  ami                         = var.aws_ami_ubuntu_euw1
  instance_type               = var.aws_itype
  subnet_id                   = aws_subnet.subnet_0_0.id
  associate_public_ip_address = var.aws_public_ip
  key_name                    = aws_key_pair.deployer_key.key_name
  vpc_security_group_ids      = [aws_security_group.sg1.id]

  root_block_device {
    delete_on_termination = true
    volume_size = 20
  }
  tags = {
    Name ="labserver1"
    OS = "ubuntu"
  }
  depends_on = [aws_security_group.sg1]
}
