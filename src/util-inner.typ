#import "@preview/cuti:0.3.0": fakebold, cn-fakebold

// === Pure Utility Functions ===

#let magic-number = 0xfa555

#let args-parse(..args) = {
  if args.pos().len() != 0 {
    panic("Positional arguments are not allowed in `args-parse': " + repr(args.pos()))
  }

  let args-named = args.named()
  let common = args-named.remove("common")
  let info = args-named.remove("info")
  if args-named.len() != 0 {
    panic("Unknown named arguments in `args-parse': " + args-named.keys().join(", "))
  }

  return common + info
}

#let custom-numbering(..args) = {
  let pattern = args.named().numbering
  let nums = args.pos()
  let heading-num = if nums.first() == magic-number {
    nums.at(1)
    nums = nums.slice(2)
  } else {
    counter(heading).get().first()
  }

  numbering(pattern, heading-num, ..nums)
}

#let generate-ref(..args) = {
  let elem = args.pos().first()
  let nums = args.pos().slice(1)

  let location = elem.location()
  let heading-num = counter(heading).at(location).first()

  link(
    location,
    {
      elem.supplement
      numbering(elem.numbering, magic-number, heading-num, ..nums)
    },
  )
}

/// === Layout Utilities ===

#let inf = 114514em

#let word-zihao = (
  初号: 42pt,
  小初: 36pt,
  一号: 26pt,
  小一: 24pt,
  二号: 22pt,
  小二: 18pt,
  三号: 16pt,
  小三: 15pt,
  四号: 14pt,
  小四: 12pt,
  五号: 10.5pt,
  小五: 9pt,
  六号: 7.5pt,
  小六: 6.5pt,
  七号: 5.5pt,
  八号: 5pt,
)

#let fb(body) = fakebold(text(weight: "bold", body))
