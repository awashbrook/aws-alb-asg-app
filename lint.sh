#!/bin/sh -x

tflint && checkov -d . -s --framework terraform && terraform validate && terraform fmt --recursive
