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
    private var score = 0
    var isCorrect: Bool = false
    
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
    
    // MARK: - User Intents
    
    func toggleLessonRead(for title: String) {
        lessonPlan.toggleLessonRead(for: title)
    }
    
    func toggleVocabStudied(for title: String) {
        lessonPlan.toggleVocabStudied(for: title)
    }
    
    func toggleQuizPassed(for title: String) {
        lessonPlan.toggleQuizPassed(for: title)
    }
    
    func isCorrect(selectedAnswer: String, correctAnswer: String) -> Bool {
        if selectedAnswer == correctAnswer {
            return true
        }
        return false
    }
    
    func getScore() -> Int {
        return score
    }
    
    func setScore(newScore: Int) {
        score = newScore
    }
    
    func incrementScore(increment: Int) {
        score += increment
    }
    
    func scoreTracker(increment: Int) {
        if isCorrect {
            incrementScore(increment: increment)
        }
    }
    
    // MARK: - Private Helpers
    
}
