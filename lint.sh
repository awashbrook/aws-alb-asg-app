#!/bin/sh -x

tflint && checkov -d . && terraform validate && terraform fmt --recursive
