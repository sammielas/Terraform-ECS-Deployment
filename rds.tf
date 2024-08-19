# RDS Instance
resource "aws_db_instance" "myrds" {
  instance_class         = var.database_instance_class
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.35"
  username               = var.db_username
  password               = var.db_password
  vpc_security_group_ids = [aws_security_group.database_security_group.id]
  availability_zone      = data.aws_availability_zones.available_zones.names[0]
  identifier             = var.database_instance_identifier
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
  multi_az               = var.multi_az_deployment
  publicly_accessible    = true
  skip_final_snapshot    = true

  tags = {
    Name = "MyRDS"
  }
}

# create database subnet group
resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "${var.project_name}-${var.environment}-database-subnets"
  subnet_ids  = [aws_subnet.private_app_subnet_az1.id, aws_subnet.private_app_subnet_az2.id]
  description = "subnets for database instance"

  tags = {
    Name = "${var.project_name}-${var.environment}-database-subnets"
  }
}