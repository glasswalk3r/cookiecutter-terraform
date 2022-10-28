/*
Main file, where all things are put together
ONLY declare resources here that will not be shared anywhere else. If that
happens, you want to create a new directory under the appropriate directory
tree, depending on the resource type.
*/

# these are the common tags you WILL want to add to every resource that supports it
module "common_tags" {
  source       = "../../../modules/tags"
  environment  = var.environment
  project_name = var.project_name
  namespace    = var.namespace
  # You can customize the name passing a "name" parameter
  add_name_tag = true
}

{% if cookiecutter.resource_type == 's3' -%}
resource "aws_s3_bucket" "{{ cookiecutter.module_name }}" {
  bucket        = module.common_tags.tags["Name"]
  tags          = module.common_tags.tags
  force_destroy = false
  request_payer = "BucketOwner"
  acl           = "private"
}

resource "aws_s3_bucket_public_access_block" "{{ cookiecutter.module_name }}" {
  bucket                  = aws_s3_bucket.{{ cookiecutter.module_name }}.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
{% else -%}
{% set resource_type = {'elb': 'aws_lbs', 'ec2': 'aws_instance',
  'acm': 'aws_acm_certificate', 'cloudfront': 'aws_cloudfront_distribution',
  'lambda': 'aws_lambda_function', 'sg': 'aws_security_group',
  'rds': 'aws_db_instance', 'vpc': 'aws_vpc', 'route53': 'aws_route53_record',
  's3': 'aws_s3_bucket', 'iam': 'aws_iam_policy',
  'standalone': 'aws_instance', 'ses': 'aws_ses_email_identity',
  'ecr': 'aws_ecr_repository'} -%}

# this is just to speed up development, change it at will
resource "{{ resource_type.get(cookiecutter.resource_type) }}" "{{ cookiecutter.module_name }}" {
  name = module.common_tags.tags["Name"]
  tags = module.common_tags.tags
}
{% endif -%}
