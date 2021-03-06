import strutils
import Types
import VerbConstants

func conjugateVerb*(firstPrincipalPart: string, conj: VerbConjugation, perfectStem: string = ""): AllWordForms
func firstConjugation(firstPrincipalPart: string, perfectStem: string = ""): AllWordForms

func isPerfective(aspect: Aspect): bool =
  aspect in [Aspect.Perfect, Aspect.Pluperfect, Aspect.FuturePerfect]

# Standard suffixes

### firstPrincipalPart is e.g. "amō" for amāre
func conjugateVerb*(firstPrincipalPart: string,
                    conj: VerbConjugation,
                    perfectStem: string = ""): AllWordForms =
  case conj:
  of VerbConjugation.First:
    result = firstConjugation(firstPrincipalPart, perfectStem = perfectStem)

func firstConjugation(firstPrincipalPart: string,
                      perfectStem: string = ""): AllWordForms =
  assert firstPrincipalPart.endsWith("ō")
  let stem = firstPrincipalPart[0 ..< firstPrincipalPart.len-2]
  const c = VerbConjugation.First
  var ret = AllWordForms(kind: WordKind.Verb)
  for m in Mood:
    for v in Voice:
      for a in Aspect:
        for n in Number:
          for p in Person:
            var suffix = StandardVerbFormEndings[c][m][v][a][n][p]
            if suffix.len != 0:
              if a.isPerfective():
                suffix = perfectStem & suffix
              ret.verbForms[m][v][a][n][p] = stem & suffix
  return ret

