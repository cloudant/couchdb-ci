#!/usr/bin/env bash

# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing,
#   software distributed under the License is distributed on an
#   "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
#   KIND, either express or implied.  See the License for the
#   specific language governing permissions and limitations
#   under the License.

# This shell script installs Erlang dependencies for Apache
# CouchDB 2.x for yum-based systems.
#
# While these scripts are primarily written to support building CI
# Docker images, they can be used on any workstation to install a
# suitable build environment.

# stop on error
set -e

# Check if running as root
if [[ ${EUID} -ne 0 ]]; then
  echo "Sorry, this script must be run as root."
  echo "Try: sudo $0 $*"
  exit 1
fi

# TODO: Do the Right Things(tm) for Fedora
if [[ ${ERLANGVERSION} == "default" ]]; then
  yum install -y erlang
else
  wget https://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm
  rpm -Uvh erlang-solutions-1.0-1.noarch.rpm
  yum install -y esl-erlang-${ERLANGVERSION}
fi

# clean up
yum clean all -y
