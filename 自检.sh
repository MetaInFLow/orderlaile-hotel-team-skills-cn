#!/bin/sh
set -eu

skills="
hotel-team
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

test -f hotel-team/references/示例酒店经营档案.md
test -f hotel-team/references/调度能力矩阵.md
for skill in hotel-general-manager hotel-front-office hotel-revenue-management hotel-finance-controller hotel-food-beverage hotel-housekeeping-rooms hotel-sales-marketing hotel-digital-operations; do
  test -f "$skill/references/产物模板.md"
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

echo "订单来了中文酒店技能包自检通过：1 个总入口、8 个岗位技能、参考资料和外部连接器清理均正常。"
