# zx-skills

我的 [Claude Code](https://docs.anthropic.com/en/docs/claude-code) 自定义技能集。

## 安装

使用 [skills CLI](https://github.com/vercel-labs/skills)（基于 `npx`）一行安装：

```bash
# 安装全部技能（全局，org-mode 格式）
npx skills add starandtina/zx-skills -g --all

# 安装全部技能（Markdown 格式，适用于 Obsidian / VSCode / Notion 等）
npx skills add starandtina/zx-skills#md -g --all

# 安装单个技能
npx skills add starandtina/zx-skills -g --skill zx-card

# 安装单个技能（Markdown 格式）
npx skills add starandtina/zx-skills#md -g --skill zx-card

# 安装多个指定技能
npx skills add starandtina/zx-skills -g --skill zx-card --skill zx-learn

# 查看仓库中有哪些技能
npx skills add starandtina/zx-skills -l
```

**参数说明：**

| 参数             | 作用                                                                         |
| ---------------- | ---------------------------------------------------------------------------- |
| `-g`             | 全局安装到 `~/.claude/skills/`（推荐）。不加则装到当前项目 `.claude/skills/` |
| `--skill <name>` | 指定安装某个技能，可重复使用                                                 |
| `--all`          | 安装仓库内全部技能                                                           |
| `#md`            | 从 `md` branch 安装 Markdown 格式版本（默认为 org-mode）                     |
| `-l`             | 仅列出可用技能，不安装                                                       |

### zx-card 依赖

`zx-card` 依赖 Playwright 截图，安装后需额外执行：

```bash
cd ~/.claude/skills/zx-card && npm install && npx playwright install chromium
```

### 替代方式：git clone

```bash
# org-mode 版本
git clone https://github.com/starandtina/zx-skills.git ~/.claude/plugins/zx-skills

# Markdown 版本
git clone -b md https://github.com/starandtina/zx-skills.git ~/.claude/plugins/zx-skills
```

## 技能

| 技能                | 说明                                                                                                         |
| ------------------- | ------------------------------------------------------------------------------------------------------------ |
| **zx-card**         | 内容铸卡 — 将内容转为 PNG 视觉卡片（长图 `-l`、信息图 `-i`、多卡 `-m`、视觉笔记 `-v`、漫画 `-c`、白板 `-w`、大字 `-b`） |
| **zx-grill-me**     | 拷问我 — 对计划、方案或设计做高压追问，一次只问一个关键问题，并给出推荐答案                                  |
| **zx-learn**        | 概念解剖 — 从八个方向切开一个概念（历史、辩证、现象、语言、形式、存在、美感、元反思），压成一句顿悟          |
| **zx-paper**        | 论文阅读 — 把一篇论文压成一个清楚命题：问题、洞见、可带走的判断或动作                                        |
| **zx-paper-river**  | 论文溯源 — 倒读法，递归挖前序论文（最多5层）+ 最新进展，从源头讲述问题演化史                                 |
| **zx-plain**        | 白话引擎 — 把任何内容改写到聪明的十二岁小孩也能懂                                                            |
| **zx-present**      | 演讲铸造器 — 将 org/markdown outline 原样渲染成离线 HTML slides，支持 hacker 主题、表格、ASCII、LaTeX        |
| **zx-qa**           | 信息提问机 — 把文章/论文/书的核心观点抽成有方向的 Q-A 推理链                                                 |
| **zx-rank**         | 降秩引擎 — 给一个领域，找出背后不可再少的独立生成器                                                          |
| **zx-read**         | 伴读 — 陪读文本，提供翻译、结构标注、深度提问和跨领域旁逸                                                    |
| **zx-think**        | 追本之箭 — 给一个观点或现象，纵向深钻到不可再分的本质                                                        |
| **zx-word**         | 单词精通 — 深度拆解一个英语单词的核心语义和顿悟时刻                                                          |
| **zx-writes**       | 写作引擎 — 像手术刀剖开一个观点，一层层剥到底，输出 1000-1500 字文章                                         |
| **zx-invest**       | 投资分析 — 核心判断项目是否是一台「秩序创造机器」                                                            |
| **zx-relationship** | 关系分析 — 五层结构诊断 + 精神分析，通过对话引导帮用户"看见"关系真实结构                                     |
| **zx-roundtable**   | 圆桌讨论 — 求真导向的结构化多人辩证对话，每轮生成 ASCII 思考框架图                                           |
| **zx-travel**       | 旅行研究 — 输入城市名，生成深度文化研究文档（org-mode）+ 便携卡片（PNG）                                     |
| **zx-skill-map**    | 技能地图 — 扫描所有已安装技能，渲染可视化总览                                                                |

## 工作流

工作流将多个技能串联为一个命令。

| 工作流            | 技能链                | 说明                              |
| ----------------- | --------------------- | --------------------------------- |
| **zx-paper-flow** | zx-paper → zx-card -v | 读论文 + 做视觉笔记卡片一气呵成   |
| **zx-word-flow**  | zx-word → zx-card -i  | 单词深度分析 + 信息图卡片一气呵成 |

## 输出格式

技能提供两种输出格式，通过不同 branch 安装，功能完全相同：

| Branch           | 格式               | 适用场景                                        |
| ---------------- | ------------------ | ----------------------------------------------- |
| `master`（默认） | Org-mode（`.org`） | Emacs / Denote 用户                             |
| `md`             | Markdown（`.md`）  | Obsidian / VSCode / Notion 等 Markdown 生态用户 |
