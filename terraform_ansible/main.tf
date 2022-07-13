locals {
  ami              = "ami-0960ab670c8bb45f3"  
  vpc_id           = "vpc-0612dc7fef38174a4"
  subnet_id        = "subnet-05d9642b50e7fc0f0"
  ssh_user         = "ubuntu"
  key_name         = "wp_formacao"
  private_key_path = "~/SRE/github/terraform/terraform_ansible/wp_formacao.pem"
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_security_group" "aula_cohort" {
  name   = "aula_cohort"
  vpc_id = local.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
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
}

resource "aws_instance" "aula_cohort" {
  ami                         = local.ami
  subnet_id                   = local.subnet_id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.aula_cohort.id]
  key_name                    = local.key_name

  provisioner "remote-exec" {
    inline = ["echo 'Aguardando'"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = aws_instance.aula_cohort.public_ip
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook  -i ${aws_instance.aula_cohort.public_ip}, --private-key ${local.private_key_path} wordpress.yml"
  }
}

output "aula_cohort_ip" {
  value = aws_instance.aula_cohort.public_ip
}