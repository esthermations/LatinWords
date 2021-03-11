import unittest, options
import LatinWords
import LatinWords/Types
import TestConstants

suite "getAllWordForms":
  const tests = [
    "{{la-verb|1+.poet-sync-perf|amō}}",
    "{{la-verb|1+|clāmō}}"
  ]

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


  # TODO:
  # test "clamō":
  #   let wf = getAllWordForms(tests[1])
  #   check wf.kind == WordKind.Verb

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
    check results.len == 1
    if results.len > 0:
      let
        noun = WordForm(
          word: "clamō",
          kind: WordKind.Noun,
          nounID: (nomSing: "clamus", n: Number.Single, c: NounCase.Abl)
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

      #check noun in results
      check verb in results

  test "amō":
    let results = guessWordForm("amō")
    check results.len == 1
    if results.len > 0:
      check results[0].kind == WordKind.Verb
      check results[0].verbID.firstPrincipalPart == "amō"

  test "Ensure macrons on suffixes don't affect results":
    check guessWordForm("clamo") == guessWordForm("clamō")
    check guessWordForm("clamas") == guessWordForm("clamās")

  test "clamō from clamat":
    let wf = guessWordForm("clamat")
    check wf.len == 1
    if wf.len > 0:
      check wf[0].kind == WordKind.Verb
      check wf[0].verbID.firstPrincipalPart == "clamō"
