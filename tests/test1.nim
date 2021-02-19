import unittest
import Noun

suite "First Declension":
  test "via":
    const word: Noun = [
      Singular: [
        Nom: "via",
        Gen: "viae",
        Dat: "viae",
        Acc: "viam",
        Abl: "viā",
        Voc: "via",
        Loc: "",
      ],
      Plural: [
        Nom: "viae",
        Gen: "viārum",
        Dat: "viīs",
        Acc: "viās",
        Abl: "viīs",
        Voc: "viae",
        Loc: "",
      ]
    ]

    check word == firstDeclension("via")

  test "patria":
    const word = firstDeclension("patria")
    check word[Singular][Gen] == word[Plural][Nom]
    check word[Singular][Nom] == word[Singular][Voc]
    check word[Singular][Gen] == "patriae"
    check word[Plural][Nom] == word[Plural][Voc]

  test "Rōma":
    const word = firstDeclension("Rōma", hasLocative = true)
    check word[Singular][Loc] == "Rōmae"

  test "xiphiās":
    const word = firstDeclension("xiphiās")

    check word[Singular][Nom] == "xiphiās"
    check word[Singular][Gen] == "xiphiae"
    check word[Singular][Acc] == "xiphiān"
    check word[Singular][Voc] == "xiphiā"
    check word[Plural][Acc] == "xiphiās"
    check word[Plural][Voc] == "xiphiae"


suite "Second Declension":
  test "campus":
    const word: Noun = [
      Singular: [
        Nom: "campus",
        Gen: "campī",
        Dat: "campō",
        Acc: "campum",
        Abl: "campō",
        Voc: "campe",
        Loc: "",
      ],
      Plural: [
        Nom: "campī",
        Gen: "campōrum",
        Dat: "campīs",
        Acc: "campōs",
        Abl: "campīs",
        Voc: "campī",
        Loc: "",
      ]
    ]

    check word == secondDeclension("campus")

  test "adverbium":
    const word: Noun = [
      Singular: [
        Nom: "adverbium",
        Gen: "adverbiī",
        Dat: "adverbiō",
        Acc: "adverbium",
        Abl: "adverbiō",
        Voc: "adverbium",
        Loc: "",
      ],
      Plural: [
        Nom: "adverbia",
        Gen: "adverbiōrum",
        Dat: "adverbiīs",
        Acc: "adverbia",
        Abl: "adverbiīs",
        Voc: "adverbia",
        Loc: "",
      ]
    ]

    check word == secondDeclension("adverbium")

  test "adventūrus":
    const word = secondDeclension("adventūrus")
    check word[Singular][Acc] == "adventūrum"
    check word[Plural][Gen] == "adventūrōrum"

  test "amiculum":
    const word = secondDeclension("amiculum")
    check word[Singular][Acc] == word[Singular][Nom]
    check word[Plural][Acc] == word[Plural][Nom]
    check word[Plural][Nom] == "amicula"
    check word[Plural][Gen] == "amiculōrum"

