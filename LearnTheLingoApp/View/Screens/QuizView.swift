//
//  QuizView.swift
//  LearnTheLingoApp
//
//  Created by IS 543 on 10/26/24.
//

import SwiftUI

struct QuizView: View {
    
    @State private var currentIndex = 0
    var languageViewModel: LanguageViewModel
    
    let topicTitle: String
    
    var topic: Language.Topic {
        languageViewModel.selectedTopic(for: topicTitle)
    }
    
    let listOfQuestions: [Language.QuizItem]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack {
                        Text("Question")
                            .font(.subheadline)
                        Text("\(currentIndex + 1) / \(listOfQuestions.count)")
                            .font(.title)
                    }
                    .padding(.trailing)
                    VStack{
                        Text("Current Score")
                            .font(.subheadline)
                        Text("\(languageViewModel.getScore())")
                            .font(.title)
                    }
                    .padding(.leading)

                }
                
                
                TabView(selection: $currentIndex) {
                    // find a way to connect to database
                    ForEach(0..<listOfQuestions.count, id: \.self) { index in
                        QuizQuestionView(pregunta: listOfQuestions[index], index: index, totalQuestions: listOfQuestions.count, languageViewModel: languageViewModel)
                    }
                }
                .tabViewStyle(.page)
            }
            .background(Color.lightTan)
        }
    }
}


struct QuizQuestionView: View {
    
    let pregunta: Language.QuizItem
    var index: Int
    var totalQuestions: Int
    var languageViewModel: LanguageViewModel
    
    let timer = Timer()
    
    @State private var showResultView = false
    @State private var selectedAnswer: String? = nil
    @State private var hasAnswered = false
    
    var body: some View {
        VStack {
            //timer.scheduledTimer(timerInterval: 20.0)
            Text("\(pregunta.question)")
                .font(.title)
                .multilineTextAlignment(.center) // Centers text within the Text view
                .frame(maxWidth: .infinity, alignment: .center)
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
                    hasAnswered = true
                    

                    if let selectedAnswerWithChoice = selectedAnswer {
                        languageViewModel.isCorrect = languageViewModel.isCorrect(selectedAnswer: selectedAnswerWithChoice, correctAnswer: pregunta.answer)
                        languageViewModel.chooseAnswer()
                    }
                    
                    languageViewModel.scoreTracker(increment: 10)

                }
            }
            .padding()
            Spacer()
            .disabled(hasAnswered)
            if hasAnswered && (index < totalQuestions - 1) {
                Text("SWIPE NEXT →")
                    .foregroundColor(.white)
                    .bold()
                    .font(.system(size: 25))
            } else if hasAnswered {
                NavigationLink(destination: ResultsView(score: languageViewModel.getScore())) {
                    ZStack {
                        Rectangle()
                            .frame(width: 150, height: 50)
                            .foregroundColor(.primary)
                            .cornerRadius(30)
                        Text("View Results")
                            .foregroundColor(.white)
                    }
                }
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
