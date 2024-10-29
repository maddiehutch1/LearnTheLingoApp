//
//  QuizView.swift
//  LearnTheLingoApp
//
//  Created by IS 543 on 10/26/24.
//

import SwiftUI

struct QuizView: View {
    
    var languageViewModel: LanguageViewModel
    
    let topicTitle: String

    var topic: Language.Topic {
        languageViewModel.selectedTopic(for: topicTitle)
    }
    
    let listOfQuestions: [Language.QuizItem]

    var body: some View {
        Text("\(languageViewModel.getScore())")
        TabView {
            // find a way to connect to database
            ForEach(listOfQuestions, id: \.self) { question in
                QuizQuestionView(pregunta: question, languageViewModel: languageViewModel)
            }
        }
        .tabViewStyle(.page)
        .background(Color.lightTan)


    }
}

struct QuizQuestionView: View {
    
    let pregunta: Language.QuizItem
    
    var languageViewModel: LanguageViewModel
    
    @State private var selectedAnswer: String? = nil
    @State private var hasAnswered = false
    
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
                }
                .onTapGesture {
                    selectedAnswer = answer
                    hasAnswered.toggle()
                    
                    if let selectedAnswerWithChoice = selectedAnswer {
                        languageViewModel.isCorrect = languageViewModel.isCorrect(selectedAnswer: selectedAnswerWithChoice, correctAnswer: pregunta.answer)
                    }
                    
                    languageViewModel.scoreTracker(increment: 10)
                }
            }
        }
    }
}

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

#Preview {
    QuizView(languageViewModel: LanguageViewModel(), topicTitle: "Numbers", listOfQuestions: [Language.QuizItem(
        question: "What is the Spanish word for the number 7?",
        options: ["Siete", "Seis", "Ocho"],
        answer: "Siete"
    )])
}
