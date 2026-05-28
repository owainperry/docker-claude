#!/bin/bash
mkdir -p ~/.claude
cp -r /claude/* /home/user/.claude  2>/dev/null
cp /claude/.claude.json /home/user/
cp /claude/.credentials.json /home/user/
/home/user/.local/bin/claude