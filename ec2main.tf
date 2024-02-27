variable "ec2_full_stack_project" {
    type = string
}


resource "aws_instance" "cyf_backend" {
  ami           = "ami-0905a3c97561e0b69"  # Use an appropriate Ubuntu AMI ID
  instance_type = "t2.micro"  # Choose an instance type
  key_name      = "VideoStorage"  # Create an SSH key pair in AWS and specify the name
  security_groups = ["ec2_full_stack_project-security-group"]  # Create a security group in AWS and specify
  tags = {
    Name = "terraform-VideoStorage-app"
  }

}

resource "aws_security_group" "cyf_backend_sg" {
  name        = "ec2_full_stack_project-security-group"  # Choose a unique name
  description = "Security group for ec2_full_stack_project-security-group backend"
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  ingress {
      from_port        = 5000
      to_port          = 5000
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  # Add more ingress rules for your application as needed
}

