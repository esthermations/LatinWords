# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest
import Noun

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
      ],
      Plural: [
        Nom: "campī",
        Gen: "campōrum",
        Dat: "campīs",
        Acc: "campōs",
        Abl: "campīs",
        Voc: "campī",
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
      ],
      Plural: [
        Nom: "adverbia",
        Gen: "adverbiōrum",
        Dat: "adverbiīs",
        Acc: "adverbia",
        Abl: "adverbiīs",
        Voc: "adverbia",
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

