module "free_tier" {
  source  = "dlddu/free-tier/aws"
  version = "0.0.2"

  account_alias            = var.account_alias
  budget_description       = "${var.account_alias} (free tier)"
  subscriber_email_address = var.subscriber_email_address
}

resource "aws_key_pair" "this" {
  key_name   = var.ssh_key_name
  public_key = var.public_key
}

resource "aws_security_group" "this" {
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "this" {
  ami                         = "ami-06f73fc34ddfd65c2"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.this.key_name
  vpc_security_group_ids      = [aws_security_group.this.id]
  user_data_replace_on_change = true
  user_data                   = var.user_data
  iam_instance_profile        = aws_iam_instance_profile.this.name
}

output "public_ip" {
  value = aws_instance.this.public_ip
}
