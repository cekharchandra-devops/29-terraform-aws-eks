module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = local.resource_name
  ami = data.aws_ami.ami_info.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.bastion_sg]
  subnet_id              = local.public_subnet_id
  user_data = templatefile("workstation.sh.tpl", {
    aws_access_key_id     = local.aws_credentials.aws_access_key_id,
    aws_secret_access_key = local.aws_credentials.aws_secret_access_key,
    aws_region            = var.aws_region,
  })

  tags = merge(
    var.common_tags,
    var.bastion_tags,
    {
        Name = "${local.resource_name}-bastion"
    }
  )
}