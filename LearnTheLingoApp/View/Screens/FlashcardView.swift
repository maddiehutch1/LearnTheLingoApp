//
//  FlashcardView.swift
//  LearnTheLingoApp
//
//  Created by IS 543 on 10/26/24.
//

import SwiftUI

struct FlashcardView: View {
    
    var languageViewModel = LanguageViewModel()
    
    @State private var isFaceUp = true
    
    let listOfTerms: [Language.Term]
    
    var body: some View {
        TabView {
            // find a way to connect to database
            ForEach(listOfTerms, id: \.self) { card in
                CardView(isFaceUp: isFaceUp, term: card)
                    .onTapGesture {
                        isFaceUp.toggle()
                    }
            }
        }
        .tabViewStyle(.page)
        .background(Color.lightTan)

    }
}

struct CardView: View {
    
    var isFaceUp: Bool
    
    let term: Language.Term
    
    var body: some View {
        ZStack {
           if isFaceUp {
               RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
               RoundedRectangle(cornerRadius: 10)
                   .stroke(.orange)
               Text(term.translation)
                    .font(.largeTitle)
           } else {
               RoundedRectangle(cornerRadius: 10)
                    .fill(.orange)
               Text(term.spanishWord)
                    .font(.largeTitle)
            }
            
        }
        .foregroundStyle(.black)
        .frame(maxWidth: 350, maxHeight: 250)
        .shadow(radius: 10, y: 10)
    }
}

#Preview {
    FlashcardView(languageViewModel: LanguageViewModel(), listOfTerms: [])
}
