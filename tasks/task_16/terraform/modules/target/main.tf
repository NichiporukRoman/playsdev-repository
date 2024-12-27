resource "aws_security_group" "sg_group_target" {
    name = "sg_group_target"
    description = "Security group"
    vpc_id = var.vpc_id

    ingress {
        description = var.object.name
        from_port = 22
        to_port = 22
        protocol = "tcp"
#       cidr_blocks = ["178.127.202.237/32"]
        cidr_blocks = var.object.adresses
    }

    ingress {
        description = var.object.name
        from_port = 80
        to_port = 80
        protocol = "tcp"
#       cidr_blocks = ["178.127.202.237/32"]
        cidr_blocks = var.object.adresses
    }

    ingress {
        description = var.object.name
        from_port = 443
        to_port = 443
        protocol = "tcp"
#       cidr_blocks = ["178.127.202.237/32"]
        cidr_blocks = var.object.adresses
    }

    ingress {
        description = var.object.name
        from_port = 8080
        to_port = 8080  
        protocol = "tcp"
        cidr_blocks = var.object.adresses
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}



resource "aws_instance" "target" {
  ami = var.ami_ubuntu
  subnet_id = var.subnet_id  
  instance_type = var.type_target
  key_name  = var.keypair
  security_groups = [  aws_security_group.sg_group_target.id ]
  tags = {
    Name = "target"
  }
}

