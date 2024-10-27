//
//  QuizView.swift
//  LearnTheLingoApp
//
//  Created by IS 543 on 10/26/24.
//

import SwiftUI

struct QuizView: View {
    
    var languageViewModel = LanguageViewModel()
    
    let topicTitle: String

    var topic: Language.Topic {
        languageViewModel.selectedTopic(for: topicTitle)
    }
    
    let listOfQuestions: [Language.QuizItem]

    var body: some View {
        TabView {
            // find a way to connect to database
            ForEach(listOfQuestions, id: \.self) { question in
                QuizQuestionView(pregunta: question)
            }
        }
        .tabViewStyle(.page)
        .background(Color.lightTan)


    }
}

struct QuizQuestionView: View {
    
    let pregunta: Language.QuizItem
    
    @State private var selectedAnswer: String? = nil
    
    var body: some View {
        VStack {
            Text("\(pregunta.question)")
                .font(.title)
                .padding()
            ForEach(pregunta.options, id: \.self) { answer in
                ZStack {
                    Rectangle()
                        .frame(width: 150, height: 50)
                        .foregroundColor(answer == selectedAnswer && answer == pregunta.answer ? .green : .secondary)
                        .cornerRadius(30)
                    Text("\(answer)")
                        .foregroundColor(.white)
                }
                .onTapGesture {
                    selectedAnswer = answer
                }
            }
        }
    }
}

struct ResultsView: View {
    let correctAnswers: Int
    let numberOfQuestions: Int
    
    var body: some View {
        Text("")
    }
}

//#Preview {
//    QuizView(languageViewModel: LanguageViewModel(), topicTitle: "Numbers")
//}
