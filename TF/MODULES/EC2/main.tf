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
  vpc_security_group_ids = [aws_security_group.stack-sg.id]
  user_data              = var.bootstrap_file
  key_name               = aws_key_pair.Stack_KP.key_name
  subnet_id              = var.subnet_ids[0]

  root_block_device {
    volume_type = var.EC2_DETAILS["volume_type"]
    volume_size = var.EC2_DETAILS["volume_size"]
    delete_on_termination = var.EC2_DETAILS["delete_on_termination"]
    encrypted = var.EC2_DETAILS["encrypted"]
  }

  #tags = {
   # Name = "EC2_MODULE"
  #}
  tags = merge(var.required_tags, {"Name"="stack-server-$(count.index)"})
}



resource "aws_launch_template" "launch-template" {
  name_prefix   = "clixx-app-launch-template"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.Stack_KP.key_name
  user_data     = var.bootstrap_file

  vpc_security_group_ids = [aws_security_group.stack-sg.id]

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

output "rendered_script" {
  value = var.bootstrap_file
}

