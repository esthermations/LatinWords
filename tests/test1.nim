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

suite "deMacronise":
  test "clamō": check "clamō".deMacronise() == "clamo"
  test "hīc": check "hīc".deMacronise() == "hic"
  test "hic": check "hic".deMacronise() == "hic"
  test "āīūēōȳĀĪŪĒŌȲ": check "āīūēōȳĀĪŪĒŌȲ".deMacronise() == "aiueoyAIUEOY"

suite "guessWordForm":
  test "clamō":
    let wf = guessWordForm("clamō")
    check wf.len == 1
    if wf.len > 0:
      check wf[0].kind == WordKind.Verb
      if wf[0].kind == WordKind.Verb:
        check wf[0].verbID.firstPrincipalPart == "clamō"
  test "Ensure macrons don't affect results":
    check guessWordForm("clamo") == guessWordForm("clamō")
  test "clamō from clamat":
    let wf = guessWordForm("clamat")
    check wf.len == 1
    if wf.len > 0:
      check wf[0].kind == WordKind.Verb
      check wf[0].verbID.firstPrincipalPart == "clamō"
    # check wf.getDictionaryForm() == "clamō"
