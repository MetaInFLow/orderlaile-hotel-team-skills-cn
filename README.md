# 订单来了酒店团队技能包

面向订单来了桌面工作台的中文酒店运营技能包。  
订单来了 CLI 负责 PMS 真实数据查询与写操作；飞书 CLI 或钉钉 CLI 负责文档、表格、任务、日历和消息协作。

## 定位

本项目是原 `hotel-team-skills` 的中文重构版，不是逐句翻译。它移除了海外连接器、Claude 专用安装方式、外部官网部署和虚构的自动同步能力。

支持的岗位：

- 总经理 / 运营负责人
- 前厅 / 预订
- 营收
- 财务
- 餐饮
- 客房 / 房务
- 销售营销
- 数字运营

## 数据边界

### 订单来了 CLI

唯一的酒店经营事实来源和写操作执行入口：

- 订单、入住、退房、排房、取消、NoShow
- 房价、库存、价格码、房型、房间
- 客户、会员、优惠券、储值卡
- 员工、角色、权限、班次
- 餐厅、桌位、菜品、套餐、商超
- 收款方式、打印、通知、门店资料
- 连住优惠、抽奖、分销
- 营业额、房费、间夜、入住率、OCC、ADR、RevPAR 等报表

### 飞书 CLI 或钉钉 CLI

只用于协作资料和工作流：

- 文档、知识库、表格 / 多维表
- 任务、待办、日历、会议
- 群聊、消息、审批
- 用户上传的外部报表和附件

两类 CLI 不互相冒充数据源。查不到的内容必须明确标记为“当前未接入”或“需要用户提供文件”。

## 使用方式

加载对应岗位目录下的 `SKILL.md`。每次涉及酒店经营数据时，必须调用订单来了 CLI：

```text
mcp__so_agents.so_cli
```

涉及文档、表格、任务、日历或消息时，调用当前环境已配置的飞书 CLI 或钉钉 CLI。

## 目录

```text
├── 共享运行规则.md
├── docs/
│   └── 能力映射.md
├── hotel-general-manager/SKILL.md
├── hotel-front-office/SKILL.md
├── hotel-revenue-management/SKILL.md
├── hotel-finance-controller/SKILL.md
├── hotel-food-beverage/SKILL.md
├── hotel-housekeeping-rooms/SKILL.md
├── hotel-sales-marketing/SKILL.md
└── hotel-digital-operations/SKILL.md
```

## 明确不包含

- Google、Gmail、Google Drive、Zoom、Slack、Dropbox、Notion 等海外连接器
- 海外 OTA、CRM、RMS、POS、财务系统的自动连接
- Firecrawl、Vercel、GitHub 自动部署
- 自动生成或上传外部网站用的 `property.json`

## 许可

MIT
