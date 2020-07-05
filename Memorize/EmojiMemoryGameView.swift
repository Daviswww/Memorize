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
        VStack{
            Grid(viewModel.cards){ card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear){
                        self.viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(Color.orange)
            .font(Font.largeTitle)
            Button(
            action: {
                withAnimation(.easeInOut){
                    self.viewModel.restGame()
                }
            }, label: {
                Text("New Game")
            })
        }
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card

    var body: some View{
        GeometryReader{ geometry in
            if self.card.isFaceUp || !self.card.isMathched {
                self.body(for: geometry.size)
            }
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusRemaining)){
            animatedBonusRemaining = 0
        }
    }
    
    private func body(for size: CGSize) -> some View {
        ZStack{
            Group{
                if card.isConsumingBonustime {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                        .padding(5)
                        .opacity(0.4)
                        .onAppear{
                            self.startBonusTimeAnimation()
                    }
                }else{
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                }
            }


            Text(card.content)
                .font(Font.system(size: fortSize(for: size)))
                .rotationEffect(Angle.degrees(card.isMathched ? 360 : 0))
                .animation(card.isMathched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
        }
        .cardify(isFaceUp: card.isFaceUp)
        .transition(AnyTransition.scale)
        
    }
    
    // MARK: - Drawing Constants
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
