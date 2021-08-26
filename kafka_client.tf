resource "aws_instance" "ec2_kafka_client" {
  ami                    = var.ami_us_east_1
  instance_type          = var.ec2_type
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  subnet_id              = aws_subnet.sn_public_one.id
  vpc_security_group_ids = [aws_security_group.sg_kafka_ec2.id]
  tags = {
    Name = "ec2_kafka_client"
  }
  associate_public_ip_address = true
  user_data = ""
}