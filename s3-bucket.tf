resource "random_integer" "bucket_suffix" {
    min = 1000
    max = 9999
}

resource "aws_s3_bucket" "my_bucket" {
    bucket = "tableflow-bucket-sami"

    tags = {
        Name = "tableflow-bucket-sami"
    }
    force_destroy = true
}