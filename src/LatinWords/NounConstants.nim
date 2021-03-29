import Types

const
  StandardNounCaseEndings* = [
    NounDeclension.First: [
      Number.Single: [
        Nom: "a",
        Gen: "ae",
        Dat: "ae",
        Acc: "am",
        Abl: "ā",
        Voc: "a",
        Loc: ""
      ],
      Number.Plural: [
        Nom: "ae",
        Gen: "ārum",
        Dat: "īs",
        Acc: "ās",
        Abl: "īs",
        Voc: "ae",
        Loc: ""
      ]
    ],
    NounDeclension.Second: [
      Number.Single: [
        Nom: "us",
        Gen: "ī",
        Dat: "ō",
        Acc: "um",
        Abl: "ō",
        Voc: "e",
        Loc: ""
      ],
      Number.Plural: [
        Nom: "ī",
        Gen: "ōrum",
        Dat: "īs",
        Acc: "ōs",
        Abl: "īs",
        Voc: "ī",
        Loc: ""
      ]
    ],
  ]

