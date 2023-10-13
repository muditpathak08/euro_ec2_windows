locals {
  # enabled        		 = module.this.enabled
  volume_count = var.ebs_volume_count
  # security_group_enabled = module.this.enabled && var.security_group_enabled
  root_iops        = contains(["io1", "io2", "gp3"], var.root_volume_type) ? var.root_iops : null
  ebs_iops         = contains(["io1", "io2", "gp3"], var.ebs_volume_type) ? var.ebs_iops : null
  root_throughput  = var.root_volume_type == "gp3" ? var.root_throughput : null
  ebs_throughput   = var.ebs_volume_type == "gp3" ? var.ebs_throughput : null
  root_volume_type = var.root_volume_type
  root_volume_size = var.root_volume_size
}


data "aws_iam_policy_document" "default" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    effect = "Allow"
  }
}
# data "aws_ami" "info" {
#   count = var.root_volume_type != "" ? 0 : 1

#   filter {
#     name   = "image-id"
#     values = [var.ImageId]
#   }

#   owners = [var.OperatingSystem]  
# }


data "aws_ami" "info" {
  most_recent = true

  filter {
    name = "name"
    values = ["Windows_Server-2022-*Base*"]
  }

  # filter {
  #   name = "Virtualization"
  #   values = ["hvm"]
  # }

  owners = ["amazon"]
}

resource "aws_iam_role" "default" {
  name                 = var.role_Name
  path                 = "/"
  assume_role_policy   = data.aws_iam_policy_document.default.json
  # permissions_boundary = var.permissions_boundary_arn
  # tags                 = var.tags
}

resource "aws_instance" "default" {
  ami                                  = data.aws_ami.info.id
  availability_zone           = var.availability_zone
  instance_type               = var.InstanceType
  ebs_optimized               = var.ebs_optimized
  disable_api_termination     = true
  associate_public_ip_address = true
  # iam_instance_profile                 = var.InstanceProfileName
  # key_name                             = var.KeyName
  subnet_id  = var.SubnetId
  monitoring = var.monitoring
  # vpc_security_group_ids = 
  #   concat(
  #     formatlist("%s", module.security_group.id),
  #     var.security_groups
  #)
  # root disk
  root_block_device {
    volume_type           = local.root_volume_type
    volume_size           = local.root_volume_size
    iops                  = local.root_iops
    throughput            = local.root_throughput
    delete_on_termination = false
    encrypted             = true
    # kms_key_id            = var.root_block_device_kms_key_id
  }

  #  depends_on = [ aws_security_group.module.security_group]
  tags = var.my_tags
}



resource "aws_ebs_volume" "default" {
  count             = local.volume_count
  availability_zone = var.availability_zone
  size              = var.ebs_volume_size
  iops              = local.ebs_iops
  throughput        = local.ebs_throughput
  type              = var.ebs_volume_type
  tags              = var.my_tags
  encrypted =       var.ebs_volume_encrypted
  # kms_key_id        = var.kms_key_id
}

resource "aws_volume_attachment" "default" {
  count       = local.volume_count
  device_name = var.ebs_device_name[count.index]
  volume_id   = aws_ebs_volume.default[count.index].id
  instance_id = aws_instance.default.id
}