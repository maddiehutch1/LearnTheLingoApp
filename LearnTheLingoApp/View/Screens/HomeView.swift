//
//  HomeView.swift
//  LearnTheLingoApp
//
//  Created by IS 543 on 10/26/24.
//

import SwiftUI

struct HomeView: View {
    
    // call the same instance of LanguageViewModel rather than a brand new one (LanguageViewModel())
    var languageViewModel: LanguageViewModel
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 10) {
                    ForEach(languageViewModel.topics, id: \.self) { topic in
                        NavigationLink {
                            LessonView(languageViewModel: languageViewModel, topicTitle: topic.title) // Destination view
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 170, height: 170)
                                    .foregroundColor(.secondary)
                                    .cornerRadius(30)
                                VStack {
                                    Text("\(topic.title)")
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                    
                                    // shows progress through persistent progress technique in viewmodel
                                    Button {
                                        languageViewModel.toggleLessonRead(for: topic.title)
                                    } label: {
                                        ZStack {
                                            Rectangle()
                                                .frame(width: 155, height: 30)
                                                .foregroundColor(
                                                    languageViewModel.progress(for: topic.title).lessonRead ? .green : .secondary
                                                )
                                                .cornerRadius(30)
                                            Text("Lesson Read")
                                                .font(.system(size: 15, weight: .light, design: .rounded))
                                                .foregroundColor(.white)
                                        }
                                    }
                                    
                                    Button {
                                        languageViewModel.toggleVocabStudied(for: topic.title)
                                    } label: {
                                        ZStack {
                                            Rectangle()
                                                .frame(width: 155, height: 30)
                                                .foregroundColor(
                                                    languageViewModel.progress(for: topic.title).vocabularyStudied ? .green : .secondary
                                                )
                                                .cornerRadius(30)
                                            Text("Flashcards Completed")
                                                .font(.system(size: 15, weight: .light, design: .rounded))
                                                .foregroundColor(.white)
                                        }
                                    }
                                    
                                    Button {
                                        languageViewModel.toggleQuizPassed(for: topic.title)
                                    } label: {
                                        ZStack {
                                            Rectangle()
                                                .frame(width: 155, height: 30)
                                                .foregroundColor(
                                                    languageViewModel.progress(for: topic.title).quizPassed ? .green : .secondary
                                                )
                                                .cornerRadius(30)
                                            Text("Quiz Passed")
                                                .font(.system(size: 15, weight: .light, design: .rounded))
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image("TransparentLogoLingo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 80)
                        Spacer()
                    }
                }
            }
            .background(Color.lightTan)
        }
    }
}

#Preview {
    HomeView(languageViewModel: LanguageViewModel())
}
