resource "aws_iam_user" "github_action" {
  name = "github_action"
  path = "/"
}

resource "aws_iam_access_key" "github_action_key" {
  user = aws_iam_user.github_action.name
}

resource "aws_iam_user_policy" "ecr_policy" {
  name = "ecr_policy"
  user = aws_iam_user.github_action.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability",
        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action":[
        "ecr:GetAuthorizationToken"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "s3:PutObjectAcl",
        "s3:PutObject",
        "s3:GetObjectAcl",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::python-api-helm/*",
        "arn:aws:s3:::python-api-helm"
      ]
    },
    {
      "Action": "s3:ListBucket",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "eks:DescribeCluster", 
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "eks:ListClusters", 
      "Resource": "*"
    }
  ]
}
EOF
}