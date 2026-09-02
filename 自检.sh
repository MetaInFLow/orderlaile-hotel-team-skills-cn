#!/bin/sh
set -eu

skills="
hotel-general-manager
hotel-front-office
hotel-revenue-management
hotel-finance-controller
hotel-food-beverage
hotel-housekeeping-rooms
hotel-sales-marketing
hotel-digital-operations
"

for skill in $skills; do
  file="$skill/SKILL.md"
  test -f "$file"
  /usr/bin/grep -q '^name: ' "$file"
  /usr/bin/grep -q '^description: ' "$file"
done

/usr/bin/grep -q 'mcp__so_agents.so_cli' 共享运行规则.md
test ! -d setup
test ! -d .claude-plugin
test ! -f bin/cli.js

if /usr/bin/grep -RniE 'mcp_servers|setup-[a-z]|oauth|https://mcp\\.' \
  --include='SKILL.md' --include='共享运行规则.md' --include='能力映射.md' .; then
  echo "发现外部连接器配置或 OAuth 接入代码" >&2
  exit 1
fi

echo "订单来了中文技能包自检通过：8 个技能、公共规则和外部连接器清理均正常。"
