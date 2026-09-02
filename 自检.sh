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
test -f docs/订单来了App与MCP能力映射.md
test -f docs/订单来了查询问题模板.md
for skill in hotel-general-manager hotel-front-office hotel-revenue-management hotel-finance-controller hotel-food-beverage hotel-housekeeping-rooms hotel-sales-marketing hotel-digital-operations; do
  test -f "$skill/references/产物模板.md"
  /usr/bin/grep -q '^## 订单来了能力映射$' "$skill/SKILL.md"
done

/usr/bin/grep -q 'mcp__so_agents.so_cli' 共享运行规则.md
for token in mcp__app_capabilities.pms_get_context mcp__app_capabilities.pms_http_request mcp__app_capabilities.execute_skill mcp__app_capabilities.ota_account_list rate.calendar.query order.page.query report.business.query housekeeping.task.query; do
  /usr/bin/grep -q "$token" docs/订单来了App与MCP能力映射.md
done
/usr/bin/grep -q 'hotel-vibe-coder' docs/订单来了App与MCP能力映射.md
/usr/bin/grep -q '数字页面交付' hotel-digital-operations/SKILL.md
test ! -d setup
test ! -d .claude-plugin
test ! -f bin/cli.js

if /usr/bin/grep -RniE 'mcp_servers|setup-[a-z]|oauth|https://mcp\\.' \
  --include='SKILL.md' --include='共享运行规则.md' --include='能力映射.md' .; then
  echo "发现外部连接器配置或 OAuth 接入代码" >&2
  exit 1
fi

echo "订单来了中文酒店技能包自检通过：1 个总入口、8 个岗位技能、参考资料和外部连接器清理均正常。"
