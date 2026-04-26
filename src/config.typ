#let default-common = (
  // strong-weight: "black",
  serif-font: ("SimSun",),
  serif-alt-font: (
    (name: "Times New Roman", covers: "latin-in-cjk"),
    "SimSun",
  ),
  italic-font: (
    (name: "Times New Roman", covers: "latin-in-cjk"),
    "KaiTi_GB2312",
  ),
  sans-font: ("SimHei",),
  sans-alt-font: (
    (name: "Times New Roman", covers: "latin-in-cjk"),
    "SimHei",
  ),
  mono-font: ("Fira Code", "SimHei"),
  math-font: ("New Computer Modern Math", "New Computer Modern"),
)

#let default-info = (
  is-material: false,
  is-anonymous: false,
  author: (
    name: "法伍",
    school: "计算机学院（国家示范性软件学院）",
    major: "计算机科学与技术",
    class-id: "2021211300",
    student-id: "2021210000",
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
  approval: (
    signature: (none,) * 3,
    date: (datetime(year: 2077, month: 1, day: 14),) * 3,
  ),
  date: datetime(
    year: 2077,
    month: 6,
    /* day 字段不会出现在文章内容中，但会出现在 PDF 文件元数据内 */ day: 1,
  ),
)

#let default-config = (
  common: default-common,
  info: default-info,
)

#let config-meta(default, ..args) = {
  if args.pos().len() != 0 {
    panic("Positional arguments are not allowed in `config' series function.")
  }

  return default + args.named()
}

#let config-common = config-meta.with(default-common)
#let config-info = config-meta.with(default-info)
