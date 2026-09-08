#!/bin/bash
CLAUDE_BIN=/home/user/.local/bin/claude

# Bash script, mounted in from the host, that registers MCP servers.
MCP_INIT_SCRIPT="${MCP_INIT_SCRIPT:-/claude/mcp-init.sh}"

# Idempotent helper for init scripts: /claude-config is a persistent volume, so
# a plain `claude mcp add` fails on the second run. Drop any existing server of
# the same name first.
#   mcp_add finout --transport http https://mcp.finout.io/mcp
mcp_add() {
  local name="$1"; shift
  "$CLAUDE_BIN" mcp remove "$name" >/dev/null 2>&1
  "$CLAUDE_BIN" mcp add "$name" "$@"
}

chown -R 1000:1000 /claude-config 2>/dev/null
codebase-memory-mcp config set auto_index true &

if [[ -f "$MCP_INIT_SCRIPT" ]]; then
  echo "entrypoint: loading MCP servers from $MCP_INIT_SCRIPT"
  # sourced (not executed) so the script can use mcp_add and needs no +x bit
  source "$MCP_INIT_SCRIPT"
else
  echo "entrypoint: no MCP init script at $MCP_INIT_SCRIPT - skipping"
fi

exec "$CLAUDE_BIN" --permission-mode auto "$@"
