# variable "ssh_key_pair" {
#   type        = string
#   description = "SSH key pair to be provisioned on the instance"
#   default     = null
# }

variable "associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address with the instance"
  default     = false
}

variable "assign_eip_address" {
  type        = bool
  description = "Assign an Elastic IP address to the instance"
  default     = true
}

variable "InstanceType" {
  type        = string
  description = "The type of the instance"
  default     = "t2.micro"
}


variable "vpc_id" {
  type        = string
  description = "The ID of the VPC that the instance security group belongs to"
  default     = "vpc-0beff1ce4c238d689"
}

variable "security_group_enabled" {
  type        = bool
  description = "Whether to create default Security Group for EC2."
  default     = true
}

variable "security_groups" {
  description = "A list of Security Group IDs to associate with EC2 instance."
  type        = list(string)
  default     = []
}

variable "security_group_description" {
  type        = string
  default     = "EC2 Security Group"
  description = "The Security Group description."
}

variable "security_group_use_name_prefix" {
  type        = bool
  default     = false
  description = "Whether to create a default Security Group with unique name beginning with the normalized prefix."
}

variable "security_group_rules" {
  type = list(any)
  default = [
    {
      type        = "egress"
      from_port   = 8084
      to_port     = 8084
      protocol    = "-1"
      cidr_blocks = ["192.168.161.215/32"]
      description = "Allow all outbound traffic"
    }

  ]
  # description = 
}

variable "SubnetId" {
  type        = string
  description = "VPC Subnet ID the instance is launched in"
  default     = "subnet-0e0f857de5f148459"
}

variable "region" {
  type        = string
  description = "AWS Region the instance is launched in"
  default     = ""
}

variable "availability_zone" {
  type        = string
  description = "Availability Zone the instance is launched in. If not set, will be launched in the first AZ of the region"
  default     = "us-east-2a"
}

variable "ami" {
  type        = string
  description = "The AMI to use for the instance. By default it is the AMI provided by Amazon with Ubuntu 16.04"
  default     = ""
}

variable "ami_owner" {
  type        = string
  description = "Owner of the given AMI (ignored if `ami` unset, required if set)"
  default     = ""
}

variable "ebs_optimized" {
  type        = bool
  description = "Launched EC2 instance will be EBS-optimized"
  default     = true
}

variable "disable_api_termination" {
  type        = bool
  description = "Enable EC2 Instance Termination Protection"
  default     = false
}

variable "monitoring" {
  type        = bool
  description = "Launched EC2 instance will have detailed monitoring enabled"
  default     = true
}

variable "private_ip" {
  type        = string
  description = "Private IP address to associate with the instance in the VPC"
  default     = null
}


variable "root_volume_type" {
  type        = string
  description = "Type of root volume. Can be standard, gp2, gp3, io1 or io2"
  default     = "gp2"
}

variable "root_volume_size" {
  type        = number
  description = "Size of the root volume in gigabytes"
  default     = 30
}

variable "root_iops" {
  type        = number
  description = "Amount of provisioned IOPS. This must be set if root_volume_type is set of `io1`, `io2` or `gp3`"
  default     = 0
}

variable "root_throughput" {
  type        = number
  description = "Amount of throughput. This must be set if root_volume_type is set to `gp3`"
  default     = 0
}

variable "ebs_device_name" {
  type        = list(string)
  description = "Name of the EBS device to mount"
  default     = ["/dev/xvdb", "/dev/xvdc", "/dev/xvdd", "/dev/xvde", "/dev/xvdf", "/dev/xvdg", "/dev/xvdh", "/dev/xvdi", "/dev/xvdj", "/dev/xvdk", "/dev/xvdl", "/dev/xvdm", "/dev/xvdn", "/dev/xvdo", "/dev/xvdp", "/dev/xvdq", "/dev/xvdr", "/dev/xvds", "/dev/xvdt", "/dev/xvdu", "/dev/xvdv", "/dev/xvdw", "/dev/xvdx", "/dev/xvdy", "/dev/xvdz"]
}

variable "ebs_volume_type" {
  type        = string
  description = "The type of the additional EBS volumes. Can be standard, gp2, gp3, io1 or io2"
  default     = "gp2"
}

variable "ebs_volume_size" {
  type        = number
  description = "Size of the additional EBS volumes in gigabytes"
  default     = 30
}

variable "ebs_volume_encrypted" {
  type        = bool
  description = "Whether to encrypt the additional EBS volumes"
  default     = true
}

variable "ebs_iops" {
  type        = number
  description = "Amount of provisioned IOPS. This must be set with a volume_type of `io1`, `io2` or `gp3`"
  default     = 0
}

variable "ebs_throughput" {
  type        = number
  description = "Amount of throughput. This must be set if volume_type is set to `gp3`"
  default     = 0
}

variable "ebs_volume_count" {
  type        = number
  description = "Count of EBS volumes that will be attached to the instance"
  default     = 1
}

variable "delete_on_termination" {
  type        = bool
  description = "Whether the volume should be destroyed on instance termination"
  default     = true
}


variable "role_Name" {
  type        = string
  description = "Name of the Role to be assumed"
  default     = "EuroGroup_AWS_TFC"
}

variable "my_tags" {
  default = {
    BackupSchedule             = "DR1y"
    BusinessOwner              = "test@hotstar.com"
    BusinessTower              = "test@hotstar.com"
    InstanceIP                 = "10.33.21.25"
    Name                       = "SSB-WPX-001-P"
    OperatingSystem            = "Windows Server 2022"
    OperatingSystemSupportTeam = "test@hotmail.com"
    scheduler                  = "ec2-startstop"
    ServerProcess              = "service MS "
    ServerRoleType             = "Application"
    ServiceCriticality         = "High"
    Subnet-id                  = "subnet-0e0f857de5f148459"
    VPC-id                     = "vpc-0beff1ce4c238d689"
    TicketReference            = "CHG0050760"
    DNSEntry                   = "csdasd"
    DesignDocumentLink         = "acbv"
  }
  description = "Tags for Auto Scaling Group"
  type        = map(string)
}

