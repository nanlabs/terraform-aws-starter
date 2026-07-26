aws_region                  = "us-west-1"
vpc_id                      = "" 
name                        = "testing-db"
db_name                     = "myappdb"
db_master_username          = "dbadmin"
manage_master_user_password = true
db_port                     = 5432
db_instance_class           = "db.t4g.small"
db_engine                   = "postgress"
db_engine_version           = "16.3"
allocated_storage           = 20
max_allocated_storage       = 100  
enable_public_access        = false

tags = {
    Environment = "testing"
    Project     = "backend"  
}
