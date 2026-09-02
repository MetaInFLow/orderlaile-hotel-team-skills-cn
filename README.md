# 订单来了酒店团队技能包

面向订单来了桌面工作台的中文酒店运营技能包。  
订单来了 CLI 负责 PMS 真实数据查询与写操作；飞书 CLI 或钉钉 CLI 负责文档、表格、任务、日历和消息协作。

## 定位

本项目是原 `hotel-team-skills` 的中文重构版，不是逐句翻译。它移除了海外连接器、Claude 专用安装方式、外部官网部署和虚构的自动同步能力。

支持的入口与岗位：

- 酒店团队总入口
- 总经理 / 运营负责人
- 前厅 / 预订
- 营收
- 财务
- 餐饮
- 客房 / 房务
- 销售营销
- 数字运营（承接英文基线的 Vibe Coder，本地页面交付）

## 数据边界

### 订单来了 App 与当前 MCP

订单来了 App 覆盖订单住宿、房价库存、客户会员、员工权限、报表、餐饮商超、门店设置和营销等页面。当前 MCP 以 `mcp__so_agents.so_cli` 为经营数据主入口，来源清单确认的 109 个 action 及其边界见 [订单来了 App 与 MCP 能力映射](docs/订单来了App与MCP能力映射.md)。

当前可按 action 组查询或维护：

- 订单、住宿、账目、流水、排房、入住、退房、取消、NoShow 和订单导入
- 房价、价格码、本地/渠道/超售库存、房型、房间、房态和脏净状态
- 客户、会员卡、预售券、优惠券、员工、角色、权限和班次
- 营业、住宿、集团、销售、会员、财务流水、收银、AR、发票和钱包
- 房务任务、集团门店/设置、前台、早餐、客房消费、夜审和钟点房设置

App 页面可见不等于 MCP 已提供完整 action。餐厅桌台、菜品套餐、娱乐场地、营销店铺/活动、SCRM、短信、硬件打印、OTA 运营等功能，按映射文档和当前工具返回处理；未确认接口时标注“当前未接入”，转人工页面或用户文件。

### 飞书 CLI 或钉钉 CLI

只用于协作资料和工作流：

- 文档、知识库、表格 / 多维表
- 任务、待办、日历、会议
- 群聊、消息、审批
- 用户上传的外部报表和附件

两类 CLI 不互相冒充数据源。查不到的内容必须明确标记为“当前未接入”或“需要用户提供文件”。

## 使用方式

跨模块任务先加载 `hotel-team/SKILL.md`，再按路由加载对应岗位目录下的 `SKILL.md`。每次涉及酒店经营数据时，必须调用订单来了 CLI：

```text
mcp__so_agents.so_cli
```

涉及文档、表格、任务、日历或消息时，调用当前环境已配置的飞书 CLI 或钉钉 CLI。

## 目录

```text
├── 共享运行规则.md
├── docs/
│   ├── 能力映射.md
│   ├── 订单来了App与MCP能力映射.md
│   ├── 订单来了查询问题模板.md
│   └── 飞书钉钉协作模板.md
├── hotel-team/
│   ├── SKILL.md
│   └── references/
│       ├── 示例酒店经营档案.md
│       └── 调度能力矩阵.md
├── hotel-general-manager/SKILL.md
├── hotel-front-office/SKILL.md
├── hotel-revenue-management/SKILL.md
├── hotel-finance-controller/SKILL.md
├── hotel-food-beverage/SKILL.md
├── hotel-housekeeping-rooms/SKILL.md
├── hotel-sales-marketing/SKILL.md
└── hotel-digital-operations/SKILL.md
```

每个岗位目录还包含对应的 `references/产物模板.md`。

## 明确不包含

- Google、Gmail、Google Drive、Zoom、Slack、Dropbox、Notion 等海外连接器
- 海外 OTA、CRM、RMS、POS、财务系统的自动连接
- Firecrawl、Vercel、GitHub 自动部署
- 自动生成或上传外部网站用的 `property.json`

## 许可

MIT
