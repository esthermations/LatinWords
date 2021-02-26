import unittest, options
import LatinWords
import LatinWords/Types

suite "getAllWordForms":
  const tests = [
    "{{la-verb|1+.poet-sync-perf|amō}}",
    "{{la-verb|1+|clāmō}}"
  ]

  test tests[0]:
    let wf = getAllWordForms(tests[0])
    check wf.kind == WordKind.Verb
    var
      m = Mood.Indicative
      v = Voice.Active
      a = Aspect.Present
      n = Number.Single
      p = Person.First
    check wf.verbForms[m][v][a][n][p] == "amō"
    v = Voice.Passive
    check wf.verbForms[m][v][a][n][p] == "amor"
    a = Aspect.Perfect
    check wf.verbForms[m][v][a][n][p] == ""

  test tests[1]:
    let wf = getAllWordForms(tests[1])
    check wf.kind == WordKind.Verb

suite "deMacronise":
  test "clamō": check "clamō".deMacronise() == "clamo"
  test "hīc": check "hīc".deMacronise() == "hic"

suite "guessWordForm":
  const tests = [
    "clamō",
    "clamo",
    "clamat"
  ]
  test tests[0]:
    let wf = guessWordForm(tests[0])
    check wf.len > 0
  test tests[1]:
    let wf = guessWordForm(tests[1])
    check wf.len > 0
  test tests[2]:
    let wf = guessWordForm(tests[2])
    check wf.len == 1
    # check wf.kind == WordKind.Verb
    # check wf.getDictionaryForm() == "clamō"
