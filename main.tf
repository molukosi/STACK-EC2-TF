locals {
  #  Server_Prefix = "CliXX-"
  Server_Prefix = ""
}

resource "aws_key_pair" "Stack_KP" {
  key_name   = "stackkp"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "Server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.clixx-bastion-server.id]
  user_data              = data.template_file.bootstrap.rendered
  key_name               = aws_key_pair.Stack_KP.key_name
  subnet_id              = aws_subnet.clixx-pub1.id

  tags = {
    Name        = "stack-clixx-app"
    Environment = var.environment
  }
}

resource "aws_launch_template" "launch-template" {
  name_prefix   = "clixx-app-launch-template"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.Stack_KP.key_name
  user_data     = base64encode(data.template_file.bootstrap.rendered)

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = [aws_security_group.clixx-app-server.id]
  }

  block_device_mappings {
    device_name = "/dev/sdb"
    ebs {
      volume_size           = 20
      volume_type           = "gp2"
      delete_on_termination = true
    }
  }

  block_device_mappings {
    device_name = "/dev/sdc"
    ebs {
      volume_size           = 20
      volume_type           = "gp2"
      delete_on_termination = true
    }
  }

  block_device_mappings {
    device_name = "/dev/sdd"
    ebs {
      volume_size           = 20
      volume_type           = "gp2"
      delete_on_termination = true
    }
  }

  block_device_mappings {
    device_name = "/dev/sde"
    ebs {
      volume_size           = 20
      volume_type           = "gp2"
      delete_on_termination = true
    }
  }
}