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
    struct Topic: Identifiable, Hashable {
        let id = UUID()
        let title: String
        let lessonText: String
        let vocabulary: [Term]
        let quiz: [QuizItem]
    }
    
    struct Term: Hashable, Equatable {
        let spanishWord: String
        let translation: String
    }
    
    struct QuizItem: Hashable, Equatable {
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
            ),
                
                // Clothing
                Language.Topic(
                    title: "Clothing",
                    lessonText: "testing",
                    vocabulary: [
                        Language.Term(
                            spanishWord: "la ropa",
                            translation: "clothes"
                        )],
                    quiz: [
                        Language.QuizItem(
                            question: "What is the Spanish word for 'shirt'?",
                            options: ["Camisa", "Zapato", "Chaqueta"],
                            answer: "Camisa"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'pants' in Spanish?",
                            options: ["Sombrero", "Pantalones", "Falda"],
                            answer: "Pantalones"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'shoes'?",
                            options: ["Calcetines", "Zapatos", "Guantes"],
                            answer: "Zapatos"
                        ),
                        Language.QuizItem(
                            question: "Which of these means 'dress' in Spanish?",
                            options: ["Vestido", "Falda", "Abrigo"],
                            answer: "Vestido"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'hat' in Spanish?",
                            options: ["Sombrero", "Camisa", "Cinturón"],
                            answer: "Sombrero"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'jacket'?",
                            options: ["Bufanda", "Chaqueta", "Gorra"],
                            answer: "Chaqueta"
                        ),
                        Language.QuizItem(
                            question: "Which of these means 'skirt' in Spanish?",
                            options: ["Falda", "Pantalones", "Zapatos"],
                            answer: "Falda"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'socks' in Spanish?",
                            options: ["Cinturón", "Guantes", "Calcetines"],
                            answer: "Calcetines"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'gloves'?",
                            options: ["Guantes", "Abrigo", "Zapatos"],
                            answer: "Guantes"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'scarf' in Spanish?",
                            options: ["Bufanda", "Cinturón", "Camisa"],
                            answer: "Bufanda"
                        )]
                ),
                
                // Weather
                Language.Topic(
                    title: "Weather",
                    lessonText: "testing",
                    vocabulary: [
                        Language.Term(
                            spanishWord: "la lluvia",
                            translation: "rain"
                        )],
                    quiz: [
                        Language.QuizItem(
                            question: "How do you say 'It's raining' in Spanish?",
                            options: ["Está lloviendo", "Hace frío", "Hace sol"],
                            answer: "Está lloviendo"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish phrase for 'It's sunny'?",
                            options: ["Está nublado", "Hace viento", "Hace sol"],
                            answer: "Hace sol"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'snow'?",
                            options: ["Niebla", "Nieve", "Granizo"],
                            answer: "Nieve"
                        ),
                        Language.QuizItem(
                            question: "Which of these means 'It's windy' in Spanish?",
                            options: ["Está nevando", "Hace viento", "Hace calor"],
                            answer: "Hace viento"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'It's cold' in Spanish?",
                            options: ["Hace calor", "Hace frío", "Está húmedo"],
                            answer: "Hace frío"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish phrase for 'It's snowing'?",
                            options: ["Está nevando", "Está nublado", "Hace buen tiempo"],
                            answer: "Está nevando"
                        ),
                        Language.QuizItem(
                            question: "Which of these means 'It's cloudy' in Spanish?",
                            options: ["Está despejado", "Hace sol", "Está nublado"],
                            answer: "Está nublado"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'It's hot' in Spanish?",
                            options: ["Hace frío", "Hace calor", "Está ventoso"],
                            answer: "Hace calor"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'storm'?",
                            options: ["Tormenta", "Lluvia", "Granizo"],
                            answer: "Tormenta"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'fog'?",
                            options: ["Viento", "Niebla", "Humedad"],
                            answer: "Niebla"
                        )
                    ]
                ),
                
                // Halloween special
                Language.Topic(
                    title: "Halloween",
                    lessonText: "testing",
                    vocabulary: [Language.Term(spanishWord: "la calabaza", translation: "pumpkin")],
                    quiz: [
                        Language.QuizItem(
                            question: "What is the Spanish word for 'pumpkin'?",
                            options: ["Bruja", "Calabaza", "Fantasma"],
                            answer: "Calabaza"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'ghost' in Spanish?",
                            options: ["Calavera", "Vampiro", "Fantasma"],
                            answer: "Fantasma"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'witch'?",
                            options: ["Bruja", "Monstruo", "Esqueleto"],
                            answer: "Bruja"
                        ),
                        Language.QuizItem(
                            question: "Which of these means 'skeleton' in Spanish?",
                            options: ["Esqueleto", "Calavera", "Araña"],
                            answer: "Esqueleto"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'spider' in Spanish?",
                            options: ["Murciélago", "Araña", "Vampiro"],
                            answer: "Araña"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'vampire'?",
                            options: ["Murciélago", "Vampiro", "Fantasma"],
                            answer: "Vampiro"
                        ),
                        Language.QuizItem(
                            question: "Which of these means 'bat' in Spanish?",
                            options: ["Araña", "Monstruo", "Murciélago"],
                            answer: "Murciélago"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'monster' in Spanish?",
                            options: ["Monstruo", "Bruja", "Esqueleto"],
                            answer: "Monstruo"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'skull'?",
                            options: ["Esqueleto", "Calavera", "Calabaza"],
                            answer: "Calavera"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'costume' in Spanish?",
                            options: ["Disfraz", "Bruja", "Calabaza"],
                            answer: "Disfraz"
                        )
                    ]
                ),
                
                // Family
                Language.Topic(
                    title: "Family",
                    lessonText: "testing",
                    vocabulary: [Language.Term(spanishWord: "la familia", translation: "family")],
                    quiz: [
                        Language.QuizItem(
                            question: "How do you say 'mother' in Spanish?",
                            options: ["Hermana", "Madre", "Abuela"],
                            answer: "Madre"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'father'?",
                            options: ["Padre", "Tío", "Abuelo"],
                            answer: "Padre"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'brother' in Spanish?",
                            options: ["Hermano", "Primo", "Hijo"],
                            answer: "Hermano"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'sister'?",
                            options: ["Tía", "Hermana", "Prima"],
                            answer: "Hermana"
                        ),
                        Language.QuizItem(
                            question: "Which of these means 'grandfather' in Spanish?",
                            options: ["Primo", "Abuelo", "Sobrino"],
                            answer: "Abuelo"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'grandmother' in Spanish?",
                            options: ["Abuela", "Madre", "Prima"],
                            answer: "Abuela"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'uncle'?",
                            options: ["Tío", "Sobrino", "Hermano"],
                            answer: "Tío"
                        ),
                        Language.QuizItem(
                            question: "Which of these means 'aunt' in Spanish?",
                            options: ["Tía", "Madre", "Prima"],
                            answer: "Tía"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'son' in Spanish?",
                            options: ["Hijo", "Nieto", "Hermano"],
                            answer: "Hijo"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'daughter'?",
                            options: ["Hermana", "Sobrina", "Hija"],
                            answer: "Hija"
                        )
                    ]
                ),
                
                // School
                Language.Topic(
                    title: "School",
                    lessonText: "testing",
                    vocabulary: [Language.Term(spanishWord: "la escuela", translation: "school")],
                    quiz: [
                        Language.QuizItem(
                            question: "How do you say 'school' in Spanish?",
                            options: ["Escuela", "Clase", "Biblioteca"],
                            answer: "Escuela"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'teacher'?",
                            options: ["Estudiante", "Profesor", "Escuela"],
                            answer: "Profesor"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'student' in Spanish?",
                            options: ["Estudiante", "Clase", "Maestro"],
                            answer: "Estudiante"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'class'?",
                            options: ["Clase", "Silla", "Mesa"],
                            answer: "Clase"
                        ),
                        Language.QuizItem(
                            question: "Which of these means 'book' in Spanish?",
                            options: ["Cuaderno", "Libro", "Lápiz"],
                            answer: "Libro"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'notebook' in Spanish?",
                            options: ["Cuaderno", "Carpeta", "Hoja"],
                            answer: "Cuaderno"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'pencil'?",
                            options: ["Lápiz", "Tiza", "Pluma"],
                            answer: "Lápiz"
                        ),
                        Language.QuizItem(
                            question: "Which of these means 'folder' in Spanish?",
                            options: ["Carpeta", "Libreta", "Tijeras"],
                            answer: "Carpeta"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'chalk' in Spanish?",
                            options: ["Tiza", "Lápiz", "Marcador"],
                            answer: "Tiza"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'scissors'?",
                            options: ["Tijeras", "Cinta", "Pegamento"],
                            answer: "Tijeras"
                        )
                    ]
                ),
                
                // Body
                Language.Topic(
                    title: "Body",
                    lessonText: "testing",
                    vocabulary: [Language.Term(spanishWord: "el cuerpo", translation: "body")],
                    quiz: [
                        Language.QuizItem(
                            question: "How do you say 'head' in Spanish?",
                            options: ["Cabeza", "Mano", "Brazo"],
                            answer: "Cabeza"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'hand'?",
                            options: ["Pierna", "Mano", "Pie"],
                            answer: "Mano"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'leg' in Spanish?",
                            options: ["Pierna", "Brazo", "Cabeza"],
                            answer: "Pierna"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'foot'?",
                            options: ["Dedo", "Pie", "Pierna"],
                            answer: "Pie"
                        ),
                        Language.QuizItem(
                            question: "Which of these means 'arm' in Spanish?",
                            options: ["Pierna", "Brazo", "Mano"],
                            answer: "Brazo"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'eye' in Spanish?",
                            options: ["Nariz", "Boca", "Ojo"],
                            answer: "Ojo"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'nose'?",
                            options: ["Oreja", "Nariz", "Ojo"],
                            answer: "Nariz"
                        ),
                        Language.QuizItem(
                            question: "Which of these means 'ear' in Spanish?",
                            options: ["Ojo", "Nariz", "Oreja"],
                            answer: "Oreja"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'mouth' in Spanish?",
                            options: ["Boca", "Dedo", "Mano"],
                            answer: "Boca"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'finger'?",
                            options: ["Dedo", "Pie", "Ojo"],
                            answer: "Dedo"
                        )
                    ]
                ),
                
                // Animals
                Language.Topic(
                    title: "Animals",
                    lessonText: "testing",
                    vocabulary: [Language.Term(spanishWord: "el animal", translation: "animal")],
                    quiz: [
                        Language.QuizItem(
                            question: "How do you say 'dog' in Spanish?",
                            options: ["Gato", "Perro", "Pájaro"],
                            answer: "Perro"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'cat'?",
                            options: ["Gato", "Rata", "Conejo"],
                            answer: "Gato"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'bird' in Spanish?",
                            options: ["Perro", "Gato", "Pájaro"],
                            answer: "Pájaro"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'rabbit'?",
                            options: ["Perro", "Gato", "Conejo"],
                            answer: "Conejo"
                        ),
                        Language.QuizItem(
                            question: "Which of these means 'fish' in Spanish?",
                            options: ["Pez", "Tortuga", "Rana"],
                            answer: "Pez"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'turtle' in Spanish?",
                            options: ["Rana", "Tortuga", "Serpiente"],
                            answer: "Tortuga"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'snake'?",
                            options: ["Serpiente", "Lobo", "Ratón"],
                            answer: "Serpiente"
                        ),
                        Language.QuizItem(
                            question: "Which of these means 'wolf' in Spanish?",
                            options: ["Oso", "Lobo", "Gato"],
                            answer: "Lobo"
                        ),
                        Language.QuizItem(
                            question: "How do you say 'mouse' in Spanish?",
                            options: ["Ratón", "Gato", "Perro"],
                            answer: "Ratón"
                        ),
                        Language.QuizItem(
                            question: "What is the Spanish word for 'bear'?",
                            options: ["Oso", "León", "Elefante"],
                            answer: "Oso"
                        )
                    ]
                )
            ]
        }
    }

