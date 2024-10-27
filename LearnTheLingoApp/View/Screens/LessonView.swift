//
//  LessonView.swift
//  LearnTheLingoApp
//
//  Created by IS 543 on 10/26/24.
//

import SwiftUI

struct LessonView: View {
    var languageViewModel = LanguageViewModel()
//    @State private var readingCompleted = languageViewModel.progress(for: topic.title).lessonRead
    
    let topicTitle: String
    
    var topic: Language.Topic {
        languageViewModel.selectedTopic(for: topicTitle)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text(topic.lessonText)
                HStack {
//                    Toggle("Lesson Completed", isOn: readingCompleted)
                    NavigationLink {
                        FlashcardView(languageViewModel: LanguageViewModel(), listOfTerms: topic.vocabulary)
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 150, height: 80)
                                .foregroundColor(.secondary)
                                .cornerRadius(30)
                            Text("Flashcards")
                                .foregroundColor(.white)
                        }
                    }
                    NavigationLink {
                        QuizView(languageViewModel: LanguageViewModel(), topicTitle: topic.title, listOfQuestions: topic.quiz)
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 150, height: 80)
                                .foregroundColor(.secondary)
                                .cornerRadius(30)
                            Text("Take Quiz")
                                .foregroundColor(.white)
                        }
                    }
                }
            
            }
        }
        .padding()
        .background(Color.lightTan)
        .navigationTitle(" \(topic.title)")
    }
}

#Preview {
    LessonView(languageViewModel: LanguageViewModel(), topicTitle: "Numbers")
}
