import
  strutils,
  options,
  LatinWords/Types,
  LatinWords/Verb,
  LatinWords/VerbConstants,
  LatinWords/Noun,
  LatinWords/WikiText

#
#
#
#
# Entire public interface.
#
#
#
#

func getAllWordForms*(wiktionaryTemplate: string): AllWordForms
func guessWordForm*(word: string): seq[WordForm]
func deMacronise*(s: string): string

#
#
#
#
# Detail
#
#
#
#

func getAllWordForms*(wiktionaryTemplate: string): AllWordForms =
  let wf = parseTemplate(wiktionaryTemplate)
  if wf.isSome:
    return get wf
  else:
    return AllWordForms()

func deMacronise*(s: string): string =
  s.multiReplace(
    ("ā", "a"),
    ("ē", "e"),
    ("ī", "i"),
    ("ō", "o"),
    ("ū", "u"),
    ("ȳ", "y")
  )

# The idea of this function is that if you give it "scrībit" it will somehow
# know that that is the third person singular present active indicative of
# "scrībō". Since this is black magic, it may not always work.
func guessWordForm*(word: string): seq[WordForm] =
  # Try nouns...
  for d in NounDeclension:
    for n in Number:
      for c in NounCase:
        let suffix = StandardNounCaseEndings[d][n][c]
        if suffix.len > 0 and word.endsWith(suffix):
          let
            suffixIdx = word.len - suffix.len
            stem = word[0 ..< suffixIdx]
            nomSing = stem & StandardNounCaseEndings[d][Number.Single][NounCase.Nom]
          result.add WordForm(kind: WordKind.Noun, word: word,
                              nounID: (nomSing, n, c))

  # Try verbs...
  for c in VerbConjugation:
    for m in Mood:
      for v in Voice:
        for a in Aspect:
          for n in Number:
            for p in Person:
              let suffix = StandardVerbFormEndings[c][m][v][a][n][p]
              if suffix.len > 0 and word.endsWith(suffix):
                let
                  # FIXME: should be suffix.deMacronise().len iff
                  # word.endsWith(suffix.deMacronise())
                  suffixIdx = word.len - suffix.len
                  stem = word[0 ..< suffixIdx]
                  fpp = stem &
                    StandardVerbFormEndings[c][Mood.Indicative][Voice.Active][Aspect.Present][Number.Single][Person.First]
                result.add WordForm(kind: WordKind.Verb, word: word,
                                    verbID: (fpp, m, v, a, n, p))