module "kafka" {
  source  = "cloudposse/msk-apache-kafka-cluster/aws"
  version = "2.4.0"
  name    = var.name

  zone_id                  = var.zone_id
  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnets
  kafka_version            = var.kafka_version
  broker_per_zone          = var.broker_per_zone
  broker_instance_type     = var.broker_instance_type
  broker_volume_size       = var.broker_volume_size
  public_access_enabled    = var.public_access_enabled
  broker_dns_records_count = var.broker_dns_records_count

  allowed_security_group_ids           = var.allowed_security_group_ids
  allowed_cidr_blocks                  = var.allowed_cidr_blocks
  associated_security_group_ids        = var.associated_security_group_ids
  create_security_group                = var.create_security_group
  security_group_name                  = var.security_group_name
  security_group_description           = var.security_group_description
  security_group_create_before_destroy = var.security_group_create_before_destroy
  preserve_security_group_id           = var.preserve_security_group_id
  security_group_create_timeout        = var.security_group_create_timeout
  security_group_delete_timeout        = var.security_group_delete_timeout
  allow_all_egress                     = var.allow_all_egress
  additional_security_group_rules      = var.additional_security_group_rules
  inline_rules_enabled                 = var.inline_rules_enabled

  client_allow_unauthenticated                 = var.client_allow_unauthenticated
  client_sasl_scram_enabled                    = var.client_sasl_scram_enabled
  client_sasl_iam_enabled                      = var.client_sasl_iam_enabled
  client_tls_auth_enabled                      = var.client_tls_auth_enabled
  client_sasl_scram_secret_association_enabled = var.client_sasl_scram_secret_association_enabled
  client_sasl_scram_secret_association_arns    = var.client_sasl_scram_secret_association_arns

  certificate_authority_arns = var.certificate_authority_arns


  cloudwatch_logs_enabled   = var.cloudwatch_logs_enabled
  cloudwatch_logs_log_group = var.cloudwatch_logs_log_group

  s3_logs_enabled = var.s3_logs_enabled
  s3_logs_bucket  = var.s3_logs_bucket
  s3_logs_prefix  = var.s3_logs_prefix

  tags = var.tags
}
