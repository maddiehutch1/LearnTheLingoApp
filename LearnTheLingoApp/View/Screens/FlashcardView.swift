//
//  FlashcardView.swift
//  LearnTheLingoApp
//
//  Created by IS 543 on 10/26/24.
//

import SwiftUI

// main structure of flashcard view
struct FlashcardView: View {

    // variables that are used to keep state, yet are not accessible by user
    @State private var isFaceUp = true
    @State private var currentIndex = 0
    
    var languageViewModel: LanguageViewModel
    
    var topic: Language.Topic
    
    let listOfTerms: [Language.Term]
    
    var body: some View {
        TabView (selection: $currentIndex){
            // find a way to connect to database
            ForEach(0..<listOfTerms.count, id: \.self) { index in
                
                // calls cardview under this view
                CardView(isFaceUp: isFaceUp, index: index, term: listOfTerms[index])
                    .onTapGesture {
                        withAnimation {
                            isFaceUp.toggle()
                        }
                    }
                if index == listOfTerms.count - 1 {
                    VStack {
                        Text("Congratulations!")
                            .font(.title)
                            //.font(Color.secondary)
                        Text("You have completed the flashcards for this lesson.")
                            .font(.subheadline)
                        
                        // persistent progress... allows user to keep track of whether or not they completed task
                        Button {
                            languageViewModel.toggleVocabStudied(for: topic.title)
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 170, height: 50)
                                    .foregroundColor(
                                        languageViewModel.progress(for: topic.title).vocabularyStudied ? .green : .secondary
                                    )
                                    .cornerRadius(30)
                                Text("Flashcards Completed")
                                    .font(.system(size: 15, weight: .light, design: .rounded))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
        }
        .tabViewStyle(.page)
        .background(Color.lightTan)

    }
}

// displays each card as a specific view (nested in the flashcard view)
struct CardView: View {
    
    var isFaceUp: Bool
    var index: Int
    
    let term: Language.Term
    
    var body: some View {
        ZStack {
            if isFaceUp {
                Text(term.translation)
                    .font(.largeTitle)
            } else {
                Text(term.spanishWord)
                    .font(.largeTitle)
            }
        }
        
        // connects with flashcardify view that allows rotation and basic design structure
        .flashcardify(isFaceUp: isFaceUp)
        .foregroundStyle(.black)
        .frame(maxWidth: 350, maxHeight: 250)
        .shadow(radius: 10, y: 10)

    }
}

//#Preview {
//    FlashcardView(languageViewModel: LanguageViewModel(), topic: Language.Topic(title: "", lessonText: "", vocabulary: [], quiz: []), listOfTerms: [])
//}
