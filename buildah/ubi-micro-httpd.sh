#!/bin/bash
#
# This example is pulled from
#  https://www.redhat.com/en/blog/introduction-ubi-micro
#  https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/building_running_and_managing_containers/assembly_types-of-container-images_building-running-and-managing-containers#con_understanding-the-ubi-micro-images_assembly_types-of-container-images
#
# When we're dealing with micro images we need to use a different
# process for constructing the image
#


microcontainer=$(buildah from registry.access.redhat.com/ubi8/ubi-micro)
micromount=$(buildah mount $microcontainer)
yum install \
    --installroot $micromount \
    --nogpgcheck \
    --releasever 8 \
    --setopt install_weak_deps=false \
    --nodocs -y \
    httpd
yum clean all \
    --installroot $micromount
buildah umount $microcontainer
buildah commit $microcontainer ubi-micro-httpd
