resource "aws_key_pair" "terra-key" {
  key_name   = "terra-key"
  public_key = file(var.PUBLIC_KEY)
}

resource "aws_instance" "terra-ec2" {
  ami                    = var.AMIS[var.REGION]
  key_name               = aws_key_pair.terra-key.key_name
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.terra-sub-pub-1.id
  vpc_security_group_ids = [
    aws_security_group.terra-sg.id
    ]
  tags = {
    Name    = "terra-ec2"
    Project = "terra-formation"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  connection {
    user     = var.USER
    private_key = file(var.PRIVATE_KEY)
    host     = self.public_ip
  }
}