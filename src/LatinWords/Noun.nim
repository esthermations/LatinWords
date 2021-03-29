import strutils
import Types, NounConstants

# Produce all valid forms of nouns of a given declension.
# Let's start with second, cause it's simple.

# Forward declarations of public interface
func declineNoun*(noun: NounTemplate): AllWordForms

# Forward declarations of private functions
func firstDeclension (noun: NounTemplate): AllWordForms
func secondDeclension(noun: NounTemplate): AllWordForms


# Return noun declinations for the given Nominative Singular form according to
# the type of word in `declension`.
func declineNoun*(noun: NounTemplate): AllWordForms =
  case noun.declension
  of NounDeclension.First: return firstDeclension(noun)
  of NounDeclension.Second: return secondDeclension(noun)

#
#
# First declension
#
#

func firstDeclensionStem(nomSing: string): string =
  let endings = [ "a", "ās", "ēs", "ē" ]
  for e in endings:
    if nomSing.endsWith(e):
      return nomSing[0 .. ^e.len]

### Produce declinations for a 1st declension noun
func firstDeclension(noun: NounTemplate): AllWordForms =
  let
    nomSing = noun.nomSing
    stem = firstDeclensionStem(nomSing)
  var
    forms: AllNounForms
    # If the user knows the gender of this noun, use that, otherwise it'll be
    # feminine because this is the first declension, land of the women.
    gender = (if noun.gender != Gender.Unknown: noun.gender
              else: Gender.Feminine)

  # Simplest case
  for n in Number:
    for c in NounCase:
      forms[n][c] = stem & StandardNounCaseEndings[NounDeclension.First][n][c]

  if noun.hasLocative:
    forms[Single][Loc] = stem & "ae"
    forms[Plural][Loc] = stem & "īs"

  if noun.hasDativePluralInAbus:
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

  return AllWordForms(kind: WordKind.Noun, gender: gender, nounForms: forms)

#
#
# Second declension
#
#

# FIXME: duplicated function also exists in WikiText.nim
func guessGender(noun: NounTemplate): Gender =
  let nomSing = noun.nomSing
  case noun.declension
  of NounDeclension.First: return Gender.Feminine
  of NounDeclension.Second:
    if nomSing.endsWith("um"):
      return Gender.Neuter
    else:
      return Gender.Masculine
  return Gender.Unknown

func secondDeclension(noun: NounTemplate): AllWordForms =
  assert noun.declension == NounDeclension.Second
  let
    nomSing = noun.nomSing
    stem = (if nomSing.endsWith("us") or nomSing.endsWith("um"):
              nomSing[0 ..^ 3]
            else: nomSing)
    stem2 = (if noun.stem2.len != 0: noun.stem2 else: stem)
    # Use the user-specified gender if there is one, otherwise guess it idk.
    gender = (if noun.gender != Gender.Unknown: noun.gender
              else: guessGender(noun))

  var forms: AllNounForms

  # Basic case
  for n in Number:
    for c in NounCase:
      forms[n][c] = stem & StandardNounCaseEndings[NounDeclension.Second][n][c]

  if gender == Gender.Neuter:
    forms[Single][Nom] = stem & "um"
    forms[Single][Voc] = stem & "um"

    forms[Plural][Nom] = stem & "a"
    forms[Plural][Acc] = stem & "a"
    forms[Plural][Voc] = stem & "a"

    # Deliberately ignoring Wiktionary's handling of "-ium" neuter nouns because
    # to me it looks like they're the same as "-um" neuter nouns except with the
    # occasional genitive in "-ī" instead of "-iī", which I don't care about.

    # Ignoring -om because it's archaic.

    if nomSing.endsWith("os"):
      forms[Single][Nom] = stem & "os"
      forms[Single][Acc] = stem & "os"
      forms[Single][Voc] = stem & "os"

      forms[Plural][Nom] = stem & "ē"
      forms[Plural][Gen] = stem & "ōn"
      forms[Plural][Acc] = stem & "ē"
      forms[Plural][Voc] = stem & "ē"

    elif nomSing.endsWith("on"):
      forms[Single][Nom] = stem & "on"
      forms[Single][Acc] = stem & "on"
      forms[Single][Voc] = stem & "on"

  elif nomSing.endsWith("r"):
      forms[Single][Nom] = stem
      forms[Single][Gen] = stem2 & "ī"
      forms[Single][Dat] = stem2 & "ō"
      forms[Single][Acc] = stem2 & "um"
      forms[Single][Abl] = stem2 & "ō"
      forms[Single][Voc] = stem

      forms[Plural][Nom] = stem2 & "ī"
      forms[Plural][Gen] = stem2 & "ōrum"
      forms[Plural][Dat] = stem2 & "īs"
      forms[Plural][Acc] = stem2 & "ōs"
      forms[Plural][Abl] = stem2 & "īs"
      forms[Plural][Voc] = stem2 & "ī"

  if noun.hasLocative:
    forms[Single][Loc] = stem2 & "ī"
    forms[Plural][Loc] = stem2 & "īs"

  return AllWordForms(kind: WordKind.Noun, gender: gender, nounForms: forms)

