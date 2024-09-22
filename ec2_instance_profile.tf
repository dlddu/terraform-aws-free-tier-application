data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "this" {
  name               = "${var.application_name}-service-role"
  assume_role_policy = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy" "this" {
  name = "AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.id
  policy_arn = data.aws_iam_policy.this.arn
}

resource "aws_iam_instance_profile" "this" {
  name = var.application_name
  role = aws_iam_role.this.name
}
