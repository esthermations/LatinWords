import
  strutils,
  options,
  LatinWords/Types,
  LatinWords/Verb,
  LatinWords/VerbConstants,
  LatinWords/Noun,
  LatinWords/NounConstants,
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
    ("ȳ", "y"),
    ("Ā", "A"),
    ("Ē", "E"),
    ("Ī", "I"),
    ("Ō", "O"),
    ("Ū", "U"),
    ("Ȳ", "Y")
  )

func createFirstPrincipalPartFromStem(stem: string,
                                      conj: VerbConjugation): string =
  let (m, v, a, n, p) = (
    Mood.Indicative,
    Voice.Active,
    Aspect.Present,
    Number.Single,
    Person.First
  )
  stem & StandardVerbFormEndings[conj][m][v][a][n][p]

func createNomSingFromStem(stem: string, decl: NounDeclension): string =
  stem & StandardNounCaseEndings[decl][Number.Single][NounCase.Nom]

# Try and find the verb stem in a macron-agnostic way.
func getVerbStem*(verb: string): string =
  for c in VerbConjugation:
    for m in Mood:
      for v in Voice:
        for a in Aspect:
          for n in Number:
            for p in Person:
              let
                suffix = StandardVerbFormEndings[c][m][v][a][n][p]
                suffixNoMacrons = suffix.deMacronise()
              if suffix.len == 0:
                continue
              if verb.endsWith(suffix):
                let stem = verb[0 ..< verb.len - suffix.len]
                return stem
              elif verb.endsWith(suffixNoMacrons):
                let stem = verb[0 ..< verb.len - suffixNoMacrons.len]
                return stem
  # Default value
  return ""

func getNounStem*(noun: string): string =
  for d in NounDeclension:
    for n in Number:
      for c in NounCase:
        let
          suffix = StandardNounCaseEndings[d][n][c]
          suffixNoMacrons = suffix.deMacronise()
        if suffix.len == 0:
          continue
        if noun.endsWith(suffix):
          let stem = noun[0 ..< noun.len - suffix.len]
          return stem
        elif noun.endsWith(suffixNoMacrons):
          let stem = noun[0 ..< noun.len - suffixNoMacrons.len]
          return stem
  # Default value
  return ""

func identifyVerb*(verb: string): Option[VerbIdentifier] =
  let stem = getVerbStem(verb)
  if stem.len == 0: return
  for c in VerbConjugation:
    for m in Mood:
      for v in Voice:
        for a in Aspect:
          for n in Number:
            for p in Person:
              let
                suffix = StandardVerbFormEndings[c][m][v][a][n][p]
                suffixNoMacrons = suffix.deMacronise()
              if suffix.len == 0: continue
              if verb.endsWith(suffix) or verb.endsWith(suffixNoMacrons):
                let fpp = createFirstPrincipalPartFromStem(stem, conj = c)
                return some (fpp, m, v, a, n, p)

func identifyNoun*(noun: string): Option[NounIdentifier] =
  let stem = getNounStem(noun)
  if stem.len == 0: return
  for d in NounDeclension:
    for n in Number:
      for c in NounCase:
        let
          suffix = StandardNounCaseEndings[d][n][c]
          suffixNoMacrons = suffix.deMacronise()
        if suffix.len == 0: continue
        if noun.endsWith(suffix) or noun.endsWith(suffixNoMacrons):
          let nomSing = createNomSingFromStem(stem, decl = d)
          return some (nomSing, n, c)

# The idea of this function is that if you give it "scrībit" it will somehow
# know that that is the third person singular present active indicative of
# "scrībō". Since this is black magic, it may not always work.
func guessWordForm*(word: string): seq[WordForm] =
  let
    nounOpt = identifyNoun(word)
    verbOpt = identifyVerb(word)

  if nounOpt.isSome: result.add WordForm(word: word, kind: WordKind.Noun, nounID: nounOpt.get())
  if verbOpt.isSome: result.add WordForm(word: word, kind: WordKind.Verb, verbID: verbOpt.get())
