import unittest
import LatinWords/Types
import LatinWords/Noun

suite "First Declension":
  test "via":
    const word = Word(
      kind: WordKind.Noun,
      gender: Feminine,
      forms: [
        Single: [
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
    )

    check word == declineNoun("via", First)

  test "patria":
    const word = declineNoun("patria", First).forms
    check word[Single][Gen] == word[Plural][Nom]
    check word[Single][Nom] == word[Single][Voc]
    check word[Single][Gen] == "patriae"
    check word[Plural][Nom] == word[Plural][Voc]

  test "Rōma":
    const word = declineNoun("Rōma", FirstWithLocative).forms
    check word[Single][Nom] == "Rōma"
    check word[Single][Loc] == "Rōmae"

  test "xiphiās":
    const word = declineNoun("xiphiās", First).forms
    check word[Single][Nom] == "xiphiās"
    check word[Single][Gen] == "xiphiae"
    check word[Single][Acc] == "xiphiān"
    check word[Single][Voc] == "xiphiā"
    check word[Plural][Acc] == "xiphiās"
    check word[Plural][Voc] == "xiphiae"

  test "fīlia":
    const word = declineNoun("fīlia", FirstWithDativePluralInAbus).forms
    check word[Plural][Dat] == "fīliābus"
    check word[Plural][Abl] == "fīliābus"
    check word[Single][Nom] == "fīlia"
    check word[Single][Gen] == "fīliae"

#suite "Second Declension":
#  test "campus":
#    const word: Noun = [
#      Single: [
#        Nom: "campus",
#        Gen: "campī",
#        Dat: "campō",
#        Acc: "campum",
#        Abl: "campō",
#        Voc: "campe",
#        Loc: "",
#      ],
#      Plural: [
#        Nom: "campī",
#        Gen: "campōrum",
#        Dat: "campīs",
#        Acc: "campōs",
#        Abl: "campīs",
#        Voc: "campī",
#        Loc: "",
#      ]
#    ]
#
#    check word == secondDeclension("campus")
#
#  test "adverbium":
#    const word: Noun = [
#      Single: [
#        Nom: "adverbium",
#        Gen: "adverbiī",
#        Dat: "adverbiō",
#        Acc: "adverbium",
#        Abl: "adverbiō",
#        Voc: "adverbium",
#        Loc: "",
#      ],
#      Plural: [
#        Nom: "adverbia",
#        Gen: "adverbiōrum",
#        Dat: "adverbiīs",
#        Acc: "adverbia",
#        Abl: "adverbiīs",
#        Voc: "adverbia",
#        Loc: "",
#      ]
#    ]
#
#    check word == secondDeclension("adverbium")
#
#  test "adventūrus":
#    const word = secondDeclension("adventūrus")
#    check word[Single][Acc] == "adventūrum"
#    check word[Plural][Gen] == "adventūrōrum"
#
#  test "amiculum":
#    const word = secondDeclension("amiculum")
#    check word[Single][Acc] == word[Single][Nom]
#    check word[Plural][Acc] == word[Plural][Nom]
#    check word[Plural][Nom] == "amicula"
#    check word[Plural][Gen] == "amiculōrum"
#
#