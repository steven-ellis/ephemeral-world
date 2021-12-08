#!/bin/bash
#
# This example is pulled from
#  https://www.redhat.com/en/blog/introduction-ubi-micro
#  https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/building_running_and_managing_containers/assembly_types-of-container-images_building-running-and-managing-containers#con_understanding-the-ubi-micro-images_assembly_types-of-container-images
#
# When we're dealing with micro images we need to use a different
# process for constructing the image
#
# This will currently only work on an existing RHEL9-beta host due to entitlement issues
#


microcontainer=$(buildah from registry.access.redhat.com/ubi9-beta/ubi-micro)
micromount=$(buildah mount $microcontainer)
yum install \
    --installroot $micromount \
    --setopt install_weak_deps=false \
    --setopt=reposdir=/etc/yum.repos.d \
    --nodocs -y \
    httpd
yum clean all \
    --installroot $micromount
buildah umount $microcontainer
buildah commit $microcontainer ubi-micro-httpd
