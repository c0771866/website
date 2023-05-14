iresource "aws_docdb_cluster" "my_cluster" {
  cluster_identifier      = "my-docdb-cluster"
  engine                  = "docdb"
  master_username         = "myusername"
  master_password         = "mypassword"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}

resource "aws_docdb_subnet_group" "my_subnet_group" {
  name       = "my-docdb-subnet-group"
  subnet_ids = ["subnet-0123456789abcdef0", "subnet-0123456789abcdef1"]
}

resource "aws_docdb_cluster_instance" "my_cluster_instance" {
  identifier              = "my-docdb-instance"
  cluster_identifier      = aws_docdb_cluster.my_cluster.id
  instance_class          = "db.r5.large"
  db_subnet_group_name    = aws_docdb_subnet_group.my_subnet_group.name
  auto_minor_version_upgrade = true
}

resource "aws_security_group" "docdb_sg" {
  name        = "docdb-sg"
  description = "Allow inbound traffic to DocDB"

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_docdb_cluster_parameter_group" "my_parameter_group" {
  family      = "docdb3.6"
  name        = "my-parameter-group"
  description = "DocDB cluster parameter group"

  parameter {
    name         = "tls"
    value        = "enabled"
    apply_method = "pending-reboot"
  }
}
}

