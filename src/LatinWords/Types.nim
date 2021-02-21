type
  Case* = enum
    Nom, Gen, Dat, Acc, Abl, Voc, Loc

  Number* = enum
    Single, Plural

  Gender* = enum
    Unknown, Masculine, Neuter, Feminine

  AllNounForms* = array[Number, array[Case, string]]

  NounDeclension* = enum
    First,
    FirstWithLocative,
    FirstWithDativePluralInAbus,

  WordKind* {.pure.} = enum Unknown, Noun

  Word* = object
    case kind*: WordKind
    of WordKind.Unknown:
      nil
    of WordKind.Noun:
      gender*: Gender
      forms*: AllNounForms

func `==`*(a, b: Word): bool =
  if a.kind != b.kind:
    return false
  case a.kind
  of WordKind.Unknown: false
  of Noun: (b.kind   == a.kind and
            b.gender == a.gender and
            b.forms  == a.forms)

