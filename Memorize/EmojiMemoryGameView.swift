//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by datalab on 2020/6/20.
//  Copyright © 2020 datalab. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        Grid(viewModel.cards){ card in
            CardView(card: card).onTapGesture {
                self.viewModel.choose(card: card)
            }
            .padding(5)
        }
        .padding()
        .foregroundColor(Color.orange)
        .font(Font.largeTitle)
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View{
        GeometryReader{ geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack{
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.orange, lineWidth: 3)
                Text(card.content)
            } else {
                if !card.isMathched {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill()
                }
            }
        }
        .font(Font.system(size: fortSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    let forScaleFactor: CGFloat = 0.75
    
    func fortSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.75
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
