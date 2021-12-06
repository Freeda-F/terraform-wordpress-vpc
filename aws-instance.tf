# creation of bastion in public2
resource "aws_instance" "bastion" {
  ami           = var.ami
  instance_type = var.type
  associate_public_ip_address = true
  availability_zone = data.aws_availability_zones.az.names[1]
  subnet_id = aws_subnet.public2.id
  key_name = var.key
  vpc_security_group_ids = [aws_security_group.bastion.id]

tags = {
    Name = "${var.project}-bastion-server"
    Project = var.project
  }
}


#creation of webserver instance in public1
resource "aws_instance" "webserver" {
  ami           = var.ami
  instance_type = var.type
  associate_public_ip_address = true
  subnet_id = aws_subnet.public1.id
  availability_zone = data.aws_availability_zones.az.names[0]
  key_name = var.key
  vpc_security_group_ids = [aws_security_group.webserver.id]
  user_data = file("set-wp.sh")

tags = {
    Name = "${var.project}-web-server"
    Project = var.project
  }
}


# creation of database in private1
resource "aws_instance" "database" {
  ami           = var.ami
  instance_type = var.type
  associate_public_ip_address = false
  subnet_id = aws_subnet.private1.id
  availability_zone = data.aws_availability_zones.az.names[0]
  key_name = var.key
  vpc_security_group_ids = [aws_security_group.database.id]
  user_data = file("set-mysql.sh")

tags = {
    Name = "${var.project}-db-server"
    Project = var.project
  }
}
