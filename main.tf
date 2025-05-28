provider "aws" {
  region = var.aws_region
}
provider "random" {}
# Generate random password
resource "random_password" "rds_password" {
  length  = var.db_password_length
  special = true
}
# Create Secrets Manager secret
resource "aws_secretsmanager_secret" "rds_secret" {
  name = "rds-master-password"
}
resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    username = var.db_username,
    password = random_password.rds_password.result
  })
}
# Create the RDS instance
resource "aws_db_instance" "myrds" {
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  allocated_storage    = var.db_allocated_storage
  instance_class       = var.db_instance_class
  storage_type         = "gp2"
  identifier           = var.db_name
  publicly_accessible  = true
  skip_final_snapshot  = true
  
  username = jsondecode(aws_secretsmanager_secret_version.rds_secret_version.secret_string)["username"]
  password = jsondecode(aws_secretsmanager_secret_version.rds_secret_version.secret_string)["password"]

  tags = {
    Name = "Myrdsdb"
  }
}
