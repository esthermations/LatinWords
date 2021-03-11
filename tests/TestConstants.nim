import LatinWords/Types
from   LatinWords/VerbConstants import NoSuchForms, PerfectActiveForms

const
    # This is eye-checked against the one on Wiktionary
    AllAmoForms*: AllVerbalVerbForms = [
      Indicative: [
        Active: [
          #                  1ps         2ps         3ps             1pp           2pp           3pp
          Present      : [ [ "amō",      "amās",     "amat"     ], [ "amāmus",     "amātis",     "amant"     ] ],
          Imperfect    : [ [ "amābam",   "amābās",   "amābat"   ], [ "amābāmus",   "amābātis",   "amābant"   ] ],
          Future       : [ [ "amābō",    "amābis",   "amābit"   ], [ "amābimus",   "amābitis",   "amābunt"   ] ],
          Perfect      : [ [ "amāvī",    "amāvistī", "amāvit"   ], [ "amāvimus",   "amāvistis",  "amāvērunt" ] ],
          Pluperfect   : [ [ "amāveram", "amāverās", "amāverat" ], [ "amāverāmus", "amāverātis", "amāverant" ] ],
          FuturePerfect: [ [ "amāverō",  "amāveris", "amāverit" ], [ "amāverimus", "amāveritis", "amāverint" ] ]
        ],
        Passive: [
          #                  1ps        2ps        3ps             1pp         2pp          3pp
          Present      : [ [ "amor",   "amāris",   "amātur"   ], [ "amāmur",   "amāminī",   "amantur"   ] ],
          Imperfect    : [ [ "amābar", "amābāris", "amābātur" ], [ "amābāmur", "amābāminī", "amābantur" ] ],
          Future       : [ [ "amābor", "amāberis", "amābitur" ], [ "amābimur", "amābiminī", "amābuntur" ] ],
          Perfect      : NoSuchForms,
          Pluperfect   : NoSuchForms,
          FuturePerfect: NoSuchForms,
        ]
      ],
      Subjunctive: [
        Active: [
          #                  1ps          2ps          3ps              1pp            2pp            3pp
          Present      : [ [ "amem",      "amēs",      "amet"      ], [ "amēmus",      "amētis",      "ament"      ] ],
          Imperfect    : [ [ "amārem",    "amārēs",    "amāret"    ], [ "amārēmus",    "amārētis",    "amārent"    ] ],
          Future       : NoSuchForms,
          Perfect      : [ [ "amāverim",  "amāverīs",  "amāverit"  ], [ "amāverīmus",  "amāverītis",  "amāverint"  ] ],
          Pluperfect   : [ [ "amāvissem", "amāvissēs", "amāvisset" ], [ "amāvissēmus", "amāvissētis", "amāvissent" ] ],
          FuturePerfect: NoSuchForms,
        ],
        Passive: [
          Present      : [ [ "amer",   "amēris",   "amētur"  ], [ "amēmur",   "amēminī",   "amentur"   ] ],
          Imperfect    : [ [ "amārer", "amārēris", "amārētur"], [ "amārēmur", "amārēminī", "amārentur" ] ],
          Future       : NoSuchForms,
          Perfect      : NoSuchForms,
          Pluperfect   : NoSuchForms,
          FuturePerfect: NoSuchForms,
        ]
     ],
      Imperative: [
        Active: [
          Present      : [["", "amā",   ""   ], ["", "amāte",   ""    ]],
          Imperfect    : NoSuchForms,
          Future       : [["", "amātō", "amātō"], ["", "amātōte", "amantō"]],
          Perfect      : NoSuchForms,
          Pluperfect   : NoSuchForms,
          FuturePerfect: NoSuchForms,
        ],
        Passive: [
          Present      : [["", "amāre",  ""      ], ["", "amāminī", ""     ]],
          Imperfect    : NoSuchForms,
          Future       : [["", "amātor", "amātor"], ["", "",      "amantor"]],
          Perfect      : NoSuchForms,
          Pluperfect   : NoSuchForms,
          FuturePerfect: NoSuchForms,
        ]
      ]
    ]

