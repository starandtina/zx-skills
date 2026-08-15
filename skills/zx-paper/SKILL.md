---
name: zx-paper
description:
  "Paper reader for non-academics. Turns one paper into one clear proposition: the problem, the paper's insight, and
  the judgment or action the reader can carry away. USE WHEN the user shares an arXiv link OR paper URL OR PDF OR local
  paper file OR paper title, or asks to read, explain, analyze, or understand a paper. Defaults to a saved org note.
  NOT FOR experiment reproduction, exhaustive method summaries, formal peer review, benchmark tables, or literature
  surveys."
user_invocable: true
version: '5.0.0'
---

# zx-paper: 读完只带走一件事

让一个不懂该领域、但愿意思考的人，在半分钟内知道：论文被什么问题逼出来，作者多看见了什么，这会改变读者的哪个判断或动作。

全文只服务于一个中心命题。章节是理解这句话的台阶，不是几张各自交差的表。

## 格式约束

### Org-mode 语法

- 加粗用 `*bold*`（单星号），禁止 `**bold**`
- 标题层级从 `*` 开始，不跳级

### ASCII Art

所有图表用纯 ASCII 字符。允许：`+ - | / \ > < v ^ * = ~ . : # [ ] ( ) _ , ; ! '"` 和空格。禁止 Unicode 绘图符号。

### Denote 文件规范

- 时间戳：`date +%Y%m%dT%H%M%S`
- 可读时间：`date "+%Y-%m-%d %a %H:%M"`
- 文件名：`{时间戳}--paper-{方法名或论文关键词}__paper.org`
- 输出目录：`~/Documents/notes/`

### Org 文件头

```org
#+title:      paper-{一句精炼命题}
#+date:       [{YYYY-MM-DD Day HH:MM}]
#+filetags:   :paper:
#+identifier: {YYYYMMDDTHHMMSS}
#+source:     {最接近论文原文的裸 URL 或来源描述}
#+authors:    {作者列表}
#+venue:      {发表场所/年份}
```

`#+source` 只保留一个最接近论文原文的规范 URL；不要并列摘要页、PDF 页和新闻页。

## Workflow Routing

| 输入 | 必读 | 输出 |
| --- | --- | --- |
| arXiv、PDF、paper URL、本地论文 | `references/template.org` | 按四段结构生成 org 笔记 |
| 只有论文标题 | 找到可靠原文后读 `references/template.org` | 按四段结构生成 org 笔记 |
| 用户明确只要口头解释 | 本文件 | 不写文件，按同一理解路径讲 |

## 理解契约

「见过术语」不等于「已经有概念」。如果读者不能完成下面任一件事，就说明解释还没落地：

- 用普通话指出它区分了什么，以及它不是什么
- 说明它依赖什么、影响什么，和相邻概念怎样连接
- 在论文案例中认出它，并说出反例为什么不同
- 改变一个关键条件时，预测现象会怎样变

概念缺口不是术语表。只补中心命题、机制和证据链上的承重概念；外围术语按需解释，不让清单淹没论文思想。

## 执行

### 1. 获取内容

- arXiv URL -> 优先读 abstract、HTML、PDF 中能拿到的正文
- PDF -> 读取全文，注意页数限制
- 本地文件 -> 读取内容
- 论文名称 -> 搜索可靠原文

确保拿到：标题、作者、年份、问题、方法、关键证据、主要限制。

如论文有承载全文核心思路的 overview / architecture figure，可提取到 `~/Documents/notes/images/`，文件名 `{identifier}--paper-{简短标题}-overview.png`。没有就跳过，不硬找。

### 2. 判主类型

先判断论文主要是什么，不同类型有不同读法：

- 解释：它解释了以前解释不通的现象
- 方法：它让某件事能以新路径完成
- 测量：它让一个旧问题变得可测
- 资源：它提供数据集、工具或平台
- 理论：它换了一个看问题的框架

不要把评测、数据集和工具论文硬写成科学发现。工程增量就说工程增量。

### 3. 选一个具体困惑

选一个外行能看见的困惑，贯穿全文。不是「本文提出了新框架」，而是「为什么模型明明答对了，还会继续浪费 token？」。

这个困惑必须同时出现在：

- `* 它到底在解决什么`
- `* 它真正看见了什么`
- `* 我能带走什么`

如果三处接不上，说明中心命题还没立住。

### 4. 写命题脊柱

先写一个暂定命题：

```text
面对 {具体困惑}，这篇论文看见 {关键机制/盲点}，所以以后判断 {行动或判断变化}。
```

扫描其中每个承重词。凡是读者还没有概念的，都用「区别 + 关系 + 案例」补齐；补完再重写命题。

### 5. 建最小解释模型

把承重概念接成一个能运行的模型：

```text
条件/输入 -> 概念之间的作用关系 -> 首个可观察变化 -> 现象/结果
```

模型至少过三次检查：

1. 回到原困惑：能解释贯穿全文的锚点，而不是换词复述
2. 区分邻近情况：能说明一个看似相同的案例为什么不同
3. 改变一个条件：能预测哪个现象首先变化

图不是标配。只有当结构、因果链、反馈、分布或 trade-off 靠文字难以看见时，才用 ASCII 图或小表格。图必须紧挨着证据和边界，不能把「在这些条件下显示」画成普遍规律。

### 6. 写四段正文

顶层章节固定为：

1. `* 速读`
2. `* 它到底在解决什么`
3. `* 它真正看见了什么`
4. `* 我能带走什么`

`速读` 只让读者半分钟内抓住问题、洞见和带走。后面三段依次把命题展开，不新增另一条主线。

## Gotchas

- 先填章节会制造碎片。正文前先写中心命题；命题没立住就继续读
- 概念清单会制造碎片。概念只在模型需要它的那一刻出现，并立刻回到案例
- 定义不是概念。孤立释义默认删除
- 证据和适用范围必须贴着主张。不要把实验摘要和免责声明分开放
- 启发不是应用清单。优先只留一个判断问题，最多展开两个真正相关的用法
- 不要把公式删除当成通俗。核心关系式可保留一个，但必须立刻翻成人话
- 允许思想含量有限。没有直接用途时不要硬编

## 验收

生成笔记后读回确认：

- frontmatter 完整，文件确实保存成功
- 顶层只有四个规定章节
- `#+source` 只有一个来源
- 中心命题不是论文标题、模型名或贡献清单
- 至少有一个贯穿问题、洞见和带走的具体锚点
- 所有承重概念都在区别、关系和案例中工作
- 模型能解释原锚点、区分邻近情况，并对条件变化给出方向性预测
- 证据、主张和边界彼此相邻
- 主文没有未解释的 LaTeX 公式或旧模板章节

## 输出

1. 运行 `date +%Y%m%dT%H%M%S` 和 `date "+%Y-%m-%d %a %H:%M"` 获取时间戳
2. 读 `references/template.org`
3. 写入 `~/Documents/notes/{时间戳}--paper-{方法名或论文关键词}__paper.org`
4. 报告路径
