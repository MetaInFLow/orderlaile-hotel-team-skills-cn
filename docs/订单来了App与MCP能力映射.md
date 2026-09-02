# 订单来了 App 与 MCP 能力映射

> 状态：中文酒店 Skill 的运行时能力基线
> 来源：订单来了 App 一级/二级功能清单、订单来了 PMS/MCP 能力清单
> 清单读取时间：2026-08-19；本仓库映射更新：2026-09-02
> 事实边界：下列 109 个 action 是来源清单已确认的动作名称；实际可用性仍受当前会话工具、门店权限和接口返回影响。

## 三个判断

1. App 页面是用户可见的业务入口，不能单独证明当前 MCP 有对应的可调用接口。
2. 只查一个字段、只看一个页面或只执行订单来了已有的单点操作，直接使用订单来了原生入口；跨模块分析、比较、预测、复盘、决策和管理层产物，才进入酒店团队 Skill。
3. Skill 内部使用 action 组做路由依据，提交给 `mcp__so_agents.so_cli` 的仍然必须是完整中文自然语言问题，不把 action 名称当作用户问题或自行拼装接口参数。

## 工具选择

| 工具 | 用途 | 允许范围 | 禁止事项 |
|---|---|---|---|
| `mcp__so_agents.so_cli` | PMS 经营数据、订单、房价、库存、房态、客户、员工、权限、房务和报表查询/维护 | 以本文件的 action 组做能力校验；按工具返回结果执行 | 不凭记忆编造数据、ID 或 action；写入必须预览确认 |
| `mcp__app_capabilities.pms_get_context` | 读取登录上下文、当前门店/网络和 baseUrl | 仅用于补齐上下文；输出不回显 token | 不把 token、完整 baseUrl 或凭证写入回复和产物 |
| `mcp__app_capabilities.pms_http_request` | 已定义 Skill 的底层编排、跨店门店列表 | 只有技能明确要求或确实需要跨店编排时使用 | 不替代 `so_cli` 查询经营数据，不绕过业务 action |
| `mcp__app_capabilities.execute_skill` | 执行已注册的 Smart-Order 业务 Skill | 先确认 Skill 已注册且属于当前任务 | 不把未知或未注册 Skill 当作可用能力 |
| `mcp__app_capabilities.ota_account_list` | 查询携程、美团、飞猪、Booking、Agoda、Airbnb 等 OTA 账号状态 | 只读账号登录/授权状态 | 不代替 OTA 订单、点评、活动或价格操作 |

## App 页面路由

| App 一级入口 | 典型页面/对象 | 酒店 Skill 路由 | MCP 事实边界 |
|---|---|---|---|
| 首页 | 日历房态、房情表、房价管理、营业总览、流水汇总、夜审、今日预抵/预离、未排房、异常订单 | 总经理、前厅、营收、财务 | 依据订单、房态、房价、库存和报表 action 取数 |
| 住宿 | 房态、房价、房情表、房态表、早餐核销、房务、房东 | 前厅、营收、客房、餐饮 | 房务和房态 action 已列出；页面存在不等于所有设置都有 MCP action |
| 多业态 | 餐饮、商超、娱乐、场地 | 餐饮、数字运营、总经理 | 当前 action 清单未列出完整的餐厅/桌台/菜品/娱乐/场地写入接口，按实际工具 schema 或人工页面处理 |
| 渠道 | 渠道列表、价格关联、渠道超售、账号、定时同步价库 | 营收、销售营销、数字运营 | 渠道列表和账号状态可查；签约、绑定、映射、定时同步不默认承诺 MCP 写入 |
| 订单 | 订单概览、住宿/餐饮/商超/娱乐/场地/营销订单、前台收支 | 前厅、财务、餐饮、总经理 | 住宿订单及通用订单 action 已确认；其他业态按实际返回判断 |
| AI | 智能定价、智能评价、自动化对账、AI 报表、AI 直播、小红书笔记、AI 私域运营 | 营收、财务、销售营销、数字运营 | 页面和 AI Skill 可见；技能市场、快捷指令管理、营销/SCRM 配置没有完整 MCP action |
| 营销 | 店铺管理、日历房、预售券、实物/娱乐商品、分销、活动、门店信息、图片中心 | 销售营销、数字运营 | 客户券类 action 已确认；店铺、活动、分销、图片等完整写入接口未在 109 个 action 中列出 |
| 客户 | 客户、企业客户、AR、会员、会员卡、优惠券、储值、短信、自动化消息 | 销售营销、财务、前厅 | 客户/会员/券/AR 查询 action 已确认；短信和自动化消息不默认承诺 MCP 写入 |
| SCRM | 微信客户/群、获客、客户沟通、统计、企业管理 | 销售营销、数字运营 | 当前 MCP 清单没有完整 SCRM 操作接口，按人工页面或用户提供数据处理 |
| 统计 | 数据中心、经营/住宿/餐饮/商超/娱乐/场地/财务/会员/业绩报表 | 总经理、财务、营收、数字运营 | 经营、住宿、集团、销售、会员和财务 action 已确认；报表字段以实际返回为准 |
| 设置 | 房型、房间、房价计划、钟点房、早餐、消费项、账号、角色、收款、开票、通用设置 | 营收、前厅、客房、餐饮、财务、数字运营 | 部分设置 action 已确认；硬件、打印、客户端设置等不默认承诺 MCP |

## AI 工作台与快捷指令路由

AI 能力清单快照记录了 86 个 Skill 市场条目、64 个快捷指令模板和 0 个“我的指令”。这些名称用于识别用户意图，实际调用前必须确认 Skill 已注册、账号已授权且属于当前任务。

| 用户入口/意图 | 优先路由 | 执行边界 |
|---|---|---|
| “今天营业额”“今日入住率”“上周经营情况”“订单异动”等 PMS 快捷指令 | `mcp__so_agents.so_cli`，按 `report.*`、`order.*`、`finance.*` 路由 | 快捷指令是自然语言入口；日期、门店和统计口径仍需补齐，写入仍须确认 |
| 房价策略、活动日历、收益自动化编排 | 营收 Skill；已注册时调用 `mcp__app_capabilities.execute_skill`，数据依据仍回到 `so_cli` | “待安装”或未注册时只输出策略和人工步骤，不声称自动巡检或改价完成 |
| 携程/飞猪巡店、点评、OTA 诊断、竞品采集 | 销售营销 Skill；已注册时调用 `execute_skill`，并先检查 `ota_account_list` | 账号状态不等于已完成巡店、点评回复、活动或价格操作 |
| 小红书、直播、朋友圈、酒店推广文案、表格分析和会议整理 | 销售营销或数字运营；在当前工作区生成内容/文件 | 不自动发布外部平台，不把生成草稿写成已发布 |

来源清单中的 `酒店收益自动化编排器`、`活动日历与房价策略助手`、`携程CLI运营助手`、`飞猪巡店助手`、`携程点评倒查订单小助手`、`酒店OTA诊断方案` 和 `携程外网数据抓取`可作为意图识别参考；名称和安装状态以当前 Skill 注册结果为准。

## 已确认的 109 个 so_cli action

### 房价 / 价格码 / 库存（16）

`rate.calendar.query`、`rate.batch_update`、`rate.rule_update`、`rate.change_log.query`、`rate_code.page.query`、`rate_code.detail.query`、`rate_code.tree.query`、`rate_code.enable_disable`、`rate_code.delete`、`rate_code.channel_mapping.query`、`inventory.local.query`、`inventory.channel.query`、`inventory.oversell.query`、`inventory.channel.update`、`inventory.oversell.update`、`inventory.change_log.query`

查询当前房价、价格码、渠道关联、本地/渠道/超售库存和变更日志；批量改价、规则、价格码启停/删除、渠道库存和超售规则属于写入。

### 订单与导入（19）

`order.page.query`、`order.summary.query`、`order.detail.query`、`order.stay.page.query`、`order.stay.summary.query`、`order.cashier_flow.query`、`order.operation_log.query`、`order.account.query`、`order.channel_detail.query`、`order.create`、`order.edit`、`order.cancel`、`order.assign_room`、`order.check_in`、`order.check_out`、`order.no_show`、`order_import.template.get`、`order_import.import`、`order_import.result.query`

查询订单、住宿、账目、流水和操作日志；创建、编辑、取消、排房、入住、退房、NoShow 和订单导入属于写入或高风险动作。

### 客户 / 渠道 / 房型 / 房间（26）

`customer.page.query`、`customer.detail.query`、`customer.member_card.query`、`customer.presale_coupon.query`、`customer.coupon.query`、`customer.level_rule.query`、`channel.list.query`、`channel.source_options.query`、`channel.company_options.query`、`room_type.list.query`、`room_type.detail.query`、`room_type.create`、`room_type.update`、`room_type.delete`、`room.list.query`、`room.detail.query`、`room.create`、`room.update`、`room.delete`、`room_status.query`、`room_status.open`、`room_status.close`、`room_clean.query`、`room_clean.mark_dirty`、`room_clean.mark_clean`、`consume_item.tree.query`

查询客户、会员、券、渠道、房型、房间、房态、脏净状态和消费项目；房型、房间、房态和脏净状态变更属于写入。

### 员工 / 权限 / 交接班（20）

`user.page.query`、`user.detail.query`、`user.create`、`user.update`、`user.delete`、`user.enable_disable`、`auth.permission_tree.query`、`auth.role.list.query`、`auth.role.permission.query`、`auth.role.create`、`auth.role.update`、`auth.role.delete`、`auth.user_role.set`、`auth.user_permission.set`、`workshift.template.query`、`workshift.setting.query`、`workshift.setting.update`、`workshift.template.create`、`workshift.template.update`、`workshift.template.delete`

查询员工、角色、权限、班次和交接班设置；员工、角色、权限和班次的新增、编辑、删除、启停、分配和全量设置属于高风险写入。

### 报表 / 财务 / 钱包（11）

`report.business.query`、`report.accommodation.query`、`report.group_metrics.query`、`report.sales_performance.query`、`report.member.query`、`finance.flow.query`、`finance.cashier.query`、`finance.ar.query`、`finance.invoice.query`、`wallet.balance.query`、`wallet.withdraw.query`

查询营业、住宿、集团、销售、会员、财务流水、收银、AR、发票、钱包余额和提现记录；当前清单未确认发起提现的写入 action。

### 房务 / 集团 / 设置（17）

`housekeeping.task.query`、`housekeeping.task.create`、`housekeeping.task.update`、`housekeeping.task.delete`、`group.store.page.query`、`group.setting.query`、`group.setting.update`、`setting.frontdesk.query`、`setting.frontdesk.update`、`setting.room_consume.query`、`setting.room_consume.create_update`、`setting.breakfast.query`、`setting.breakfast.update`、`setting.night_audit.query`、`setting.night_audit.update`、`setting.hour_room.query`、`setting.hour_room.update`

查询房务任务、集团门店、集团设置、前台、客房消费、早餐、夜审和钟点房设置；房务、集团和设置类 create/update/delete 属于写入。

## 岗位 action 路由

| Skill | 首选 App 页面 | 首选 action 组 | 主要产物 |
|---|---|---|---|
| `hotel-general-manager` | 首页、统计、订单、住宿 | 报表/财务 + 订单/房态 + 按需调用各岗位 action 组 | 日报、周报、风险台账、经营决策、业主简报 |
| `hotel-front-office` | 首页预抵/预离/未排房、住宿、订单、客户 | 订单与导入 + 客户/房间 + 房态/脏净 | 到店简报、排房建议、走房清单、前厅交班 |
| `hotel-revenue-management` | 首页房价/房态、住宿、渠道、AI 智能定价、统计 | 房价/价格码/库存 + 报表/住宿 + 渠道查询 | 房价建议、库存策略、团队置换、90 天预测 |
| `hotel-finance-controller` | 首页营业/流水/夜审、订单前台收支、客户 AR、统计财务、设置收款/开票 | 订单账目/流水 + 报表/财务/钱包 | 收入审计、OTA 对账、月度经营报表、AR/AP、现金流 |
| `hotel-food-beverage` | 多业态餐饮、餐饮订单、住宿早餐、统计餐饮、餐饮设置 | 报表/营业 + 订单通用查询 + 早餐/消费项/房务设置 | 早餐预测、BEO、菜单/成本分析、餐饮协同 |
| `hotel-housekeeping-rooms` | 住宿房态/房务、首页房情、统计住宿 | 房务/设置 + 房间/房态/脏净 | 周转表、质检、工程工单、物资与停用房风险 |
| `hotel-sales-marketing` | 渠道、营销、客户、SCRM、AI 评价/内容、统计业绩/会员 | 客户/会员/券 + 渠道查询 + 销售/会员报表 + OTA 账号状态 | 团队销售、RFP、营销计划、渠道/点评复盘 |
| `hotel-digital-operations` | 首页、AI、营销、统计、设置、本地网页/看板 | 报表/全域查询 + 跨店编排 + 本地产物 | 看板、跨模块报告、内容治理、导出、本地页面和交付 |
| `hotel-team` | 先识别页面和业务对象，再路由岗位 | `pms_get_context` → `so_cli` → 必要时其他已授权工具 | 路由、交接、跨岗位管理层产物 |

## 英文基线岗位覆盖

英文基线中的 `hotel-vibe-coder` 在中文包中并入 `hotel-digital-operations`，覆盖酒店网站内容、活动落地页、业主/资产管理看板、新闻稿页面和预订引导页面的本地交付。中文包只生成当前工作区内可预览的 HTML、页面规格或内容数据；外部部署、Vercel、GitHub 仓库、Booking Engine 实际接入、第三方分析和邮件表单不在当前运行边界内。

## 当前不可直接承诺

- 技能市场、快捷指令管理、算力充值和渠道账号管理页面没有完整 MCP 管理 action。
- 渠道签约、绑定、映射、定时同步价库没有在 109 个 action 中列出完整写入接口。
- 营销店铺、活动、分销、图片中心、SCRM、短信、自动化消息、硬件、打印和客户端设置没有在 109 个 action 中列出完整写入接口。
- 餐饮桌台、菜品、套餐、娱乐和场地页面可见，但本清单没有列出完整专用写入 action；调用工具返回不支持时，转为人工页面或用户提供文件。
- OTA 巡店、点评、竞品、STR、投放和外部渠道数据依赖已注册 Skill、账号授权、页面上下文或用户文件；账号状态可通过 `ota_account_list` 查询，不能据此声称已经完成 OTA 操作。

## 执行与验收

1. 首次查询前确认当前门店和登录上下文；缺失时调用 `pms_get_context`，不得输出凭证。
2. 只读查询按工具返回的实际业务数据输出；只返回“成功”而没有数据，标记为未完成。
3. 所有写入先查现状、唯一定位、展示范围和影响，取得明确确认后执行；执行后重新查询复核。
4. 失败、超时、部分失败、导入失败或接口不支持时停止，不自动重试，不把页面存在或接口成功包装成业务完成。
5. action 清单用于能力判断和路由，不替代当前会话的真实工具 schema、门店权限和返回结果。
