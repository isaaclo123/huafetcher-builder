FROM --platform=linux/amd64 ubuntu:22.04
#FROM ubuntu

# Disable download progress logging for buildozer
ENV CI=1

RUN set -eux \
  ; apt-get update -yqq \
  ; DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git zip unzip openjdk-17-jdk python3-pip autoconf libtool pkg-config zlib1g-dev libncurses5-dev libncursesw5-dev libtinfo5 cmake libffi-dev libssl-dev \
  ; useradd -ms /bin/bash buildozer

RUN set -eux \
  ; pip3 install \
    buildozer \
    kivy \
    Cython==0.29.33

USER buildozer
