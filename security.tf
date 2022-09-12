####### security group creation - bastion server #######
resource "aws_security_group" "bastion" {
  name        = "bastion-sg"
  description = "allow 22 from all IPs"
  vpc_id      = aws_vpc.vpc.id.id

  ingress {
    description      = ""
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

tags = {
    Name = "${var.project}-bastion-sg"
    Project = var.project
  }
}

####### security group creation - webserver ######
resource "aws_security_group" "webserver" {
  name        = "webserver-sg"
  description = "allow 80 from all IPs,22 from bastion"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = ""
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]

  }

    ingress {
    description      = ""
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]

  }

   ingress {
    description      = ""
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = [aws_security_group.bastion.id]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

tags = {
    Name = "${var.project}-webserver-sg"
    Project = var.project
  }
}

####### security group creation - DB server ######
resource "aws_security_group" "database" {
  name        = "database-sg"
  description = "allow 22 from bastion,3306 from websevr"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = ""
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.webserver.id]

  }

   ingress {
    description      = ""
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = [aws_security_group.bastion.id]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

tags = {
    Name = "${var.project}-db-sg"
    Project = var.project
  }
}
