//
//  LessonView.swift
//  LearnTheLingoApp
//
//  Created by IS 543 on 10/26/24.
//

import SwiftUI

struct LessonView: View {
    var languageViewModel: LanguageViewModel

    let topicTitle: String
    
    var topic: Language.Topic {
        languageViewModel.selectedTopic(for: topicTitle)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text(topic.lessonText)
                    .padding()
                
                // another example of persistent progress
                Button {
                    languageViewModel.toggleLessonRead(for: topic.title)
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 170, height: 50)
                            .foregroundColor(
                                languageViewModel.progress(for: topic.title).lessonRead ? .green : .secondary
                            )
                            .cornerRadius(30)
                        Text("Read Lesson")
                            .font(.system(size: 15, weight: .light, design: .rounded))
                            .foregroundColor(.white)
                    }
                }
                
                // hstack that has buttons linking to other views
                HStack {
                    NavigationLink {
                        FlashcardView(languageViewModel: languageViewModel, topic: topic, listOfTerms: topic.vocabulary)
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
                        QuizView(languageViewModel: languageViewModel, topicTitle: topic.title, listOfQuestions: topic.quiz)
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
