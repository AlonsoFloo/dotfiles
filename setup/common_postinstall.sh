#!/bin/bash

# Manage local agent skills
if command -v apm &>/dev/null; then
	echo "Managing APM skills ..."

    apm install -g https://github.com/AlonsoFloo/skills#main --update --force --target agent-skills || true
fi
