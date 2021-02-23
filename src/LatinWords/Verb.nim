import Types

type
  Mood = enum
    Indicative, Subjunctive, Imperative, NonFinite, VerbalNoun
  # NonFinite and VerbalNoun aren't really moods but sue me

  Voice = enum
    Active, Passive

  Aspect = enum
    Present, Imperfect, Future, Perfect, Pluperfect, FuturePerfect

  Number = enum
    Singular, Plural

  Person = enum
    First, Second, Third

  Verb = array[Mood, array[Voice, array[Aspect, array[Number, array[Person, string]]]]]

# Standard suffixes

const
  PerfectActiveForms = [
    Indicative: [
      Perfect      : [["ī",    "istī", "it"  ], ["imus",   "istis",  "ērunt"]],
      Pluperfect   : [["eram", "erās", "erat"], ["erāmus", "erātis", "erant"]],
      FuturePerfect: [["erō",  "eris", "erit"], ["erimus", "eritis", "erint"]],
    ],
    Subjunctive: [
      Perfect      : [["erim",  "erīs",  "erit" ], ["erīmus",  "erītis",  "erint" ]],
      Pluperfect   : [["issem", "issēs", "isset"], ["issēmus", "issētis", "issent"]],
      FuturePerfect: [["","",""],["","",""]], # None.
    ]
  ]

  FirstConjugationSuffixes: Verb = [
    Indicative: [
      Active: [
        Present      : [ [ "ō",    "ās",   "at"   ], [ "āmus",   "ātis",   "ant"   ] ],
        Imperfect    : [ [ "ābam", "ābās", "ābat" ], [ "ābāmus", "ābātis", "ābant" ] ],
        Future       : [ [ "ābō",  "ābis", "ābit" ], [ "ābimus", "ābitis", "ābunt" ] ],
        Perfect      : PerfectActiveForms[Indicative][Perfect],
        Pluperfect   : PerfectActiveForms[Indicative][Pluperfect],
        FuturePerfect: PerfectActiveForms[Indicative][FuturePerfect],
      ],
      Passive: [
        Present      : [ [ "or",   "āris",   "ātur"   ], [ "āmur",   "āminī",   "antur"  ] ],
        Imperfect    : [ [ "ābar", "ābāris", "ābātur" ], [ "ābāmur", "ābāminī", "ābantur"] ],
        Future       : [ [ "ābor", "āberis", "ābitur" ], [ "ābimur", "ābiminī", "ābuntur"] ],
        Perfect      : # TODO
        Pluperfect   : # TODO
        FuturePerfect: # TODO
      ]
    ],
    Subjunctive: [
      # TODO
    ],
    Imperative: [

    ]
  ]



func presentFirst(presentStem: string): Verb =
  var ret: Verb
  # Active indicative
  ret[Indicative][Active][Present][Singular][First] = "ō"





