//
//  FlashCardify.swift
//  LearnTheLingoApp
//
//  Created by IS 543 on 10/26/24.
//

import SwiftUI

struct FlashCardify: Animatable, ViewModifier {
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation: Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
               if isFaceUp {
                   RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size))
                       .fill(.white)
                   RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size))
                       .stroke(.orange)
               } else {
                   RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size))
                        .fill(.orange)
               }

            content.opacity(1)
                .rotation3DEffect(Angle(degrees: isFaceUp ? 0 : 180), axis: (0, 1, 0))
                
            }
//            .foregroundStyle(.black)
//            .frame(maxWidth: 350, maxHeight: 250)
//            .shadow(radius: 10, y: 10)
        }
        .rotation3DEffect(Angle(degrees: rotation), axis: (0, 1, 0))
    }
    
    private func cornerRadius(for size: CGSize) -> Double {
        min(size.width, size.height) * 0.08
    }
}


extension View {
    func flashcardify(isFaceUp: Bool) -> some View {
        modifier(FlashCardify(isFaceUp: isFaceUp))
    }
}
