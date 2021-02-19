import strutils

# Produce all valid forms of nouns of a given declension.
# Let's start with second, cause it's simple.

type
  Case* = enum
    Nom, Gen, Dat, Acc, Abl, Voc, Loc

  Number* = enum
    Singular, Plural

  Gender* = enum
    Masculine, Neuter, Feminine

  CaseForms = array[Case, string]
  Noun* = array[Number, CaseForms]

  NounOptionsAvailable = enum
    DativeAblativePluralInAbus,
    NominativeSingularInAm,
    Greek,
    GreekWithNominativeSingularInAs,
    GreekWithNominativeSingularInEs,
    HasLocative,

  NounOptions = array[NounOptionsAvailable, bool]

const
  noNounOptions: NounOptions = [
    DativeAblativePluralInAbus: false,
    NominativeSingularInAm: false,
    Greek: false,
    GreekWithNominativeSingularInAs: false,
    GreekWithNominativeSingularInEs: false,
    HasLocative: false,
  ]

#
#
# First declension
#
#

func firstDeclensionAnalyse(nomSing: string, hasLocative = false): (string, NounOptions) =
  let l = nomSing.len
  var opts = noNounOptions
  opts[HasLocative] = hasLocative

  if nomSing.endsWith("a"):
    return (nomSing[0 ..< l-1], opts)
  elif nomSing.endsWith("ās"):
    opts[Greek] = true
    opts[GreekWithNominativeSingularInAs] = true
    return (nomSing[0 ..< l-3], opts)
  elif nomSing.endsWith("ēs"):
    opts[Greek] = true
    opts[GreekWithNominativeSingularInEs] = true
    return (nomSing[0 ..< l-3], opts)
  elif nomSing.endsWith("ē"):
    opts[Greek] = true
    return (nomSing[0 ..< l-2], opts)
  else:
    assert false
    return (nomSing, opts)

func firstDeclension*(nomSing: string, hasLocative = false): Noun =
  let (stem, options) = firstDeclensionAnalyse(nomSing, hasLocative)
  var ret: Noun
  # Simplest case
  ret[Singular][Nom] = stem & "a"
  ret[Singular][Gen] = stem & "ae"
  ret[Singular][Dat] = stem & "ae"
  ret[Singular][Acc] = stem & "am"
  ret[Singular][Abl] = stem & "ā"
  ret[Singular][Voc] = stem & "a"
  ret[Plural][Nom] = stem & "ae"
  ret[Plural][Gen] = stem & "ārum"
  ret[Plural][Dat] = stem & "īs"
  ret[Plural][Acc] = stem & "ās"
  ret[Plural][Abl] = stem & "īs"
  ret[Plural][Voc] = stem & "ae"

  if options[DativeAblativePluralInAbus]:
    ret[Plural][Dat] = stem & "ābus"
    ret[Plural][Abl] = stem & "ābus"

  if options[NominativeSingularInAm]:
    ret[Singular][Nom] = stem & "ām"
    ret[Singular][Acc] = stem & "ām"
    ret[Singular][Voc] = stem & "ām"
    ret[Singular][Abl] = stem & "ām" # or "ā" but I don't care :)

  if options[Greek]:
    if options[GreekWithNominativeSingularInAs]:
      ret[Singular][Nom] = stem & "ās"
      ret[Singular][Acc] = stem & "ān"
      ret[Singular][Voc] = stem & "ā"
    elif options[GreekWithNominativeSingularInEs]:
      ret[Singular][Nom] = stem & "ēs"
      ret[Singular][Acc] = stem & "ēn"
      ret[Singular][Abl] = stem & "ē"
      ret[Singular][Voc] = stem & "ē"
    else:
      ret[Singular][Nom] = stem & "ē"
      ret[Singular][Gen] = stem & "ēs"
      ret[Singular][Acc] = stem & "ēn"
      ret[Singular][Abl] = stem & "ē"
      ret[Singular][Voc] = stem & "ē"

  if options[HasLocative]:
    ret[Singular][Loc] = stem & "ae"
    ret[Plural][Loc] = stem & "īs"

  return ret

#
#
# Second declension
#
#

func secondDeclension*(nomSing: string,
                       options: NounOptions = noNounOptions): Noun =
  assert nomSing.endsWith("us") or nomSing.endsWith("um")
  let
    stem = nomSing[0 ..< nomSing.len - 2]
    gender = Masculine # TODO

  return case gender
  of Masculine, Feminine:
    [
      Singular: [
        Nom: nomSing,
        Gen: stem & "ī",
        Dat: stem & "ō",
        Acc: stem & "um",
        Abl: stem & "ō",
        Voc: stem & "e",
        Loc: ""
      ],
      Plural : [
        Nom: stem & "ī",
        Gen: stem & "ōrum",
        Dat: stem & "īs",
        Acc: stem & "ōs",
        Abl: stem & "īs",
        Voc: stem & "ī",
        Loc: ""
      ]
    ]
  of Neuter:
    [
      Singular: [
        Nom: nomSing,
        Gen: stem & "ī",
        Dat: stem & "ō",
        Acc: nomSing,
        Abl: stem & "ō",
        Voc: nomSing,
        Loc: ""
      ],
      Plural : [
        Nom: stem & "a",
        Gen: stem & "ōrum",
        Dat: stem & "īs",
        Acc: stem & "a",
        Abl: stem & "īs",
        Voc: stem & "a",
        Loc: ""
      ]
    ]

