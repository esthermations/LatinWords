import Types

const
  NoSuchForms* = [["","",""],["","",""]]

  PerfectActiveForms* = [
    Indicative: [
      Perfect      : [["ī",    "istī", "it"  ], ["imus",   "istis",  "ērunt"]],
      Pluperfect   : [["eram", "erās", "erat"], ["erāmus", "erātis", "erant"]],
      FuturePerfect: [["erō",  "eris", "erit"], ["erimus", "eritis", "erint"]],
    ],
    Subjunctive: [
      Perfect      : [["erim",  "erīs",  "erit" ], ["erīmus",  "erītis",  "erint" ]],
      Pluperfect   : [["issem", "issēs", "isset"], ["issēmus", "issētis", "issent"]],
      FuturePerfect: NoSuchForms,
    ]
  ]

  StandardVerbFormEndings* = [

    #
    #
    # First conjugation
    #
    #

    VerbConjugation.First: [
      Indicative: [
        Active: [
          Present      : [ Number.Single: [ Person.First: "ō",    Second: "ās",   Third: "at"  ],
                           Number.Plural: [ Person.First: "āmus", Second: "ātis", Third: "ant" ] ],
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
          # TODO: These are passive perfect participle + corresponding conjugation
          # of sum.
          Perfect      : NoSuchForms,
          Pluperfect   : NoSuchForms,
          FuturePerfect: NoSuchForms,
        ]
      ],
      Subjunctive: [
        Active: [
          Present      : [ [ "em",   "ēs",  "et"    ], [ "ēmus",   "ētis",   "ent"   ] ],
          Imperfect    : [ [ "ārem", "ārēs", "āret" ], [ "ārēmus", "ārētis", "ārent" ] ],
          Future       : NoSuchForms,
          Perfect      : PerfectActiveForms[Subjunctive][Perfect],
          Pluperfect   : PerfectActiveForms[Subjunctive][Pluperfect],
          FuturePerfect: PerfectActiveForms[Subjunctive][FuturePerfect],
        ],
        Passive: [
          Present      : [ [ "er",   "ēris",   "ētur"  ], [ "ēmur",   "ēminī",   "entur"   ] ],
          Imperfect    : [ [ "ārer", "ārēris", "ārētur"], [ "ārēmur", "ārēminī", "ārentur" ] ],
          Future       : NoSuchForms,
          Perfect      : NoSuchForms,
          Pluperfect   : NoSuchForms,
          FuturePerfect: NoSuchForms,
        ]
     ],
      Imperative: [
        Active: [
          Present      : [["", "ā",   ""   ], ["", "āte",   ""    ]],
          Imperfect    : NoSuchForms,
          Future       : [["", "ātō", "ātō"], ["", "ātōte", "antō"]],
          Perfect      : NoSuchForms,
          Pluperfect   : NoSuchForms,
          FuturePerfect: NoSuchForms,
        ],
        Passive: [
          Present      : [["", "āre",   ""   ], ["", "āminī", ""     ]],
          Imperfect    : NoSuchForms,
          Future       : [["", "ātor", "ātor"], ["", "",      "antor"]],
          Perfect      : NoSuchForms,
          Pluperfect   : NoSuchForms,
          FuturePerfect: NoSuchForms,
        ]
      ]
    ]

    #
    #
    # Second conjugation
    #
    #

    # TODO

    #
    #
    # Third conjugation
    #
    #

    # TODO

    #
    #
    # Fourth conjugation
    #
    #

    # TODO


  ]

