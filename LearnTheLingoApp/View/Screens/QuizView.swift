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
                        QuizQuestionView(pregunta: listOfQuestions[index], index: index, totalQuestions: listOfQuestions.count, languageViewModel: languageViewModel, topicTitle: topicTitle)
                    }
                }
                .tabViewStyle(.page)
            }
            .background(Color.lightTan)
        }
    }
}

// view for each individual quiz question
struct QuizQuestionView: View {
    
    let pregunta: Language.QuizItem
    var index: Int
    var totalQuestions: Int
    var languageViewModel: LanguageViewModel
    
    let topicTitle: String

    var topic: Language.Topic {
        languageViewModel.selectedTopic(for: topicTitle)
    }
    
    // state variables
    @State private var showResultView = false
    @State private var selectedAnswer: String? = nil
    @State private var hasAnswered = false
    
    var body: some View {
        VStack {
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
                            // based on user's answers, can see visually if answer was right or not
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
                    
                    // unwraps selectedAnswer to see if user's choice was correct... this then determines what sound is played
                    if let selectedAnswerWithChoice = selectedAnswer {
                        languageViewModel.isCorrect = languageViewModel.isCorrect(selectedAnswer: selectedAnswerWithChoice, correctAnswer: pregunta.answer)
                        languageViewModel.chooseAnswer()
                    }
                    
                    languageViewModel.scoreTracker(increment: 10)

                }
            }
            .padding()
            .disabled(hasAnswered)
            
            // only display the Swipe next text based on questions and completion of them
            if hasAnswered && (index < totalQuestions - 1) {
                Text("SWIPE NEXT →")
                    .foregroundColor(.white)
                    .bold()
                    .font(.system(size: 25))
                
                // display results page when the last question has been reached and answered
            } else if hasAnswered {
                NavigationLink(destination: ResultsView(languageViewModel: languageViewModel, topic: topic, score: languageViewModel.getScore())) {
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
