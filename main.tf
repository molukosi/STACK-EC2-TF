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
