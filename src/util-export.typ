#import "config.typ": config-common, config-info, default-config
#import "common.typ": (
  line-leading,
  cover-date-format,
  approval-date-format,
  show-universal,
  show-material-start,
  show-abstract-zh,
  show-abstract-en,
  show-outline,
  show-body-start,
  show-body-chapter,
  show-appendix-chapter,
  show-basic-text,
  set-text-lang,
  headered-page,
  styled-appendix-heading,
  make-redacted
)
#import "util-inner.typ": *

#let final-factory-inner(..args) = {
  let config = args-parse(..args)

  let sans(body) = context if text.lang == "zh" {
    fb(text(font: config.sans-font, body))
  } else if text.lang == "en" {
    fb(text(font: config.sans-alt-font, body))
  }

  let redacted = make-redacted(config.is-anonymous)

  let set-universal = body => {
    show: show-universal.with(..config)

    body
  }

  let set-material = body => {
    set text(region: "cn")
    set page(paper: "a4", margin: 2.5cm)
    set pagebreak(weak: true)

    {
      show: show-basic-text.with(..config)
      show: set-text-lang.with(..config, lang: "zh")

      show: styled-appendix-heading.with(..config)
      heading(text(tracking: .5em)[外文译文])
      v(word-zihao.三号)
    }

    show: show-material-start.with(..config)

    body
  }

  let make-cover = () => page({
    let serif-font = config.serif-font
    let sans-font = config.sans-font
    let author = config.author
    let date = config.date
    let thesis = config.thesis

    show: align.with(center)
    show: fb
    set text(size: word-zihao.三号)

    set text(font: sans-font)
    v(.5em)
    redacted(image("/assets/banner.jpg", width: 10.35cm, height: 3.01cm))
    v(word-zihao.一号 * .5)
    text(size: word-zihao.一号, [#text(tracking: .5em)[本科毕业设计]（论文）])
    v(.75em)
    redacted(image("/assets/logo.png", height: 3.83cm))
    v(1.5em)
    box(
      width: inf,
      [题目：] + underline(extent: .25em, offset: .25em, stroke: .75pt, thesis.title.zh),
    )
    v(1.75em)

    set text(font: serif-font)
    let left-two-word-cell(body) = text(tracking: 2em, body)
    let right-cell(body) = redacted(box(width: 17em, outset: (bottom: .05em), stroke: (bottom: .75pt), body))
    grid(
      columns: 2,
      column-gutter: .75em,
      rows: 2em,
      left-two-word-cell[姓名], right-cell(author.name),
      left-two-word-cell[学院], right-cell(author.school),
      left-two-word-cell[专业], right-cell(author.major),
      left-two-word-cell[班级], right-cell(author.class-id),
      left-two-word-cell[学号], right-cell(author.student-id),
      [指导教师], right-cell(author.supervisor),
    )
    v(.5em)
    date.display(cover-date-format)
  })

  let make-code-of-integrity = () => {
    let cell(width: 100%, body) = box(
      width: width,
      height: 1.25em,
      outset: (bottom: .05em),
      stroke: (bottom: .5pt),
      align(center, body),
    )

    let signature-cell = cell.with(width: 11.5em)

    let info = config.approval

    show: show-basic-text.with(..config)

    text(
      size: word-zihao.小三,
      {
        show: align.with(center)
        redacted(fakebold(text(tracking: .5em)[北京邮电大学]))
        parbreak()
        fakebold[本科毕业设计（论文）诚信声明]
      },
    )

    [
      本人声明所呈交的毕业设计（论文），题目《#[#config.thesis.title.zh]》是本人在指导教师的指导下，独立进行研究工作所取得的成果。尽我所知，除了文中特别加以标注和致谢中所罗列的内容以外，论文中不包含其他人已经发表或撰写过的研究成果，也不包含为获得#redacted[北京邮电大学]或其他教育机构的学位或证书而使用过的材料。

      申请学位论文与资料若有不实之处，本人承担一切相关责任。
    ]

    parbreak()
    linebreak()

    pad(
      x: 2em,
      grid(
        columns: (auto, 11.5em, auto, 11.5em),
        column-gutter: (.5em, 2em, .5em),
        [本人签名：],
        redacted(signature-cell(info.signature.at(0))),
        [日期：],
        cell(info.date.at(0).display(approval-date-format)),
      ),
    )

    parbreak()
    4 * linebreak()

    text(
      size: word-zihao.小三,
      {
        show: align.with(center)
        fakebold[关于论文使用授权的说明]
      },
    )

    [
      本人完全了解并同意#redacted[北京邮电大学]有关保留、使用学位论文的规定，即：#redacted[北京邮电大学]拥有以下关于学位论文的无偿使用权，具体包括：学校有权保留并向国家有关部门或机构送交学位论文，有权允许学位论文被查阅和借阅；学校可以公布学位论文的全部或部分内容，有权允许采用影印、缩印或其它复制手段保存。汇编学位论文，将学位论文的全部或部分内容编入有关数据库进行检索。（保密的学位论文在解密后遵守此规定）
    ]


    parbreak()
    linebreak()

    pad(
      x: 2em,
      grid(
        columns: (auto, 11.5em, auto, 11.5em),
        column-gutter: (.5em, 2em, .5em),
        row-gutter: line-leading,

        /// divider
        [本人签名：],
        redacted(signature-cell(info.signature.at(1))),
        [日期：],
        cell(info.date.at(1).display(approval-date-format)),

        [导师签名：],
        redacted(signature-cell(info.signature.at(2))),
        [日期：],
        cell(info.date.at(2).display(approval-date-format)),
      ),
    )

    pagebreak()
  }

  let abstract-title(title) = {
    show: align.with(center)
    set text(hyphenate: false, size: word-zihao.三号)
    set par(justify: false)
    sans(title)
    v(1em)
  }

  let abstract-zh = body => {
    show: show-abstract-zh.with(..config)

    abstract-title(config.thesis.title.zh)
    heading(outlined: false)[摘要]
    v(word-zihao.三号)
    body

    parbreak()
    linebreak()
    sans[关键词]
    for keyword in config.thesis.keywords.zh {
      " "
      keyword
    }

    pagebreak()
  }

  let abstract-en = body => {
    show: show-abstract-en.with(..config)
    set text(font: config.serif-alt-font)

    abstract-title(config.thesis.title.en)
    heading(outlined: false)[ABSTRACT]
    v(word-zihao.三号)
    body

    parbreak()
    linebreak()
    sans[KEY WORDS]
    for keyword in config.thesis.keywords.en {
      "  "
      keyword
    }

    pagebreak()
  }

  let make-outline = () => {
    show: show-outline.with(..config)

    outline()
  }

  let body-start = body => {
    show: show-body-start.with(..config)

    body
  }

  let body-chapter = body => {
    show: show-body-chapter.with(..config)

    body
  }

  let appendix-chapter = body => {
    show: show-appendix-chapter.with(..config)

    body
  }

  let make-bibliography = (..args) => {
    show: show-appendix-chapter.with(..config, lang: "en", text-size: word-zihao.五号)

    set bibliography(full: true)
    // bibliography(..args)
    // bibliography(style: "gb-7714-2015-numeric", ..args)
    bibliography(style: "/resources/gb-t-7714-2015-numeric.csl", title: [参考文献], ..args)
  }

  // let fancy = {
  //   let colour = config.colour
  //   let tint = colour.tint
  //   let stroke = (thickness: .5pt, paint: tint.primary)

  //   it => align(
  //     center,
  //     block(
  //       width: 100% + 2 * .75em,
  //       radius: .5em,
  //       // stroke: stroke + (dash: (.5em, .25em), thickness: .5pt),
  //       inset: .75em,
  //       fill: luma(240),
  //       align(left, it),
  //     ),
  //   )
  // }

  let text-cite(name) = {
    cite(name, style: "institute-of-electrical-and-electronics-engineers")
  }

  return (
    set-universal: set-universal,
    set-material: set-material,
    make-cover: make-cover,
    make-code-of-integrity: make-code-of-integrity,
    abstract-zh: abstract-zh,
    abstract-en: abstract-en,
    make-outline: make-outline,
    body-start: body-start,
    body-chapter: body-chapter,
    appendix-chapter: appendix-chapter,
    make-bibliography: make-bibliography,
    // fancy: fancy,
    text-cite: text-cite,
    redacted: redacted,
  )
}

#let final-factory = final-factory-inner.with(..default-config)

#let noindent = h(-2em)
#let num = num => $#num$
#let unit = unit => $upright(#unit)$
#let qty = (num, unit) => $#num thin upright(#unit)$
#let table-header-maker = (..args) => table.header(
  ..args.pos().map(strong).intersperse(table.vline()),
)
