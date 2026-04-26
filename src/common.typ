#import "util-inner.typ": *
#import "@preview/equate:0.3.1": equate

#let cover-date-format = "[year] 年 [month padding:none] 月"
#let approval-date-format = "[year] 年 [month padding:none] 月 [day] 日"
#let text-size = word-zihao.小四
// #let line-height = 1.5em
#let line-height = 1.95em
#let line-leading = line-height * .4
#let par-spacing = line-height * .4

#let make-redacted(effective) = if effective {
  it => context {
    let (width, height) = measure(it)
    box(width: width, height: height, fill: black, baseline: line-height * .1)
    // repr((width, height))
  }
} else {
  it => it
}

#let show-universal(..args, body) = {
  let author = args.named().author
  let thesis = args.named().thesis
  let date = args.named().date

  set document(
    author: author.name,
    title: thesis.title.zh,
    keywords: thesis.keywords.zh,
    date: date,
  )

  set text(
    region: "cn",
    top-edge: line-height * .5,
    bottom-edge: -line-height * .1,
  )
  set page(paper: "a4", margin: 2.5cm)
  set pagebreak(weak: true)

  body
}

#let headered-page(..args, body) = {
  let is-material = args.named().is-material
  let redacted = make-redacted(args.named().is-anonymous)
  let header = if not is-material {
    align(
      center,
      block(
        width: 100%,
        inset: (bottom: word-zihao.小五 * .5),
        stroke: (bottom: .5pt),
        text(word-zihao.小五)[#redacted[北京邮电大学]本科毕业设计（论文）],
      ),
    )
  }

  set page(header: header, header-ascent: 40%)

  body
}

#let numbered-page(..args, body) = {
  let is-material = args.named().is-material
  let numbering = args.named().numbering

  set page(
    numbering: if not is-material { numbering },
    number-align: center,
  )

  body
}

#let set-text-lang(..args, body) = {
  let lang = args.named().lang
  set text(lang: lang)

  body
}

#let styled-text(..args, body) = {
  let font = args.named().serif-alt-font
  let size = args.named().at("text-size", default: text-size)

  set text(
    cjk-latin-spacing: auto,
    size: size,
    font: font,
  )

  body
}

#let styled-cite(..args, body) = {
  // A dirty walkaround, since SimSun as a superscript does not work properly on my device.
  // You may comment this out if you are using a different font.
  // show cite.where(style: auto): it => {
  //   let font = args.named().sans-alt-font
  //   show regex(`[¹²³⁴⁵⁶⁷⁸⁹⁰]+`.text): set text(font: font)
  //   it
  // }

  body
}

#let styled-strong(..args, body) = {
  show strong: cn-fakebold

  body
}

#let styled-emph(..args, body) = {
  let font = args.named().italic-font

  show emph: it => text(font: font, style: "normal", it.body)

  body
}

#let styled-par(..args, body) = {
  set par(
    first-line-indent: (amount: 2em, all: true),
    justify: true,
    spacing: par-spacing,
    leading: line-leading,
  )

  body
}

#let styled-abstract-heading(..args, body) = {
  let font = args.named().sans-alt-font

  show heading: it => {
    if it.level != 1 {
      panic("Abstract does not accept headings with levels other than 1.")
    }

    show: align.with(center)
    set text(size: word-zihao.小三, font: font)
    fb(it)
    v(.25em)
  }

  body
}

#let styled-outline-heading(..args, body) = {
  let font = args.named().sans-alt-font

  show heading: it => {
    if it.level != 1 {
      panic("Outline does not accept headings with levels other than 1.")
    }

    show: align.with(center)
    set text(size: word-zihao.三号, font: font)
    fb(it)
    v(1em)
  }

  body
}

#let styled-body-heading(..args, body) = {
  let font = args.named().sans-font

  set heading(
    supplement: [章节],
    numbering: (..nums) => {
      nums = nums.pos()
      numbering(if nums.len() == 1 { "第一章" } else { "1.1" }, ..nums)
    },
  )
  show heading: it => {
    set text(font: font)

    let it-body = block({
      numbering(it.numbering, ..counter(heading).get())
      h(.75em)
      it.body
    })

    if it.level == 1 {
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(math.equation).update(0)

      pagebreak()
      show: align.with(center)
      set text(size: word-zihao.三号)
      fb(it-body)
      v(-.5em)
      box()
    } else if it.level == 2 {
      set text(size: word-zihao.四号)
      fb(it-body)
      v(-.5em)
      box()
    } else {
      show: box
      set text(size: word-zihao.小四)
      fb(it-body)
      v(-.7em)
      box()
    }
  }

  body
}

#let styled-appendix-heading(..args, body) = {
  let font = args.named().sans-alt-font

  show heading: it => {
    if it.level != 1 {
      panic("Appendix does not accept headings with levels other than 1.")
    }

    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: math.equation)).update(0)

    context if counter(page).get().first() != 1 { pagebreak() }
    show: align.with(center)
    set text(size: word-zihao.三号, font: font)
    fb(it)
    v(-.25em)
    box()
  }

  body
}

#let styled-outline(..args, body) = {
  let serif-font = args.named().serif-font
  let serif-alt-font = args.named().serif-alt-font
  let sans-font = args.named().sans-font
  let sans-alt-font = args.named().sans-alt-font

  show outline: it => {
    show heading: it => it + v(-.75em)
    it
  }

  import outline.entry
  show entry: set entry(fill: repeat[.])
  // show entry: set entry(fill: text(font: serif-font, repeat([…])))
  // show entry.where(level: 1): set entry(fill: text(font: sans-alt-font, repeat([…])))
  show entry: it => {
    let get-indent(level) = h(1.5em * (level - 1))
    let body-transform(level, content) = text(
      font: if level == 1 { sans-font } else { serif-alt-font },
      size: word-zihao.小四,
      content,
    )
    let prefix-transform(level, content) = {
      body-transform(level, content) + if content != none { h(.5em) }
    }
    let page-transform(level, content) = text(
      // font: if level == 1 { sans-font } else { serif-font },
      content,
    )

    let indent = get-indent(it.level)
    let prefix = prefix-transform(it.level, it.prefix())
    let body = body-transform(it.level, it.body())
    let page = page-transform(it.level, it.page())

    block(
      link(
        it.element.location(),
        indent + prefix + body + box(width: 1fr, pad(x: .25em, it.fill)) + page,
      ),
    )
  }

  set par(leading: 20pt - line-height * .5)
  body
}

#let styled-raw(..args, body) = {
  let font = args.named().mono-font
  let size = text-size

  show raw: set text(font: font)
  show raw.where(block: true): set text(size: size)
  show raw.where(block: true): set par(justify: false)

  body
}

#let styled-enum(..args, body) = {
  set enum(indent: 2em)

  body
}

#let styled-table(..args, body) = {
  let stroke = (thickness: .5pt)

  set table(
    align: center + horizon,
    stroke: (x, y) => (y: stroke) + if x != 0 { (left: stroke) },
    inset: (x: .75em, y: .5em),
  )
  set table.hline(stroke: stroke)
  set table.vline(stroke: stroke)

  body
}

#let styled-math(..args, body) = {
  let font = ((args.named().math-font,) + (args.named().serif-alt-font,)).flatten()
  let text-font = args.named().serif-alt-font

  import math: *

  show: equate.with(breakable: true, sub-numbering: true)
  show equation: set text(font: font)
  set equation(
    supplement: none,
    numbering: (..nums) => text(font: text-font, custom-numbering(numbering: "(1-1.a)", ..nums)),
  )
  show ref: it => {
    let elem = it.element
    if elem == none or elem.fields().at("kind", default: none) != equation {
      return it
    }
    generate-ref(elem, ..elem.body.value)
  }
  show equation.where(block: true): set par(leading: 1em)
  show equation.where(block: false): display
  show sym.zwj: set text(white) // Compatibility with some fonts (e.g. STIX Two Math)
  set mat(row-gap: .25em, column-gap: .75em)
  set cases(gap: .5em)

  body
}

#let styled-figure(..args, body) = {
  let font = args.named().italic-font

  show figure.caption: set text(font: font, size: word-zihao.五号)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure: set block(breakable: true)

  body
}

#let numbered-figure(..args, body) = {
  let text-font = args.named().serif-alt-font

  set figure(numbering: custom-numbering.with(numbering: "1-1"))
  show ref: it => {
    let elem = it.element
    if elem == none {
      return it
    }

    let kind = elem.fields().at("kind", default: none)
    if kind != image and kind != table {
      return it
    }

    generate-ref(elem, elem.counter.at(elem.location()).first())
  }

  body
}

#let show-basic-text(..args, body) = {
  show: styled-text.with(..args)
  show: styled-strong.with(..args)
  show: styled-emph.with(..args)
  show: styled-par.with(..args)
  show: styled-raw.with(..args)
  show: styled-enum.with(..args)
  show: styled-table.with(..args)
  show: styled-math.with(..args)
  show: styled-figure.with(..args)

  body
}

#let show-abstract(..args, body) = {
  show: show-basic-text.with(..args)
  show: styled-abstract-heading.with(..args)

  body
}

#let show-abstract-zh(..args, body) = {
  show: show-abstract.with(..args)
  show: set-text-lang.with(..args, lang: "zh")

  body
}

#let show-abstract-en(..args, body) = {
  show: show-abstract.with(..args)
  show: set-text-lang.with(..args, lang: "en")

  body
}

#let show-outline(..args, body) = {
  show: show-basic-text.with(..args)
  show: set-text-lang.with(..args, lang: "zh")

  show: styled-outline.with(..args)
  show: styled-outline-heading.with(..args)

  counter(page).update(1)
  show: numbered-page.with(..args, numbering: "I")

  body
}

#let show-body-start(..args, body) = {
  counter(page).update(1)
  show: numbered-page.with(..args, numbering: "1")
  show: headered-page.with(..args)

  body
}

#let show-material-start(..args, body) = {
  set heading(outlined: false)
  counter(heading).update(0)

  body
}


#let show-body-chapter(..args, body) = {
  show: show-basic-text.with(..args)
  show: set-text-lang.with(..args, lang: "zh")

  show: styled-cite.with(..args)

  show: styled-body-heading.with(..args)
  show: numbered-figure.with(..args)

  body
}

#let show-appendix-chapter(..args, body) = {
  show: show-basic-text.with(..args)
  show: set-text-lang.with(lang: "zh", ..args)

  show: numbered-page.with(..args, numbering: "1")

  show: headered-page.with(..args)
  show: styled-appendix-heading.with(..args)
  // show: numbered-figure.with(..args)

  body
}
