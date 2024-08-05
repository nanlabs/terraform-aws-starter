resource "aws_iam_role" "bastion_host_iam_role" {
  name = "${var.name}-bastion-host-iam-role"
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  ]
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })
}

resource "aws_iam_instance_profile" "bastion_instance_profile" {
  name = "${var.name}-bastion-instance-profile"
  role = aws_iam_role.bastion_host_iam_role.name
}

resource "aws_iam_role_policy" "bastion_host_iam_role" {
  name = "${var.name}-bastion-host-iam-role"
  role = aws_iam_role.bastion_host_iam_role.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : ["s3:ListBucket"],
        "Resource" : ["arn:aws:s3:::*"]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ],
        "Resource" : ["arn:aws:s3:::*/*"]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "cloudwatch:PutMetricData",
          "ec2:DescribeVolumes",
          "ec2:DescribeTags",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams",
          "logs:DescribeLogGroups",
          "logs:CreateLogStream",
          "logs:CreateLogGroup"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ssm:GetParameter"
        ],
        "Resource" : "arn:aws:ssm:*:*:parameter/AmazonCloudWatch-*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "secretsmanager:GetSecretValue"
        ],
        "Resource" : "arn:aws:secretsmanager:*:*:secret:*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "eks:ListClusters",
          "eks:DescribeCluster",
          "eks:ListNodegroups",
          "eks:DescribeNodegroup",
          "eks:AccessKubernetesApi"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_policy" "ec2_instance_connect_policy" {
  name = "${var.name}-ec2-instance-connect-policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "ec2-instance-connect:SendSSHPublicKey",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "bastion_host_instance_connect_policy_attachment" {
  role       = aws_iam_role.bastion_host_iam_role.name
  policy_arn = aws_iam_policy.ec2_instance_connect_policy.arn
}
