import strutils

# Produce all valid forms of nouns of a given declension.
# Let's start with second, cause it's simple.

type
  Case* = enum
    Nom, Gen, Dat, Acc, Abl, Voc

  Number* = enum
    Singular, Plural

  Gender* = enum
    Masculine, Neuter, Feminine

  CaseForms = array[Case, string]
  Noun* = array[Number, CaseForms]

func guessGender(nomSing: string): Gender =
  if nomSing.endsWith("us"): return Masculine
  if nomSing.endsWith("or"): return Masculine
  if nomSing.endsWith("um"): return Neuter
  if nomSing.endsWith("a"): return Feminine
  if nomSing.endsWith("io"): return Feminine
  return Masculine

func secondDeclension*(nomSing: string): Noun =
  assert nomSing.endsWith("us") or nomSing.endsWith("um")
  let
    stem = nomSing[0 ..< nomSing.len - 2]
    gender = guessGender(nomSing)

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
      ],
      Plural : [
        Nom: stem & "ī",
        Gen: stem & "ōrum",
        Dat: stem & "īs",
        Acc: stem & "ōs",
        Abl: stem & "īs",
        Voc: stem & "ī",
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
      ],
      Plural : [
        Nom: stem & "a",
        Gen: stem & "ōrum",
        Dat: stem & "īs",
        Acc: stem & "a",
        Abl: stem & "īs",
        Voc: stem & "a",
      ]
    ]

func firstDeclension*(nomSing: string): Noun =
  assert nomSing.endsWith("a")
  let stem = nomSing[0 ..< nomSing.len - 1]
  return [
    Singular: [
      Nom: nomSing,
      Gen: stem & "ae",
      Dat: stem & "ae",
      Acc: stem & "am",
      Abl: stem & "ā",
      Voc: nomSing,
    ],
    Plural : [
      Nom: stem & "ae",
      Gen: stem & "ārum",
      Dat: stem & "īs",
      Acc: stem & "ās",
      Abl: stem & "īs",
      Voc: stem & "ae",
    ]
  ]

