#!/bin/bash
chown -R 1000:1000 /claude-config
codebase-memory-mcp config set auto_index true & 
/home/user/.local/bin/claude