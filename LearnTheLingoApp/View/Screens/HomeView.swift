//
//  HomeView.swift
//  LearnTheLingoApp
//
//  Created by IS 543 on 10/26/24.
//

import SwiftUI

struct HomeView: View {
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
                                    Text(topic.title)
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                    Button {
                                        languageViewModel.toggleLessonRead(for: topic.title)
                                    } label: {
                                        Text("Lesson read: \(languageViewModel.progress(for: topic.title).lessonRead)")
                                            .font(.system(size: 15, weight: .light, design: .rounded))
                                            .foregroundColor(.mint)
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
