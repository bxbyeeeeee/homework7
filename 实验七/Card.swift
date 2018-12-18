//
//  Card.swift
//  实验七
//
//  Created by student on 2018/12/18.
//  Copyright © 2018年 baoxinbei. All rights reserved.
//

import Foundation
//类Card
struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier : Int
    //卡片获取标识
    static var identifierFactory = -1
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}

