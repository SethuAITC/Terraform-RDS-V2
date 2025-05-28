variable "aws_region" {
  default = "us-east-2"
}
variable "db_name" {
  default = "mydb"
}
variable "db_instance_class" {
  default = "db.t3.micro"
}
variable "db_engine" {
  default = "mysql"
}
variable "db_engine_version" {
  default = "8.0.41"
}
variable "db_allocated_storage" {
  default = 20
}
variable "db_username" {
  default = "admin"
}
variable "db_password_length" {
  default = 16
}
