#!/bin/bash
# Copy to ~/claude-data/mcp-init.sh on the host (mounted at /claude in the
# container). Sourced by /entrypoint.sh before claude starts.
#
# Use the mcp_add helper - it removes any existing server of the same name
# first, so this stays safe to re-run against the persistent /claude-config
# volume. Anything else you can run in bash works too (exporting env vars,
# reading secrets from /claude, etc).

mcp_add finout --transport http https://mcp.finout.io/mcp

# mcp_add sentry --transport http https://mcp.sentry.dev/mcp
# mcp_add github --transport http https://api.githubcopilot.com/mcp/ \
#   --header "Authorization: Bearer ${GITHUB_MCP_TOKEN}"
# mcp_add my-local-server -- npx -y @scope/some-mcp-server
