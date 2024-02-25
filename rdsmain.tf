variable "db_username" {
    type = string
}

variable "db_password" {
    type = string
}

resource "aws_db_instance" "rds-full-stack-project-db" {
  identifier = "full-stack-db"
  allocated_storage = 20
  db_name = "cyf_videos"
  engine = "postgres"
  engine_version = "15"
  instance_class = "db.t4g.micro"
  username = var.db_username
  password = var.db_password
  tags = {
    Name = "video-recommendations-db"
  }
}