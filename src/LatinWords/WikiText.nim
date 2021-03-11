import strutils, sequtils, unittest, options
import
  LatinWords/Types,
  LatinWords/Noun,
  LatinWords/Verb

const
  NounKeywords = [ "la-noun", "la-proper noun" ]
  VerbKeywords = [ "la-verb" ]

func toNounDeclension(s: string): Option[NounDeclension] =
  case s
  of "1": return some NounDeclension.First
  of "1.loc": return some NounDeclension.FirstWithLocative
  of "1.abus": return some NounDeclension.FirstWithDativePluralInAbus

func textBetween(str: string, a, b: char): string =
  let first = str.find(a)
  if first == -1: return ""
  let final = str.find(b, start = first)
  if final == -1: return ""
  return str[first + 1 .. final - 1]

test "textBetween":
  check "India<1>".textBetween('<', '>') == "1"

### Grab the gender of this noun if it is specified. If it's not specified, it's
### probably the "defualt" gender for its declesnion.
func guessGender(split: seq[string]): Gender =
  if split.count("g=f") > 0: return Gender.Feminine
  if split.count("g=m") > 0: return Gender.Masculine
  if split.count("g=n") > 0: return Gender.Neuter
  return Gender.Unknown

func getReducedNounFromTemplateArg(s: string): Option[ReducedNoun] =
  var ret: ReducedNoun
  let decl = toNounDeclension(s.textBetween('<', '>'))
  if decl.isNone:
    return none(ReducedNoun)

  ret.nomSing = s.split('<')[0]
  ret.declension = get decl
  return some ret

#test "getNounsFromTemplateArgument":
  #check getReducedNounFromTemplateArgument("{{la-noun|via<1>}}") == ("via", "1", "f")
  #check getReducedNounFromTemplateArgument("{{la-proper noun|Abaddōn|g=m|indecl=1}}") == ReducedNoun(word: "Abaddōn", "indecl")]

func parseNounTemplate(split: seq[string]): Option[AllWordForms] =
  assert split[0] in NounKeywords
  var noun = getReducedNounFromTemplateArg(split[1])
  if noun.isSome:
    get(noun).gender = guessGender(split)
    return some declineNoun(get(noun))


func parseVerbTemplate(split: seq[string]): Option[AllWordForms] =
  assert split[0] in VerbKeywords
  let firstPrincipalPart = split[2]
  case split[1]
    of "1":
      return some conjugateVerb(firstPrincipalPart, VerbConjugation.First)
    of "1+", "1+.poet-sync-perf":
      return some conjugateVerb(firstPrincipalPart, VerbConjugation.FirstWithPerfectStemInAv)

func parseTemplate*(s: string): Option[AllWordForms] =
  let split = s.strip(chars = {'{', '}'} + Whitespace).split('|')
  case split[0]
  of NounKeywords: return parseNounTemplate(split)
  of VerbKeywords: return parseVerbTemplate(split)
  # TODO: More.
  else: return none(AllWordForms)
