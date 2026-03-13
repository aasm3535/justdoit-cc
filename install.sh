#!/usr/bin/env bash
# justdoit-cc installer
# Installs the justdoit slash command for Claude Code

set -e

COMMAND_DIR="$HOME/.claude/commands"
COMMAND_FILE="$COMMAND_DIR/justdoit.md"
RAW_URL="https://raw.githubusercontent.com/destrustor/justdoit-cc/main/commands/justdoit.md"

mkdir -p "$COMMAND_DIR"

if [ -f "$COMMAND_FILE" ]; then
  echo "justdoit already installed at $COMMAND_FILE"
  read -p "Overwrite? [y/N] " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 0
  fi
fi

if command -v curl &> /dev/null; then
  curl -fsSL "$RAW_URL" -o "$COMMAND_FILE"
elif command -v wget &> /dev/null; then
  wget -qO "$COMMAND_FILE" "$RAW_URL"
else
  echo "Error: curl or wget required"
  exit 1
fi

echo "Installed! Use /justdoit in Claude Code."
