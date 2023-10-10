output "private" {
  value = aws_subnet.private.*.id
}

output "public" {
  value = aws_subnet.private.*.id
}

output "node_role" {
  value = aws_iam_role.nodes.role_arn
}

output "demo_role" {
  value = aws_iam_role.demo.arn
}

