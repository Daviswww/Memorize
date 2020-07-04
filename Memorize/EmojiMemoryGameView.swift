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
    
    private func body(for size: CGSize) -> some View {
        ZStack{
            if card.isFaceUp{
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.orange, lineWidth: edgeLineWidth)
                Circle()
                Text(card.content)
                    .foregroundColor(.black)
            }else{
                if !card.isMathched{
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
//            Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
//                .padding(5)
//                .opacity(0.4)
        }
        .font(Font.system(size: fortSize(for: size)))
//        .cardify(isFaceUp: card.isFaceUp)
    }
    
    // MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    private func fortSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        return EmojiMemoryGameView(viewModel: game)
    }
}
