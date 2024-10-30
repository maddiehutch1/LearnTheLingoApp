//
//  ResultsView.swift
//  LearnTheLingoApp
//
//  Created by IS 543 on 10/28/24.
//

import SwiftUI

struct ResultsView: View {

    var languageViewModel: LanguageViewModel
    let topic: Language.Topic
    
    let score: Int
    
    var body: some View {
        VStack {
            Text("Congratulations!")
                .font(.title)
                //.font(Color.secondary)
            Text("You have completed the quiz for this lesson.")
                .font(.subheadline)
                .padding()
            Text("Your Results")
                .font(.headline)
                .padding()
            Text("\(score)")
                .font(.title)
            
            Button {
                languageViewModel.toggleQuizPassed(for: topic.title)
            } label: {
                ZStack {
                    Rectangle()
                        .frame(width: 170, height: 50)
                        .foregroundColor(
                            languageViewModel.progress(for: topic.title).quizPassed ? .green : .secondary
                        )
                        .cornerRadius(30)
                    Text("Quiz Completed")
                        .font(.system(size: 15, weight: .light, design: .rounded))
                        .foregroundColor(.white)
                }
            }
        }
        .background(Color.lightTan)
    }
}

//#Preview {
//    ResultsView(score: 20)
//}
