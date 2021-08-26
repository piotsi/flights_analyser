resource "aws_security_group" "sg_kafka_ec2" {
  name        = "sg_kafka_ec2"
  description = "Allow SSH and Redshift inbound"
  vpc_id      = aws_vpc.vpc_main.id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.body)}/32"]
  }
  ingress {
    description = "Redshift from public subnet"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }

  tags = {
    Name = "sg_kafka_ec2"
  }
}

resource "aws_security_group" "sg_msk" {
  name        = "sg_msk"
  description = "MSK Security Group"
  vpc_id      = aws_vpc.vpc_main.id

  ingress {
    description = "2181"
    from_port   = 2181
    to_port     = 2181
    protocol    = "tcp"
  }
  ingress {
    description = "5439"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
  }
  ingress {
    description = "9094"
    from_port   = 9094
    to_port     = 9094
    protocol    = "tcp"
  }
  ingress {
    description = "9092"
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
  }

  tags = {
    Name = "sg_msk"
  }
}

resource "aws_security_group" "sg_base" {
  name        = "sg_base"
  description = "Base Security Group"
  vpc_id      = aws_vpc.vpc_main.id

  ingress {
    description = "0-65535"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
  }

  tags = {
    Name = "sg_base"
  }
}