module "acm_backend" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name = "jebro.dev"
  zone_id     = "b7d259641bf30b89887c943ffc9d2138"

  validation_method = "DNS"

  subject_alternative_names = [
    "*.jebro.dev",
  ]

  create_route53_records  = false
  validation_record_fqdns = [
    "_16fb68b7d202234e68d9516ecf067d2a.jebro.dev",
  ]

  tags = {
    Name = "jebro.dev"
  }
}