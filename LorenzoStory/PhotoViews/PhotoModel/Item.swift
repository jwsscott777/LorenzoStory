//
//  Item.swift
//  LorenzoStory
//
//  Created by JWSScott777 on 6/1/24.
//

import SwiftUI

struct Item: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var title: String
    var image: UIImage?
    var previewImage: UIImage?
    var appeared: Bool = false
}

var sampleItems: [Item] = [
    .init(title: "BeastOne", image: UIImage(named: "Beast1")),
    .init(title: "BeastTwo", image: UIImage(named: "Beast2")),
    .init(title: "BeastThree", image: UIImage(named: "Beast3")),
    .init(title: "BeastFour", image: UIImage(named: "Beast4")),
    .init(title: "BeastFive", image: UIImage(named: "Beast5")),
    .init(title: "BeastSix", image: UIImage(named: "Beast6")),
    .init(title: "BeastSeven", image: UIImage(named: "Beast7")),
    .init(title: "BeastEight", image: UIImage(named: "Beast8")),
    .init(title: "BeastNine", image: UIImage(named: "Beast9")),
    .init(title: "BeastTen", image: UIImage(named: "Beast10")),
    .init(title: "BeastEleven", image: UIImage(named: "Beast11")),
    .init(title: "BeastTwelve", image: UIImage(named: "Beast12")),
    .init(title: "BeastThirteen", image: UIImage(named: "Beast13")),
    .init(title: "BeastFouteen", image: UIImage(named: "Beast14")),
    .init(title: "BeastFifteen", image: UIImage(named: "Beast15")),
    .init(title: "BeastSixteen", image: UIImage(named: "Beast16")),
    .init(title: "BeastSeventeen", image: UIImage(named: "Beast17")),
    .init(title: "BeastEighteen", image: UIImage(named: "Beast18")),
    .init(title: "BeastNineteen", image: UIImage(named: "Beast19")),
    .init(title: "BeastTwenty", image: UIImage(named: "Beast20")),
]
