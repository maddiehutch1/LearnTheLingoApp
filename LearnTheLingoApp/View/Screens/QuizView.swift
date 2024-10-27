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
    @State private var hasAnswered = false
    @State private var score = 0
    
    var body: some View {
        VStack {
            Text("\(pregunta.question)")
                .font(.title)
                .padding()
            ForEach(pregunta.options, id: \.self) { answer in
                ZStack {
                    Rectangle()
                        .frame(width: 150, height: 50)
                        .foregroundColor(
                            hasAnswered ?
                            (answer == pregunta.answer ? .green :
                            (answer == selectedAnswer ? .red : .secondary))
                            : .secondary
                        )
                        .cornerRadius(30)
                    Text("\(answer)")
                        .foregroundColor(.white)
//                    if > 0 {
//                        Rectangle()
//                            .frame(width: 150, height: 50)
//                            .foregroundColor(.secondary)
//                            .cornerRadius(30)
//                    }
                }
                .onTapGesture {
                    selectedAnswer = answer
                    hasAnswered.toggle()
                }
            }
        }
//        // Check if this is the last question
//        if isLastQuestion() {
//            Button(action: {
//                // Action for completing the quiz
//                print("Quiz Completed")
//            }) {
//                Rectangle()
//                    .frame(width: 150, height: 50)
//                    .foregroundColor(.secondary)
//                    .cornerRadius(30)
//                Text("Complete Quiz")
//                    .foregroundColor(.white)
//            }
//        }
    }
}

//private func isLastQuestion() -> Bool {
//        // Assuming you have access to the number of questions
//        return pregunta.id == listOfQuestions.last?.id // Modify this as per your implementation
//    }

struct ResultsView: View {
    let correctAnswers: Int
    let numberOfQuestions: Int
    
    var body: some View {
        VStack {
            Text("Your Results")
                .font(.headline)
                .padding()
            Text("\(correctAnswers) / \(numberOfQuestions)")
                .font(.title)
            Button("Restart Quiz") {
                
            }
        }
    }
}

//#Preview {
//    QuizView(languageViewModel: LanguageViewModel(), topicTitle: "Numbers")
//}
