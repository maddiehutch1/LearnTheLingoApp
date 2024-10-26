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
    // MARK: - User Intents
    
    func toggleLessonRead(for title: String) {
        lessonPlan.toggleLessonRead(for: title)
    }
    
    
    // MARK: - Private Helpers
    
}
