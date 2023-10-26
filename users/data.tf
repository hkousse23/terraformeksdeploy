data "aws_iam_policy_document" "developer" {
  statement {
    sid    = "AllowDeveloper"
    effect = "Allow"
    actions = [
      "eks:DescribeNodegroup",
      "eks:ListNodegroups",
      "eks:DescribeCluster",
      "eks:ListClusters",
      "eks:AccessKubernetesApi",
      "eks:GetParameter",
      "eks:ListUpdates",
      "eks:ListFargateProfiles"

    ]
    resources = ["*"]

  }

}
/*
data "aws_iam_policy_document" "admin" {
  statement {
    sid       = "AllowAdmin"
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }

  statement {
    sid       = "AllowPassRole"
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values   = ["eks.amazonaws.com"]

    }
  }
}

data "aws_iam_policy_document" "manager_assume_role" {
  statement {
    sid     = "AllowManagerAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/manager"] #make sure to put :: after Iam to avoid malformed policy
    }
  }

} */

data "aws_iam_policy_document" "masters" {
  statement {
    sid       = "AllowAdmin"
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }

  statement {
    sid       = "AllowPassRole"
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values   = ["eks.amazonaws.com"]

    }
  }
}

data "aws_iam_policy_document" "masters_assume_role" {
  statement {
    sid     = "AllowManagerAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }
  }

}

data "aws_iam_policy_document" "masters_role" {
  statement {
    sid     = "AllowManagerAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    /*principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/Masters-eks-role"]  #this principals line is inacceptable for policy so the work around is in the next line
    } */

    resources = [ "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/Masters-eks-role" ] # This looks like a regular policy
  }

}


data "aws_caller_identity" "current" {}