import strutils
import Types
import VerbConstants

func conjugateVerb*(firstPrincipalPart: string, conj: VerbConjugation): AllWordForms
func firstConjugation(firstPrincipalPart: string): AllWordForms

# Standard suffixes

### firstPrincipalPart is e.g. "amō" for amāre
func conjugateVerb*(firstPrincipalPart: string, conj: VerbConjugation): AllWordForms =
  case conj:
  of VerbConjugation.First: firstConjugation(firstPrincipalPart)


func firstConjugation(firstPrincipalPart: string): AllWordForms =
  assert firstPrincipalPart.endsWith("ō")
  let stem = firstPrincipalPart[0 ..< firstPrincipalPart.len-2]
  const c = VerbConjugation.First
  var ret = AllWordForms(kind: WordKind.Verb)
  for m in Mood:
    for v in Voice:
      for a in Aspect:
        for n in Number:
          for p in Person:
            let suffix = StandardVerbFormEndings[c][m][v][a][n][p]
            if suffix.len > 0:
              ret.verbForms[m][v][a][n][p] = stem & suffix

  return ret

