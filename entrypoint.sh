#!/bin/bash
mkdir -p ~/.claude
cp -r /claude/* /home/user/.claude  2>/dev/null
cp /home/user/.claude/.claude.json /home/user/
/home/user/.local/bin/claude