data "template_file" "file_contents" {
  template = "${file("${path.cwd}/${var.template_path}")}"
  vars     = "${var.template_vars}"
  count    = "${var.enabled}"
}

resource "aws_s3_bucket_object" "s3_object" {
  bucket  = "${var.s3_bucket}"
  acl     = "private"
  key     = "${var.s3_key}"
  content = "${data.template_file.file_contents.rendered}"
  count   = "${var.enabled}"
}
