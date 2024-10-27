//
//  LanguageViewModel.swift
//  LearnTheLingoApp
//
//  Created by IS 543 on 10/26/24.
//

import SwiftUI

@Observable class LanguageViewModel {
    
    // MARK: - Properties
    
    private var lessonPlan: LessonPlan = SpanishLessonPlan()
    
    // MARK: - Model Access
    
    var languageName: String {
        lessonPlan.languageName
    }
    
    var topics: [Language.Topic] {
        lessonPlan.topics
    }
    
    func progress(for title: String) -> Language.Progress {
        if let progressRecord = lessonPlan.progress.first(where: { $0.topicTitle == title }) {
            return progressRecord
        }
        
        let progressRecord = Language.Progress(topicTitle: title)

        lessonPlan.progress.append(progressRecord)
        
        return progressRecord
    }
    
    // helps us know which topic is selected by a user
    func selectedTopic(for title: String) -> Language.Topic {
        lessonPlan.topics.first(where: { $0.title == title }) ?? lessonPlan.topics[0]
    }
    
    func checkAnswer(for question: String, answer: Bool) {
        
    }
    
    // MARK: - User Intents
    
    func toggleLessonRead(for title: String) {
        lessonPlan.toggleLessonRead(for: title)
    }
    
//    func selectAnswer(for question: String) -> Language.QuizItem {
//        lessonPlan.topics.first(
//    }
    
    // MARK: - Private Helpers
    
}
