variable "aws_region" {
  type    = string
  default = ""
}

variable "vpc_main_cidr" {
  type    = string
  default = ""
}

variable "sn_public_one_cidr" {
  type    = string
  default = ""
}

variable "sn_private_one_cidr" {
  type    = string
  default = ""
}

variable "sn_private_two_cidr" {
  type    = string
  default = ""
}

variable "sn_private_three_cidr" {
  type    = string
  default = ""
}

variable "ami_us_east_1" {
  type    = string
  default = ""
}

variable "ec2_kafka_client_type" {
  type    = string
  default = ""
}

variable "key_pair_ec2" {
  type    = string
  default = ""
}

variable "redshift_db_name" {
  type    = string
  default = ""
}

variable "redshift_ec2_type" {
  type    = string
  default = ""
}

variable "redshift_password" {
  type    = string
  default = ""
}

variable "redshift_username" {
  type    = string
  default = ""
}

variable "redshift_cluster_name" {
  type    = string
  default = ""
}

variable "msk_cluster_name" {
  type    = string
  default = ""
}

variable "msk_kafka_version" {
  type    = string
  default = ""
}

variable "msk_broker_nodes" {
  type    = number
  default = 1
}

variable "msk_kafka_instance_type" {
  type    = string
  default = ""
}

variable "msk_ebs_volume_size" {
  type    = number
  default = 1000
}

variable "nifi_sensitive_properties_key" {
  type = string
}

variable "opensky_username" {
  type = string
}

variable "opensky_password" {
  type = string
}

variable "kafka_topic_name" {
  type = string
}

variable "s3_glue_script" {
  type = string
}

variable "s3_temp" {
  type = string
}