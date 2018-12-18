//
//  CardGame.swift
//  实验七
//
//  Created by student on 2018/12/18.
//  Copyright © 2018年 baoxinbei. All rights reserved.
//

import Foundation

class CardGame
{
    //所有卡片的数组
    var cards = [Card]()
    var add = false
    var indexOfOneAndOnlyFaceUpCard : Int?
    func chooseCard(at index : Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard,matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    add = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards :Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        
    }
}

