//
//  LanguageModel.swift
//  LearnTheLingoApp
//
//  Created by IS 543 on 10/26/24.
//

import Foundation

protocol LessonPlan {
    var languageName: String { get }
    var topics: [Language.Topic] { get }
    var progress: [Language.Progress] { get set }
    
    mutating func toggleLessonRead(for title: String);
}

struct Language {
    struct Topic: Identifiable {
        let id = UUID()
        let title: String
        let lessonText: String
        let vocabulary: [Term]
        let quiz: [QuizItem]
    }
    
    struct Term {
        let spanishWord: String
        let translation: String
    }
    
    struct QuizItem {
        let question: String
        let options: [String]
        let answer: String
    }
    
    struct Progress {
        let topicTitle: String
        var lessonRead = false
        var vocabularyStudied = false
        var quizPassed = false
        var quizHighScore: Int?
    }
}

extension Language.Progress: Identifiable {
    var id: String { topicTitle }
}

private func key(for title: String, type: String) -> String {
    "\(title).\(type)"
}

struct SpanishLessonPlan: LessonPlan {
    
    // MARK: - Read-only Properties
    let languageName = "Spanish"
    let topics = Data.SpanishTopics
    
    // MARK: - Mutable Properties
    
    var progress: [Language.Progress] = SpanishLessonPlan.readProgressRecords()
    
    // MARK: - Helpers
    
    mutating func toggleLessonRead(for title: String) {
        if let index = progress.firstIndex(where: { $0.topicTitle == title }) {
            progress[index].lessonRead.toggle()
            UserDefaults.standard
                .set(
                    progress[index].lessonRead,
                    forKey: key(for: title, type: Key.lessonRead)
                )
        } else {
            progress.append(Language.Progress(topicTitle: title))
            toggleLessonRead(for: title)
        }
    }
    
    // NEEDSWORK: implement helpers to update progress as neded
    
    private static func readProgressRecords() -> [Language.Progress] {
        var progressRecords = [Language.Progress]()
        
        Data.SpanishTopics.forEach {
            topic in
            var progressRecord = Language.Progress(topicTitle: topic.title)
            
            progressRecord.lessonRead = UserDefaults.standard
                .bool(
                    forKey: key(for: topic.title, type: Key.lessonRead)
                )
            
            //NEEDSWORK: implement this for the other three progress items
            progressRecords.append(progressRecord)
        }
        
        return progressRecords
    }
    
    // MARK: - Constants
    
    private struct Key {
        static let lessonRead = "lesson"
        static let vocabularyStudied = "vocab"
        static let quizPassed = "quiz"
        static let highScore = "score"
    }
    
    private struct Data {
        static let SpanishTopics = [
            // Numbers
            Language.Topic(
                title: "Numbers",
                lessonText: """
                    In this lesson, you'll learn how to count in Spanish. Here are the numbers 1 to 10:

                    1. Uno
                    2. Dos
                    3. Tres
                    4. Cuatro
                    5. Cinco
                    6. Seis
                    7. Siete
                    8. Ocho
                    9. Nueve
                    10. Diez

                    For numbers beyond 10, here are a few examples:
                    11. Once
                    12. Doce
                    13. Trece
                    14. Catorce
                    15. Quince
                    20. Veinte
                    30. Treinta
                    100. Cien

                    To form larger numbers, combine them:
                    - 21: Veintiuno
                    - 22: Veintidós
                    - 31: Treinta y uno
                    - 32: Treinta y dos
                    - 100: Ciento (when not exactly 100)

                    Practice by saying the numbers out loud to get used to the pronunciation!
                """,

                vocabulary: [
                    Language.Term(
                        spanishWord: "uno",
                        translation: "one (1)"
                    ),
                    Language.Term(
                        spanishWord: "dos",
                        translation: "two (2)"
                    ),
                    Language.Term(
                        spanishWord: "tres",
                        translation: "three (3)"
                    ),
                    Language.Term(
                        spanishWord: "cuatro",
                        translation: "four (4)"
                    ),
                    Language.Term(
                        spanishWord: "cinco",
                        translation: "five (5)"
                    ),
                    Language.Term(
                        spanishWord: "seis",
                        translation: "six (6)"
                    ),
                    Language.Term(
                        spanishWord: "siete",
                        translation: "seven (7)"
                    ),
                    Language.Term(
                        spanishWord: "ocho",
                        translation: "eight (8)"
                    ),
                    Language.Term(
                        spanishWord: "nueve",
                        translation: "nine (9)"
                    ),
                    Language.Term(
                        spanishWord: "diez",
                        translation: "ten (10)"
                    ),
                    Language.Term(
                        spanishWord: "veinte",
                        translation: "twenty (20)"
                    ),
                    Language.Term(
                        spanishWord: "treinta",
                        translation: "thirty (30)"
                    ),
                    Language.Term(
                        spanishWord: "cuarenta",
                        translation: "forty (40)"
                    ),
                    Language.Term(
                        spanishWord: "cincuenta",
                        translation: "fifty (50)"
                    ),
                    Language.Term(
                        spanishWord: "sesenta",
                        translation: "sixty (60)"
                    ),
                    Language.Term(
                        spanishWord: "setenta",
                        translation: "seventy (70)"
                    ),
                    Language.Term(
                        spanishWord: "ochenta",
                        translation: "eighty (80)"
                    ),
                    Language.Term(
                        spanishWord: "noventa",
                        translation: "ninety (90)"
                    ),
                    Language.Term(
                        spanishWord: "cien",
                        translation: "one hundred (100)"
                    ),
                ],
                quiz: [
                    Language.QuizItem(
                        question: "What is the Spanish word for the number 7?",
                        options: ["Siete", "Seis", "Ocho"],
                        answer: "Siete"
                    ),
                    Language.QuizItem(
                        question: "How do you say '15' in Spanish?",
                        options: ["Quince", "Diez", "Doce"],
                        answer: "Quince"
                    ),
                    Language.QuizItem(
                        question: "What number does 'veinte' represent?",
                        options: ["10", "20", "30"],
                        answer: "20"
                    ),
                    Language.QuizItem(
                        question: "If 'nueve' is 9, what is 19 in Spanish?",
                        options: ["Noventa", "Diecinueve", "Diez"],
                        answer: "Diecinueve"
                    ),
                    Language.QuizItem(
                        question: "What is the Spanish number for '100'?",
                        options: ["Cincuenta", "Cien", "Mil"],
                        answer: "Cien"
                    ),
                    Language.QuizItem(
                        question: "Which of these is the correct translation of '42'?",
                        options: ["Cuarenta y dos", "Veinte y dos", "Treinta y dos"],
                        answer: "Cuarenta y dos"
                    ),
                    Language.QuizItem(
                        question: "How do you say '31' in Spanish?",
                        options: ["Treinta y uno", "Cuarenta y uno", "Veinte y uno"],
                        answer: "Treinta y uno"
                    ),
                    Language.QuizItem(
                        question: "What is the Spanish number for '50'?",
                        options: ["Cincuenta", "Setenta", "Ochenta"],
                        answer: "Cincuenta"
                    ),
                    Language.QuizItem(
                        question: "What is the number '70' in Spanish?",
                        options: ["Setenta", "Sesenta", "Noventa"],
                        answer: "Setenta"
                    ),
                    Language.QuizItem(
                        question: "How do you write the number 1000 in Spanish?",
                        options: ["Mil", "Quinientos", "Ciento"],
                        answer: "Mil"
                    )
                ]
            ),
            
            // Food
            Language.Topic(
                title: "Food",
                lessonText: "testing",
                vocabulary: [
                    Language.Term(
                        spanishWord: "la comida",
                        translation: "food"
                    )],
                quiz: [
                    Language.QuizItem(
                        question: "What is the Spanish word for 'apple'?",
                        options: ["Manzana", "Naranja", "Plátano"],
                        answer: "Manzana"
                    ),
                    Language.QuizItem(
                        question: "How do you say 'bread' in Spanish?",
                        options: ["Pan", "Leche", "Queso"],
                        answer: "Pan"
                    ),
                    Language.QuizItem(
                        question: "What is the Spanish word for 'cheese'?",
                        options: ["Carne", "Queso", "Huevos"],
                        answer: "Queso"
                    ),
                    Language.QuizItem(
                        question: "Which of these is the Spanish word for 'orange'?",
                        options: ["Plátano", "Naranja", "Manzana"],
                        answer: "Naranja"
                    ),
                    Language.QuizItem(
                        question: "What is the Spanish word for 'chicken'?",
                        options: ["Pollo", "Pescado", "Carne"],
                        answer: "Pollo"
                    ),
                    Language.QuizItem(
                        question: "How do you say 'rice' in Spanish?",
                        options: ["Frijoles", "Arroz", "Tortilla"],
                        answer: "Arroz"
                    ),
                    Language.QuizItem(
                        question: "What is the Spanish word for 'fish' (as food)?",
                        options: ["Pescado", "Pollo", "Queso"],
                        answer: "Pescado"
                    ),
                    Language.QuizItem(
                        question: "Which of these means 'potato' in Spanish?",
                        options: ["Papa", "Carne", "Tortilla"],
                        answer: "Papa"
                    ),
                    Language.QuizItem(
                        question: "How do you say 'egg' in Spanish?",
                        options: ["Huevos", "Arroz", "Fruta"],
                        answer: "Huevos"
                    ),
                    Language.QuizItem(
                        question: "What is the Spanish word for 'milk'?",
                        options: ["Leche", "Café", "Jugo"],
                        answer: "Leche"
                    )]
            ),
            
            // Must-Know Phrases
            Language.Topic(
                title: "Must-Know Phrases",
                lessonText: "testing",
                vocabulary: [
                    Language.Term(
                        spanishWord: "Como estas?",
                        translation: "How are you? (informal)"
                    )],
                quiz: [
                    Language.QuizItem(
                        question: "How do you say 'Hello' in Spanish?",
                        options: ["Hola", "Adiós", "Gracias"],
                        answer: "Hola"
                    ),
                    Language.QuizItem(
                        question: "What is the Spanish phrase for 'Thank you'?",
                        options: ["De nada", "Por favor", "Gracias"],
                        answer: "Gracias"
                    ),
                    Language.QuizItem(
                        question: "Which of these means 'Goodbye' in Spanish?",
                        options: ["Hola", "Adiós", "Buenos días"],
                        answer: "Adiós"
                    ),
                    Language.QuizItem(
                        question: "How do you say 'Please' in Spanish?",
                        options: ["Gracias", "Perdón", "Por favor"],
                        answer: "Por favor"
                    ),
                    Language.QuizItem(
                        question: "What is the Spanish phrase for 'Excuse me'?",
                        options: ["De nada", "Perdón", "Buenas noches"],
                        answer: "Perdón"
                    ),
                    Language.QuizItem(
                        question: "Which phrase means 'How are you?' in Spanish?",
                        options: ["¿Dónde estás?", "¿Cómo te llamas?", "¿Cómo estás?"],
                        answer: "¿Cómo estás?"
                    ),
                    Language.QuizItem(
                        question: "How do you say 'Good morning' in Spanish?",
                        options: ["Buenas noches", "Buenos días", "Buenas tardes"],
                        answer: "Buenos días"
                    ),
                    Language.QuizItem(
                        question: "What is the Spanish phrase for 'I don't understand'?",
                        options: ["No hablo español", "No entiendo", "Estoy bien"],
                        answer: "No entiendo"
                    ),
                    Language.QuizItem(
                        question: "How do you say 'Can you help me?' in Spanish?",
                        options: ["¿Me puedes ayudar?", "¿Dónde está?", "¿Puedo pasar?"],
                        answer: "¿Me puedes ayudar?"
                    ),
                    Language.QuizItem(
                        question: "What is the Spanish phrase for 'I would like to order'?",
                        options: ["Quiero pedir", "Necesito ayuda", "Puedo pagar"],
                        answer: "Quiero pedir"
                    )]
            )
        ]
    }
    
    
}
