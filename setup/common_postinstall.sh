#!/bin/bash

# Manage local agent skills
if command -v apm &>/dev/null; then
	echo "Managing APM skills in ..."

    apm install --update --force || true
fi
