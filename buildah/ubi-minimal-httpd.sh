# -l/usr/bin/env bash

set -x

ctr1=$(buildah from "${1:-registry.access.redhat.com/ubi8/ubi-minimal:latest}")

## Get all updates and install our minimal httpd server
buildah run "$ctr1" -- microdnf update -y
buildah run "$ctr1" -- microdnf install -y httpd

## Grab our index.html
buildah copy "$ctr1" ubi-minimal-httpd/index.html /var/www/html

## Include some buildtime annotations
buildah config --annotation "com.example.build.host=$(uname -n)" "$ctr1"

## Run our server and expose the port
buildah config --cmd "/usr/sbin/httpd -DFOREGROUND" "$ctr1"
buildah config --port 80 "$ctr1"

## Commit this container to an image name
buildah commit "$ctr1" "${2:-ubi-minimal-scripted-httpd}"


