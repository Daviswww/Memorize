//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by datalab on 2020/6/20.
//  Copyright © 2020 datalab. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private(set) var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
        
    private static func createMemoryGame() -> MemoryGame<String>{
        let emoji: Array<String> = ["🥺", "🤥", "🥴"]
        return MemoryGame<String>(numberOfPairsOfCards: emoji.count){ pairIndex in
            return emoji[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func restGame(){
        model = EmojiMemoryGame.createMemoryGame()
    }
}
