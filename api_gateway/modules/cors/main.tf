# Copyright (c) 2018 Martin Donath <martin.donath@squidfunk.com>

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.

resource "aws_api_gateway_integration_response" "cors" {
  rest_api_id = "${var.api_id}"
  resource_id = "${var.api_resource_id}"
  http_method = "${var.http_method}"
  status_code = 200

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'${join(",", var.allowed_headers)}'"
    "method.response.header.Access-Control-Allow-Methods" = "'${join(",", var.allowed_methods)}'"
    "method.response.header.Access-Control-Allow-Origin"  = "'${var.allowed_origin}'"
    "method.response.header.Access-Control-Max-Age"       = "'${var.allowed_max_age}'"

    "method.response.header.Content-Type" = "integration.response.header.Content-Type"
  }

  depends_on = ["aws_api_gateway_method_response.cors"]
}

resource "aws_api_gateway_method_response" "cors" {
  rest_api_id = "${var.api_id}"
  resource_id = "${var.api_resource_id}"
  http_method = "${var.http_method}"
  status_code = 200

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Max-Age"       = true

    "method.response.header.Content-Type" = true
  }
}
