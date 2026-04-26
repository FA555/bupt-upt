#import "/globals.typ": *

#show: set-universal

#make-cover()
#include "content/abstract-zh.typ"
#include "content/abstract-en.typ"
#make-outline()
#include "content/body.typ"
#make-bibliography("ref.bib", full: true)
#include "content/acknowledgement.typ"
