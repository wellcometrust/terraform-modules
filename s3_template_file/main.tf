data "template_file" "file_contents" {
  template = "${file("${path.cwd}/${local.template_path}")}"
  vars     = "${var.template_vars}"
}

resource "aws_s3_bucket_object" "s3_object" {
  bucket  = "${var.s3_bucket}"
  acl     = "private"
  key     = "${var.s3_key}"
  content = "${data.template_file.file_contents.rendered}"
  count   = "${var.enabled}"
}
