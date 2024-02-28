# syntax=docker/dockerfile:1

# base image
FROM ubuntu:22.04

# set timezone
ENV TZ=Europe/Berlin

# prevent keyboard input requests in apt install
ARG DEBIAN_FRONTEND=noninteractive

# install core packages
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y python3 git

# for pdf, copied from scripts/install_requirements_pdf.sh
RUN apt-get install -y texlive-xetex texlive-lang-german latexmk
# for ebook, copied from scripts/install_requirements_ebook.sh
RUN apt-get install -y texlive-extra-utils pandoc calibre imagemagick ghostscript

# set working directory
WORKDIR /app

# mount host directory as volume
VOLUME /app

# default command: build 1-vol pdf and all ebook formats
# CMD latexmk hpmor ; ./scripts/make_ebooks.sh

# 1. preparation
# 1.1 build/update image from Dockerfile
#  docker build -t hpmor

# 1.2 create container that mounts current working dir to /app
#  docker run --name hpmor-de -it --mount type=bind,src="$(pwd)",dst=/app hpmor bash
#  exit

# note: in Windows you need to replace "$(pwd)" by "%cd%" for the following commands

# 2. use container
#  docker start -ai hpmor-de
#  latexmk hpmor ; ./scripts/make_ebooks.sh
#  exit

# 3. optionally: cleanup/delete hpmor from docker
# delete container
#  docker rm hpmor-de
# delete image
#  docker rmi hpmor
