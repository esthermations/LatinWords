import strutils
import Types

# Produce all valid forms of nouns of a given declension.
# Let's start with second, cause it's simple.

# Forward declarations of public interface
func declineNoun*(reducedNoun: ReducedNoun): AllWordForms

# Forward declarations of private functions
func firstDeclension(reducedNoun: ReducedNoun): AllWordForms


### Return noun declinations for the given Nominative Singular form according to
### the type of word in `declension`.
func declineNoun*(reducedNoun: ReducedNoun): AllWordForms =
  case reducedNoun.declension
  of NounDeclension.First, FirstWithLocative, FirstWithDativePluralInAbus:
    return firstDeclension(reducedNoun)

#
#
# First declension
#
#

const
  UnimplementedNounDeclension = [
    Number.Single: [ Nom: "", Gen: "", Dat: "", Acc: "", Abl: "", Voc: "", Loc: "" ],
    Number.Plural: [ Nom: "", Gen: "", Dat: "", Acc: "", Abl: "", Voc: "", Loc: "" ]
  ]

  StandardNounCaseEndings* = [
    NounDeclension.First: [
      Number.Single: [
        Nom: "a",
        Gen: "ae",
        Dat: "ae",
        Acc: "am",
        Abl: "ā",
        Voc: "a",
        Loc: ""
      ],
      Number.Plural: [
        Nom: "ae",
        Gen: "ārum",
        Dat: "īs",
        Acc: "ās",
        Abl: "īs",
        Voc: "ae",
        Loc: ""
      ]
    ],
    NounDeclension.FirstWithLocative: UnimplementedNounDeclension,
    NounDeclension.FirstWithDativePluralInAbus: UnimplementedNounDeclension,
  ]

func firstDeclensionStem(nomSing: string): string =
  let l = nomSing.len
  if nomSing.endsWith("a"): return nomSing[0 ..< l-1]
  elif nomSing.endsWith("ās"): return nomSing[0 ..< l-3]
  elif nomSing.endsWith("ēs"): return nomSing[0 ..< l-3]
  elif nomSing.endsWith("ē"): return nomSing[0 ..< l-2]
  else: assert false; return nomSing

### Produce declinations for a 1st declension noun
func firstDeclension(reducedNoun: ReducedNoun): AllWordForms =
  let
    stem = firstDeclensionStem(reducedNoun.nomSing)
    nomSing = reducedNoun.nomSing
    hasLocative =
      (reducedNoun.declension == NounDeclension.FirstWithLocative)
    hasDativePluralInAbus =
      (reducedNoun.declension == NounDeclension.FirstWithDativePluralInAbus)
  var
    forms: AllNounForms
    # If the user knows the gender of this noun, use that, otherwise it'll be
    # feminine because this is the first declension, land of the women.
    retGender = (if reducedNoun.gender == Gender.Unknown: Gender.Feminine
                 else: reducedNoun.gender)

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

  return AllWordForms(kind: WordKind.Noun, gender: retGender, nounForms: forms)

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