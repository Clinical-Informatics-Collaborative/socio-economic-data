#!/bin/bash

#. ./pt-76851-openrc.sh

ansible-playbook -i hosts -u ubuntu --key-file=~/.ssh/wehi_project.pem infra.yaml