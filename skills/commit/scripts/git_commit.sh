#!/usr/bin/env bash
# Strips comment lines and scissors section from /tmp/commit_msg.txt, then commits.
set -euo pipefail

sed '/^# ---.*>8.*---/,$d; /^#/d' /tmp/commit_msg.txt | git commit -F -
