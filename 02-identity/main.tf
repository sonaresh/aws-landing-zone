# Permission boundaries as managed policies (attach to roles you create for teams)

resource "aws_iam_policy" "boundary_workload" {
  name        = "${var.org}-${var.program}-boundary-workload"
  description = "Workload permission boundary (starter, adjust to your needs)"
  policy      = file("${path.module}/permission-boundaries/workload-boundary.json")
  tags        = local.common_tags
}

resource "aws_iam_policy" "boundary_sandbox" {
  name        = "${var.org}-${var.program}-boundary-sandbox"
  description = "Sandbox permission boundary (starter, cost-aware)"
  policy      = file("${path.module}/permission-boundaries/sandbox-boundary.json")
  tags        = local.common_tags
}

# Break-glass role (optional; keeps assume policy explicit)
data "aws_iam_policy_document" "breakglass_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = length(var.breakglass_principal_arns) > 0 ? var.breakglass_principal_arns : ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

data "aws_caller_identity" "current" {}

resource "aws_iam_role" "breakglass" {
  name               = "${var.org}-${var.program}-breakglass"
  description        = "Emergency admin role (lock down assume principals)"
  assume_role_policy = data.aws_iam_policy_document.breakglass_assume.json
  tags               = local.common_tags
}

resource "aws_iam_role_policy_attachment" "breakglass_admin" {
  role       = aws_iam_role.breakglass.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Audit read-only role
data "aws_iam_policy_document" "audit_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

resource "aws_iam_role" "audit_readonly" {
  name               = "${var.org}-${var.program}-audit-readonly"
  description        = "Read-only audit role (starter)"
  assume_role_policy = data.aws_iam_policy_document.audit_assume.json
  tags               = local.common_tags
}

resource "aws_iam_role_policy_attachment" "audit_readonly_attach" {
  role       = aws_iam_role.audit_readonly.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}
