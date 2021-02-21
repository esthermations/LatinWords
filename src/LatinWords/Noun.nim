import strutils
import Types

# Produce all valid forms of nouns of a given declension.
# Let's start with second, cause it's simple.

# Forward declarations of public interface
func declineNoun*(nomSing: string, declension: NounDeclension): Word

# Forward declarations of private functions
func firstDeclension(nomSing: string,
                     hasLocative = false,
                     hasDativePluralInAbus = false): Word


### Return noun declinations for the given Nominative Singular form according to
### the type of word in `declension`.
func declineNoun*(nomSing: string, declension: NounDeclension): Word =
  case declension
  of NounDeclension.First:
    return firstDeclension(nomSing)
  of NounDeclension.FirstWithLocative:
    return firstDeclension(nomSing, hasLocative = true)
  of NounDeclension.FirstWithDativePluralInAbus:
    return firstDeclension(nomSing, hasDativePluralInAbus = true)

#
#
# First declension
#
#

func firstDeclensionStem(nomSing: string): string =
  let l = nomSing.len
  if nomSing.endsWith("a"): return nomSing[0 ..< l-1]
  elif nomSing.endsWith("ās"): return nomSing[0 ..< l-3]
  elif nomSing.endsWith("ēs"): return nomSing[0 ..< l-3]
  elif nomSing.endsWith("ē"): return nomSing[0 ..< l-2]
  else: assert false; return nomSing

### Produce declinations for a 1st declension noun
func firstDeclension(nomSing: string,
                     hasLocative = false,
                     hasDativePluralInAbus = false): Word =
  let stem = firstDeclensionStem(nomSing)
  var
    forms: AllNounForms
    gender: Gender = Gender.Feminine # Assumption.

  # Simplest case
  forms[Single][Nom] = stem & "a"
  forms[Single][Gen] = stem & "ae"
  forms[Single][Dat] = stem & "ae"
  forms[Single][Acc] = stem & "am"
  forms[Single][Abl] = stem & "ā"
  forms[Single][Voc] = stem & "a"
  forms[Plural][Nom] = stem & "ae"
  forms[Plural][Gen] = stem & "ārum"
  forms[Plural][Dat] = stem & "īs"
  forms[Plural][Acc] = stem & "ās"
  forms[Plural][Abl] = stem & "īs"
  forms[Plural][Voc] = stem & "ae"

  if hasLocative:
    forms[Single][Loc] = stem & "ae"
    forms[Plural][Loc] = stem & "īs"

  if hasDativePluralInAbus:
    forms[Plural][Dat] = stem & "ābus"
    forms[Plural][Abl] = stem & "ābus"

  if nomSing.endsWith("ām"):
    forms[Single][Nom] = stem & "ām"
    forms[Single][Acc] = stem & "ām"
    forms[Single][Voc] = stem & "ām"
    forms[Single][Abl] = stem & "ām" # or "ā" but I don't care :)

  if nomSing.endsWith("ās"):
    forms[Single][Nom] = stem & "ās"
    forms[Single][Acc] = stem & "ān"
    forms[Single][Voc] = stem & "ā"
  elif nomSing.endsWith("ēs"):
    forms[Single][Nom] = stem & "ēs"
    forms[Single][Acc] = stem & "ēn"
    forms[Single][Abl] = stem & "ē"
    forms[Single][Voc] = stem & "ē"
  elif nomSing.endsWith("ē"):
    forms[Single][Nom] = stem & "ē"
    forms[Single][Gen] = stem & "ēs"
    forms[Single][Acc] = stem & "ēn"
    forms[Single][Abl] = stem & "ē"
    forms[Single][Voc] = stem & "ē"

  return Word(kind: WordKind.Noun, gender: gender, forms: forms)

#
#
# Second declension
#
#

# func secondDeclension*(nomSing: string,
#                        options: NounOptions = noNounOptions): Noun =
#   assert nomSing.endsWith("us") or nomSing.endsWith("um")
#   let
#     stem = nomSing[0 ..< nomSing.len - 2]
#     gender = Masculine # TODO
#
#   return case gender
#   of Masculine, Feminine:
#     [
#       Single: [
#         Nom: nomSing,
#         Gen: stem & "ī",
#         Dat: stem & "ō",
#         Acc: stem & "um",
#         Abl: stem & "ō",
#         Voc: stem & "e",
#         Loc: ""
#       ],
#       Plural : [
#         Nom: stem & "ī",
#         Gen: stem & "ōrum",
#         Dat: stem & "īs",
#         Acc: stem & "ōs",
#         Abl: stem & "īs",
#         Voc: stem & "ī",
#         Loc: ""
#       ]
#     ]
#   of Neuter:
#     [
#       Single: [
#         Nom: nomSing,
#         Gen: stem & "ī",
#         Dat: stem & "ō",
#         Acc: nomSing,
#         Abl: stem & "ō",
#         Voc: nomSing,
#         Loc: ""
#       ],
#       Plural : [
#         Nom: stem & "a",
#         Gen: stem & "ōrum",
#         Dat: stem & "īs",
#         Acc: stem & "a",
#         Abl: stem & "īs",
#         Voc: stem & "a",
#         Loc: ""
#       ]
#     ]
#
#