//
//  MemoryGame.swift
//  Memorize
//
//  Created by datalab on 2020/6/20.
//  Copyright © 2020 datalab. All rights reserved.
//

import Foundation

struct MemoryGame <CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get{
            cards.indices.filter { cards[$0].isFaceUp }.only
//            for index in cards.indices{
//                if cards[index].isFaceUp{
//                    faceUpCardIndices.append(index)
//                }
//            }
//            if faceUpCardIndices.count == 1{
//                return faceUpCardIndices.first
//            }else{
//                return nil
//            }
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMathched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    cards[chosenIndex].isMathched = true
                    cards[potentialMatchIndex].isMathched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            }else{

                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    func index(of card: Card) -> Int {
        for index in 0 ..< self.cards.count{
            if self.cards[index].id == card.id{
                return index
            }
        }
        // TODO: bogus
        return 0
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMathched: Bool = false
        var content: CardContent
        var id: Int
    }
}
