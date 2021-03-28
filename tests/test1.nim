import unittest, options
import
  LatinWords,
  LatinWords/Types,
  LatinWords/WikiText,
  TestConstants

suite "Eyeball iterator tests":
  let wordForms = parseTemplate("{{la-verb|1+.poet-sync-perf|amō}}").get()
  for form in wordForms:
    echo form.word

suite "getAllWordForms":
  const tests = [
    "{{la-verb|1+.poet-sync-perf|amō}}",
    "{{la-verb|1+|clāmō}}",
  ]

  test "{{la-noun|servus<2>|f=serva}}":
    let t = "{{la-noun|servus<2>|f=serva}}"
    let oWordForms = parseTemplate(t)
    require oWordForms.isSome()

    let wf = get oWordForms
    check wf.kind == WordKind.Noun

    let forms = wf.nounForms
    check forms[Single][Nom] == "servus"
    check forms[Single][Gen] == "servī"
    check forms[Single][Dat] == "servō"
    check forms[Single][Acc] == "servum"
    check forms[Single][Abl] == "servō"
    check forms[Single][Voc] == "serve"

    check forms[Plural][Nom] == "servī"
    check forms[Plural][Gen] == "servōrum"
    check forms[Plural][Dat] == "servīs"
    check forms[Plural][Acc] == "servōs"
    check forms[Plural][Abl] == "servīs"
    check forms[Plural][Voc] == "servī"

  test "{{la-noun|ager/agr<2>}}":
    let t = "{{la-noun|ager/agr<2>}}"
    let oWordForms = parseTemplate(t)
    require oWordForms.isSome()

    let wf = get oWordForms
    check wf.kind == WordKind.Noun

    let forms = wf.nounForms
    check forms[Single][Nom] == "ager"
    check forms[Single][Gen] == "agrī"
    check forms[Single][Dat] == "agrō"
    check forms[Single][Acc] == "agrum"
    check forms[Single][Abl] == "agrō"
    check forms[Single][Voc] == "ager"

    check forms[Plural][Nom] == "agrī"
    check forms[Plural][Gen] == "agrōrum"
    check forms[Plural][Dat] == "agrīs"
    check forms[Plural][Acc] == "agrōs"
    check forms[Plural][Abl] == "agrīs"
    check forms[Plural][Voc] == "agrī"


  test "{{la-noun|puer<2>|f=puera}}":
    let t = "{{la-noun|puer<2>|f=puera}}"
    let oWordForms = parseTemplate(t)
    require oWordForms.isSome()

    let wf = get oWordForms
    check wf.kind == WordKind.Noun

    let forms = wf.nounForms
    check forms[Single][Nom] == "puer"
    check forms[Single][Gen] == "puerī"
    check forms[Single][Dat] == "puerō"
    check forms[Single][Acc] == "puerum"
    check forms[Single][Abl] == "puerō"
    check forms[Single][Voc] == "puer"

    check forms[Plural][Nom] == "puerī"
    check forms[Plural][Gen] == "puerōrum"
    check forms[Plural][Dat] == "puerīs"
    check forms[Plural][Acc] == "puerōs"
    check forms[Plural][Abl] == "puerīs"
    check forms[Plural][Voc] == "puerī"

  test "amō":
    let wf = getAllWordForms(tests[0])
    check wf.kind == WordKind.Verb
    for m in Mood:
      for v in Voice:
        for a in Aspect:
          for n in Number:
            for p in Person:
              let
                ours = wf.verbForms[m][v][a][n][p]
                wikt =  AllAmoForms[m][v][a][n][p]
              check ours == wikt

suite "getVerbStem":
  test "amō": check "amō".getVerbStem() == "am"
  test "amo": check "amo".getVerbStem() == "am"
  test "amās": check "amās".getVerbStem() == "am"
  test "amas": check "amas".getVerbStem() == "am"

suite "getNounStem":
  test "via": check "via".getNounStem() == "vi"
  test "viā": check "viā".getNounStem() == "vi"
  # Second declension
  #test "porcus": check "porcus".getNounStem() == "porc"
  #test "porcō": check "porcō".getNounStem() == "porc"

suite "deMacronise":
  test "clamō": check "clamō".deMacronise() == "clamo"
  test "hīc": check "hīc".deMacronise() == "hic"
  test "hic": check "hic".deMacronise() == "hic"
  test "āīūēōȳĀĪŪĒŌȲ": check "āīūēōȳĀĪŪĒŌȲ".deMacronise() == "aiueoyAIUEOY"

suite "guessWordForm":
  test "clamō":
    let results = guessWordForm("clamō")
    # Two things it can be here:
    #  1. second-declension ablative singular (stultō)
    #  2. first principal part of verb (clamō)
    require results.len == 2
    if results.len > 0:
      let
        noun = WordForm(
          word: "clamō",
          kind: WordKind.Noun,
          nounID: (
            nomSing: "clamus",
            n: Number.Single,
            c: NounCase.Dat
            # Could be Ablative too, but Dative will be found first.
          )
        )

        verb = WordForm(
          word: "clamō",
          kind: WordKind.Verb,
          verbID: (
            firstPrincipalPart: "clamō",
            m: Mood.Indicative,
            v: Voice.Active,
            a: Aspect.Present,
            n: Number.Single,
            p: Person.First
          )
        )

      check noun in results
      check verb in results

  test "amō":
    let results = guessWordForm("amō")
    require results.len == 2

    if results.len > 0:
      let
        noun = WordForm(
          word: "amō",
          kind: WordKind.Noun,
          nounID: (
            nomSing: "amus",
            n: Number.Single,
            c: NounCase.Dat
            # Could be Ablative too, but Dative will be found first.
          )
        )

        verb = WordForm(
          word: "amō",
          kind: WordKind.Verb,
          verbID: (
            firstPrincipalPart: "amō",
            m: Mood.Indicative,
            v: Voice.Active,
            a: Aspect.Present,
            n: Number.Single,
            p: Person.First
          )
        )

      check noun in results
      check verb in results

  test "Ensure macrons on suffixes don't affect results":
    check guessWordForm("clamo") == guessWordForm("clamō")
    check guessWordForm("clamas") == guessWordForm("clamās")

  test "clamō from clamat":
    let wf = guessWordForm("clamat")
    check wf.len == 1
    if wf.len > 0:
      check wf[0].kind == WordKind.Verb
      check wf[0].verbID.firstPrincipalPart == "clamō"
