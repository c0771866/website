resource "aws_iam_user" "alice" {
  name = "alice"
}

resource "aws_iam_user" "malory" {
  name = "malory"
}

resource "aws_iam_user" "bobby" {
  name = "bobby"
}

resource "aws_iam_user" "charlie" {
  name = "charlie"
}

resource "aws_iam_policy" "alice_malory_policy" {
  name        = "alice_malory_policy"
  path        = "/"
  description = "Allow Alice and Malory to add content to the /news section"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:PutObject"],
        Resource = ["arn:aws:s3:::my-website-bucket/news/*"]
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "alice_policy_attachment" {
  name       = "alice_policy_attachment"
  users      = [aws_iam_user.alice.name]
  policy_arn = aws_iam_policy.alice_malory_policy.arn
}

resource "aws_iam_policy_attachment" "malory_policy_attachment" {
  name       = "malory_policy_attachment"
  users      = [aws_iam_user.malory.name]
  policy_arn = aws_iam_policy.alice_malory_policy.arn
}

resource "aws_iam_policy" "bobby_policy" {
  name        = "bobby_policy"
  path        = "/"
  description = "Allow Bobby to edit the entire website"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:*"],
        Resource = ["arn:aws:s3:::my-website-bucket/*"]
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "bobby_policy_attachment" {
  name       = "bobby_policy_attachment"
  users      = [aws_iam_user.bobby.name]
  policy_arn = aws_iam_policy.bobby_policy.arn
}

resource "aws_iam_policy" "charlie_policy" {
  name        = "charlie_policy"
  path        = "/"
  description = "Allow Charlie to update /people.html"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:PutObject"],
        Resource = ["arn:aws:s3:::my-website-bucket/people.html"]
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "charlie_policy_attachment" {
  name       = "charlie_policy_attachment"
  users      = [aws_iam_user.charlie.name]
  policy_arn = aws_iam_policy.charlie_policy.arn
}

