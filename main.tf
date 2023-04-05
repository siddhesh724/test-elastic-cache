locals {
  common_tags = {
    name = "tf-test-resource"
  }
}

# subnet group creation
resource "aws_elasticache_subnet_group" "bar" {
  name       = "tf-test-cache-subnet"
  subnet_ids = var.subnet #  private subnet

  tags = local.common_tags
}
# paramter group
resource "aws_elasticache_parameter_group" "tf_ec_pg" {
  name   = var.pg-name
  family = var.family-ec-name

  dynamic "parameter" {
    for_each = var.cluster-parameter
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }

  }

}
# sg created 
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc-id

  dynamic "ingress" {
    for_each = var.ports
    content {
      description = "TLS from VPC"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.cidrs-block
    }
  }

  dynamic "egress" {
    for_each = var.egress-ports

    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "-1"
      cidr_blocks = var.egress-cidrs-block
    }
  }

  tags = local.common_tags
}
# cloud watch log
resource "aws_cloudwatch_log_group" "ec-log" {
  name              = var.cloud-watch-ec-name
  retention_in_days = var.retains-days
  #kms_key_id = false var.kms_key_id

  tags = local.common_tags
}

resource "aws_cloudwatch_log_group" "ec-eng-log" {
  name              = var.cloud-watch-ec-eng-name
  retention_in_days = var.retains-days
  #kms_key_id = false var.kms_key_id

  tags = local.common_tags
}

# elastic cache cluster
resource "aws_elasticache_cluster" "test" {
  cluster_id           = var.clsuter-id
  engine               = var.engine-name
  node_type            = var.cluster-node-type
  num_cache_nodes      = var.cluster-cache-node
  port                 = var.cluster-port
  apply_immediately    = var.apply-immediately
  security_group_ids   = [aws_security_group.allow_tls.id]
  parameter_group_name = aws_elasticache_parameter_group.tf_ec_pg.id

  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.ec-log.name
    destination_type = "cloudwatch-logs"
    log_format       = "text"
    log_type         = "slow-log"
  }
  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.ec-eng-log.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "engine-log"
  }
}
