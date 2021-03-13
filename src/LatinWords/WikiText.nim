import strutils, sequtils, unittest, options
import Types, Noun, Verb

const
  NounKeywords = [ "la-noun", "la-proper noun" ]
  VerbKeywords = [ "la-verb" ]

func textBetween(str: string, a, b: char): string =
  let first = str.find(a)
  if first == -1: return ""
  let final = str.find(b, start = first)
  if final == -1: return ""
  return str[first + 1 .. final - 1]

test "textBetween":
  check "India<1>".textBetween('<', '>') == "1"
  check "Rōma<1.loc>".textBetween('<', '>') == "1.loc"

### Grab the gender of this noun if it is specified. If it's not specified, it's
### probably the "defualt" gender for its declesnion.
func guessGender(args: seq[string]): Gender =
  if args.count("g=f") > 0: return Gender.Feminine
  if args.count("g=m") > 0: return Gender.Masculine
  if args.count("g=n") > 0: return Gender.Neuter
  return Gender.Unknown

#test "getNounsFromTemplateArgument":
  #check getReducedNounFromTemplateArgument("{{la-noun|via<1>}}") == ("via", "1", "f")
  #check getReducedNounFromTemplateArgument("{{la-proper noun|Abaddōn|g=m|indecl=1}}") == ReducedNoun(word: "Abaddōn", "indecl")]

func parseNounTemplate(args: seq[string]): Option[AllWordForms] =
  # For example:
  # {{la-noun|ager/agr<2>}}
  # {{la-noun|servus<2>|f=serva}}
  assert args.len >= 2
  assert args[0] in NounKeywords
  var t: NounTemplate
  t.gender = guessGender(args)


  # Handle declension string
  let declensionStr = args[1].textBetween('<', '>')

  if declensionStr.len == 0:
    # Indeclinable. TODO
    assert args.contains("indecl=y")
    return

  case declensionStr[0]:
  of '1': t.declension = NounDeclension.First
  of '2': t.declension = NounDeclension.Second
  else: return # Unimplemented form.

  if declensionStr.contains("."):
    let declArgs = declensionStr.split('.')
    if declArgs.contains("loc"):
      t.hasLocative = true
    if declArgs.contains("abus"):
      t.hasDativePluralInAbus = true

  # Handle noun and stems
  let word = args[1].split('<')[0]
  if word.contains("/"):
    t.nomSing = word.split('/')[0]
    t.stem2   = word.split('/')[1]
  else:
    t.nomSing = word

  return some declineNoun(t)

func parseVerbTemplate(args: seq[string]): Option[AllWordForms] =
  # For example:
  # {{la-verb|1+.poet-sync-perf|amō}}
  assert args.len >= 2
  assert args[0] in VerbKeywords
  let conjugationArg = args[1]
  let firstPrincipalPart = args[2]

  # TODO: Tidy up this function so it looks like parseNounTemplate. Put the
  # optional arguments to conjugateVerb into VerbTemplate and handle them here.

  case conjugationArg
    of "1":
      return some conjugateVerb(firstPrincipalPart, VerbConjugation.First)
    of "1+", "1+.poet-sync-perf":
      return some conjugateVerb(firstPrincipalPart, VerbConjugation.First, perfectStem = "āv")

func parseTemplate*(s: string): Option[AllWordForms] =
  let args = s.strip(chars = {'{', '}'} + Whitespace).split('|')
  # {{la-noun|servus<2>|f=serva}} --> ["la-noun", "servus<2>", "f=serva"]
  case args[0]
  of NounKeywords: return parseNounTemplate(args)
  of VerbKeywords: return parseVerbTemplate(args)
  # TODO: More.
  else: return
