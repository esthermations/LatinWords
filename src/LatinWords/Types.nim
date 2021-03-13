type

  Mood* = enum
    Indicative = "indicative",
    Subjunctive = "subjunctive",
    Imperative = "imperative"

  Voice* = enum
    Active = "active",
    Passive = "passive"

  Aspect* = enum
    Present = "present",
    Imperfect = "imperfect",
    Future = "future",
    Perfect = "perfect",
    Pluperfect = "pluperfect",
    FuturePerfect = "future-perfect"

  Number* = enum
    Single = "singular",
    Plural = "plural"

  Person* = enum
    First = "first-person",
    Second = "second-person",
    Third = "third-person"

  AllVerbalVerbForms* = array[Mood, array[Voice, array[Aspect, array[Number, array[Person, string]]]]]

  NounCase* = enum
    Nom = "nominative",
    Gen = "genitive",
    Dat = "dative",
    Acc = "accusative",
    Abl = "ablative",
    Voc = "vocative",
    Loc = "locative"

  Gender* = enum
    Unknown = "unknown",
    Masculine = "masculine",
    Neuter = "neuter",
    Feminine = "feminine"

  AllNounForms* = array[Number, array[NounCase, string]]

  ### All info needed to produce all forms of a noun
  NounTemplate* = object
    nomSing*: string
    stem2*: string # Something like "pulchr" is for "pulcher"
    gender*: Gender
    declension*: NounDeclension
    # Boolean fields. These should correspond to '.something' in the declension
    # field of a Wiktionary noun template, e.g. '1.loc' means 1st declension
    # where hasLocative=true.
    hasLocative*: bool
    hasDativePluralInAbus*: bool

  VerbTemplate* = object
    principalPart*: array[4, string]
    conjugation*: VerbConjugation

  VerbConjugation* {.pure.} = enum
    First

  NounDeclension* {.pure.} = enum
    First, Second

  WordKind* {.pure.} = enum Unknown, Noun, Verb

  AllWordForms* = object
    case kind*: WordKind
    of WordKind.Unknown:
      nil
    of WordKind.Noun:
      gender*: Gender
      nounForms*: AllNounForms
    of WordKind.Verb:
      verbForms*: AllVerbalVerbForms

  NounIdentifier* = tuple[nomSing: string, n: Number, c: NounCase]
  VerbIdentifier* = tuple[
    firstPrincipalPart: string,
    m: Mood,
    v: Voice,
    a: Aspect,
    n: Number,
    p: Person
  ]

  WordForm* = object
    word*: string
    case kind*: WordKind
    of WordKind.Unknown: nil
    of WordKind.Noun: nounID*: NounIdentifier
    of WordKind.Verb: verbID*: VerbIdentifier

func getDictionaryForm*(w: WordForm): string =
  case w.kind:
  of WordKind.Unknown: ""
  of WordKind.Noun: w.nounID.nomSing
  of WordKind.Verb: w.verbID.firstPrincipalPart

func getDictionaryForm*(w: AllWordForms): string =
  case w.kind:
  of WordKind.Unknown: ""
  of WordKind.Noun: w.nounForms[Number.Single][NounCase.Nom]
  of WordKind.Verb: w.verbForms[Mood.Indicative][Voice.Active][Aspect.Present][Number.Single][Person.First]

func `==`*(a, b: AllWordForms): bool =
  if a.kind != b.kind:
    return false
  case a.kind
  of WordKind.Unknown: false
  of WordKind.Noun: (b.kind       == a.kind and
                     b.gender     == a.gender and
                     b.nounForms  == a.nounForms)
  of WordKind.Verb: (a == b)

func `==`*(a, b: WordForm): bool =
  if a.kind != b.kind:
    return false
  case a.kind
  of WordKind.Unknown: false
  of WordKind.Noun: (a.nounID == b.nounID)
  of WordKind.Verb: (a.verbID == b.verbID)
