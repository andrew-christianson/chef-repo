#!/usr/bin/env bash
ssh -o "StrictHostKeyChecking=no" -i "/root/.ssh/gh_rsa" $1 $2
