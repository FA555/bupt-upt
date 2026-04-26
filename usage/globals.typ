#import "@local/BUPT:0.2.0": *

#let (
  set-universal,
  make-cover,
  abstract-zh,
  abstract-en,
  make-outline,
  body-start,
  body-chapter,
  appendix-chapter,
  make-bibliography,
  text-cite,
) = final-factory(
  info: config-info(
    // is-material: true, // 为 true 时使用另一套模板，用于过程性材料中的外文论文翻译
    // is-anonymous: true, // 为 true 时抹去敏感信息与 #redact 函数包裹的内容
    author: (
      name: "法伍",
      school: "计算机学院（国家示范性软件学院）",
      major: "计算机科学与技术",
      class-id: "2021211355",
      student-id: "2021215555",
      supervisor: "法伵",
    ),
    thesis: (
      title: (
        zh: "基于Typst的北京邮电大学本科毕业设计论文模板",
        en: "Undergraduate Thesis Template of BUPT Based on Typst",
      ),
      keywords: (
        zh: ("北京邮电大学", "本科毕业设计", "模板", "Typst"),
        en: ("BUPT", "undergraduate thesis", "template", "Typst"),
      ),
    ),
    date: datetime(
      year: 2025,
      month: 6,
      /* day 字段不会出现在文章内容中，但会出现在 PDF 文件元数据内 */ day: 1,
    ),
  ),
)
