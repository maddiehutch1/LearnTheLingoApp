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
                            Learning numbers in Spanish is fundamental for various everyday situations, from telling time and making purchases to discussing dates and quantities. The basic numbers are essential building blocks for more complex calculations and expressions. The Spanish words for numbers are similar to those in other languages, but some may require practice to pronounce correctly. For example, "uno" means one, "dos" means two, "tres" means three, and so on. Understanding how to count from one to ten is a great starting point and provides a foundation for learning larger numbers.

                            As you progress, you'll find that Spanish numbers follow a consistent pattern. For example, numbers from eleven to fifteen are formed by combining the base number with the suffix "-ce," such as "once" (eleven) and "quince" (fifteen). Additionally, multiples of ten are straightforward: "veinte" means twenty, "treinta" means thirty, and so forth. Learning to use these numbers in context, such as in shopping scenarios or when talking about age, can significantly improve your conversational skills in Spanish.
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
                lessonText: """
                            This mini lesson introduces basic Spanish food vocabulary, organized by categories such as fruits (e.g., "manzana" for apple), vegetables (e.g., "zanahoria" for carrot), dairy (e.g., "queso" for cheese), meats (e.g., "pollo" for chicken), and drinks (e.g., "agua" for water). Practice sentences help reinforce these terms in context, like saying, "_Me gustan las manzanas_," meaning "I like apples." To improve learning, try using flashcards, speaking each word aloud, and connecting the Spanish terms with real food items you encounter. Incorporating Spanish into daily activities—like listening to music or cooking with these words—makes learning fun and effective!
                            """,
                vocabulary: [
                    Language.Term(
                        spanishWord: "la comida",
                        translation: "food"
                    ),
                    Language.Term(
                        spanishWord: "la manzana",
                        translation: "apple"
                    ),
                    Language.Term(
                        spanishWord: "el plátano",
                        translation: "banana"
                    ),
                    Language.Term(
                        spanishWord: "la naranja",
                        translation: "orange"
                    ),
                    Language.Term(
                        spanishWord: "la fresa",
                        translation: "strawberry"
                    ),
                    Language.Term(
                        spanishWord: "la uva",
                        translation: "grape"
                    ),
                    Language.Term(
                        spanishWord: "la zanahoria",
                        translation: "carrot"
                    ),
                    Language.Term(
                        spanishWord: "el tomate",
                        translation: "tomato"
                    ),
                    Language.Term(
                        spanishWord: "la papa",
                        translation: "potato"
                    ),
                    Language.Term(
                        spanishWord: "la cebolla",
                        translation: "onion"
                    ),
                    Language.Term(
                        spanishWord: "la leche",
                        translation: "milk"
                    ),
                    Language.Term(
                        spanishWord: "el queso",
                        translation: "cheese"
                    ),
                    Language.Term(
                        spanishWord: "el pollo",
                        translation: "chicken"
                    ),
                    Language.Term(
                        spanishWord: "el pescado",
                        translation: "fish"
                    ),
                    Language.Term(
                        spanishWord: "el agua",
                        translation: "water"
                    )
                ],

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
                lessonText: """
                            To greet someone, say “Hola” (Hello) or “Buenos días” (Good morning). For introductions, use “Me llamo…” (My name is…) or “Soy…” (I am…). Asking how someone is doing is simple with “¿Cómo estás?” (How are you?), and you can respond with “Estoy bien” (I’m good) or “Estoy cansado/a” (I’m tired).

                            For polite exchanges, use “Por favor” (Please), “Gracias” (Thank you), and “De nada” (You’re welcome). When seeking assistance, say “¿Puedes ayudarme?” (Can you help me?), and if you need something repeated, say “¿Puedes repetir, por favor?” (Can you repeat, please?). Ending conversations politely is easy with “Adiós” (Goodbye) or “Hasta luego” (See you later). These phrases form the foundation for connecting in Spanish-speaking environments and are great for building confidence in real conversations!
                            """,
                vocabulary: [
                    Language.Term(
                        spanishWord: "Hola",
                        translation: "Hello"
                    ),
                    Language.Term(
                        spanishWord: "Buenos días",
                        translation: "Good morning"
                    ),
                    Language.Term(
                        spanishWord: "Me llamo…",
                        translation: "My name is…"
                    ),
                    Language.Term(
                        spanishWord: "Soy…",
                        translation: "I am…"
                    ),
                    Language.Term(
                        spanishWord: "¿Cómo estás?",
                        translation: "How are you? (informal)"
                    ),
                    Language.Term(
                        spanishWord: "Estoy bien",
                        translation: "I’m good"
                    ),
                    Language.Term(
                        spanishWord: "Estoy cansado/a",
                        translation: "I’m tired"
                    ),
                    Language.Term(
                        spanishWord: "Por favor",
                        translation: "Please"
                    ),
                    Language.Term(
                        spanishWord: "Gracias",
                        translation: "Thank you"
                    ),
                    Language.Term(
                        spanishWord: "De nada",
                        translation: "You’re welcome"
                    ),
                    Language.Term(
                        spanishWord: "¿Puedes ayudarme?",
                        translation: "Can you help me?"
                    ),
                    Language.Term(
                        spanishWord: "¿Puedes repetir, por favor?",
                        translation: "Can you repeat, please?"
                    ),
                    Language.Term(
                        spanishWord: "Adiós",
                        translation: "Goodbye"
                    ),
                    Language.Term(
                        spanishWord: "Hasta luego",
                        translation: "See you later"
                    )
                ],
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
                    lessonText: """
                                Here's a mini lesson on Spanish clothing vocabulary to help you get familiar with common terms related to apparel. To start, here are some basic clothing items: “la camiseta” (the t-shirt), “los pantalones” (the pants), “la falda” (the skirt), and “el vestido” (the dress). Accessories are also important, with words like “el sombrero” (the hat) and “los zapatos” (the shoes). Knowing these terms can help you describe what you or someone else is wearing.

                                When discussing clothing, you can use phrases like “¿Qué llevas puesto?” (What are you wearing?) and “Llevo…” (I am wearing…). For example, you could say “Llevo una camiseta y pantalones” (I am wearing a t-shirt and pants). Additionally, colors can enhance your vocabulary, such as “rojo” (red), “azul” (blue), and “verde” (green). Combining colors with clothing terms allows for more detailed descriptions, like “una camiseta roja” (a red t-shirt). Practicing these phrases will make it easier to discuss clothing in Spanish-speaking situations!
                                """,
                    vocabulary: [
                        Language.Term(
                            spanishWord: "la ropa",
                            translation: "clothes"
                        ),
                        Language.Term(
                            spanishWord: "la camiseta",
                            translation: "t-shirt"
                        ),
                        Language.Term(
                            spanishWord: "los pantalones",
                            translation: "pants"
                        ),
                        Language.Term(
                            spanishWord: "la falda",
                            translation: "skirt"
                        ),
                        Language.Term(
                            spanishWord: "el vestido",
                            translation: "dress"
                        ),
                        Language.Term(
                            spanishWord: "el sombrero",
                            translation: "hat"
                        ),
                        Language.Term(
                            spanishWord: "los zapatos",
                            translation: "shoes"
                        ),
                        Language.Term(
                            spanishWord: "la chaqueta",
                            translation: "jacket"
                        ),
                        Language.Term(
                            spanishWord: "los calcetines",
                            translation: "socks"
                        ),
                        Language.Term(
                            spanishWord: "el abrigo",
                            translation: "coat"
                        ),
                        Language.Term(
                            spanishWord: "los shorts",
                            translation: "shorts"
                        ),
                        Language.Term(
                            spanishWord: "la bufanda",
                            translation: "scarf"
                        ),
                        Language.Term(
                            spanishWord: "la corbata",
                            translation: "tie"
                        ),
                        Language.Term(
                            spanishWord: "el cinturón",
                            translation: "belt"
                        ),
                        Language.Term(
                            spanishWord: "la sudadera",
                            translation: "sweatshirt"
                        )
                    ],
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
                    lessonText: """
                                Here’s a mini lesson on Spanish vocabulary related to weather, which can help you describe different weather conditions and talk about the climate. Basic terms include “el sol” (the sun), “la lluvia” (the rain), “la nieve” (the snow), and “el viento” (the wind). You can also refer to “el cielo” (the sky) when discussing the weather. Understanding these terms allows you to express various weather phenomena.

                                To ask about the weather, you can use the phrase “¿Qué tiempo hace?” (What is the weather like?). Responses can include phrases like “Hace calor” (It’s hot), “Hace frío” (It’s cold), “Está nublado” (It’s cloudy), or “Está lloviendo” (It’s raining). Additionally, you can express preferences by saying “Me gusta el clima cálido” (I like warm weather) or “Prefiero el clima frío” (I prefer cold weather). Practicing these phrases will help you communicate effectively about weather conditions in Spanish-speaking environments!
                                """,
                    vocabulary: [
                        Language.Term(
                            spanishWord: "la lluvia",
                            translation: "rain"
                        ),
                        Language.Term(
                            spanishWord: "el sol",
                            translation: "sun"
                        ),
                        Language.Term(
                            spanishWord: "la nieve",
                            translation: "snow"
                        ),
                        Language.Term(
                            spanishWord: "el viento",
                            translation: "wind"
                        ),
                        Language.Term(
                            spanishWord: "el cielo",
                            translation: "sky"
                        ),
                        Language.Term(
                            spanishWord: "hace calor",
                            translation: "it's hot"
                        ),
                        Language.Term(
                            spanishWord: "hace frío",
                            translation: "it's cold"
                        ),
                        Language.Term(
                            spanishWord: "está nublado",
                            translation: "it's cloudy"
                        ),
                        Language.Term(
                            spanishWord: "está lloviendo",
                            translation: "it's raining"
                        ),
                        Language.Term(
                            spanishWord: "hace viento",
                            translation: "it's windy"
                        ),
                        Language.Term(
                            spanishWord: "la tormenta",
                            translation: "storm"
                        ),
                        Language.Term(
                            spanishWord: "el clima",
                            translation: "weather"
                        ),
                        Language.Term(
                            spanishWord: "la humedad",
                            translation: "humidity"
                        ),
                        Language.Term(
                            spanishWord: "el arco iris",
                            translation: "rainbow"
                        ),
                        Language.Term(
                            spanishWord: "la niebla",
                            translation: "fog"
                        )
                    ],
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
                    lessonText: """
                                Halloween, or “Día de Halloween,” is celebrated on October 31st and has become increasingly popular in many Spanish-speaking countries, although traditions may vary. Common symbols associated with Halloween include “la calabaza” (the pumpkin), which is often carved into a “calabaza de Jack” (Jack-o'-lantern), and “los disfraces” (costumes), which people wear to celebrate the occasion. Children often go “truco o trato” (trick-or-treating), visiting homes to collect candies and treats.

                                In addition to the fun activities, Halloween can also be a time to learn about related cultural traditions, such as “el Día de los Muertos” (the Day of the Dead), which is celebrated in Mexico on November 1st and 2nd. This holiday honors deceased loved ones with altars, flowers, and offerings. Understanding these customs helps enrich your knowledge of how Halloween and similar celebrations are observed in different cultures. Engaging with vocabulary like “fantasma” (ghost), “esqueleto” (skeleton), and “hechizo” (spell) can enhance your conversations about Halloween in Spanish!
                                """,
                    vocabulary: [
                        Language.Term(
                            spanishWord: "la calabaza",
                            translation: "pumpkin"
                        ),
                        Language.Term(
                            spanishWord: "el disfraz",
                            translation: "costume"
                        ),
                        Language.Term(
                            spanishWord: "truco o trato",
                            translation: "trick or treat"
                        ),
                        Language.Term(
                            spanishWord: "el fantasma",
                            translation: "ghost"
                        ),
                        Language.Term(
                            spanishWord: "el esqueleto",
                            translation: "skeleton"
                        ),
                        Language.Term(
                            spanishWord: "la bruja",
                            translation: "witch"
                        ),
                        Language.Term(
                            spanishWord: "el hechizo",
                            translation: "spell"
                        ),
                        Language.Term(
                            spanishWord: "los dulces",
                            translation: "candies"
                        ),
                        Language.Term(
                            spanishWord: "el cementerio",
                            translation: "graveyard"
                        ),
                        Language.Term(
                            spanishWord: "la telaraña",
                            translation: "spider web"
                        ),
                        Language.Term(
                            spanishWord: "la noche de brujas",
                            translation: "Halloween"
                        ),
                        Language.Term(
                            spanishWord: "el monstruo",
                            translation: "monster"
                        ),
                        Language.Term(
                            spanishWord: "el gato negro",
                            translation: "black cat"
                        ),
                        Language.Term(
                            spanishWord: "el vampiro",
                            translation: "vampire"
                        ),
                        Language.Term(
                            spanishWord: "la calavera",
                            translation: "skull"
                        )
                    ],
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
                    lessonText: """
                                Family, or “la familia,” is a central aspect of culture in Spanish-speaking countries, where family ties are often emphasized and celebrated. Understanding family vocabulary is essential for communicating about relationships and social dynamics. Key terms include “la madre” (mother), “el padre” (father), “el hermano” (brother), and “la hermana” (sister). Other important terms are “el abuelo” (grandfather) and “la abuela” (grandmother), which help you refer to extended family members. You may also come across terms like “el primo” (cousin) and “la prima” (female cousin) to describe relatives in your family.

                                In many Hispanic cultures, family gatherings and celebrations are significant. For instance, events like “la fiesta de cumpleaños” (birthday party) or “la reunión familiar” (family reunion) play an essential role in maintaining close family ties. Using phrases such as “¿Cómo está tu familia?” (How is your family?) can help you connect with others and show interest in their personal lives. Knowing this vocabulary will enhance your conversations about family and enrich your interactions in Spanish-speaking environments.
                                """,
                    vocabulary: [
                        Language.Term(
                            spanishWord: "la familia",
                            translation: "family"
                        ),
                        Language.Term(
                            spanishWord: "la madre",
                            translation: "mother"
                        ),
                        Language.Term(
                            spanishWord: "el padre",
                            translation: "father"
                        ),
                        Language.Term(
                            spanishWord: "el hermano",
                            translation: "brother"
                        ),
                        Language.Term(
                            spanishWord: "la hermana",
                            translation: "sister"
                        ),
                        Language.Term(
                            spanishWord: "el abuelo",
                            translation: "grandfather"
                        ),
                        Language.Term(
                            spanishWord: "la abuela",
                            translation: "grandmother"
                        ),
                        Language.Term(
                            spanishWord: "el primo",
                            translation: "cousin (male)"
                        ),
                        Language.Term(
                            spanishWord: "la prima",
                            translation: "cousin (female)"
                        ),
                        Language.Term(
                            spanishWord: "el tío",
                            translation: "uncle"
                        ),
                        Language.Term(
                            spanishWord: "la tía",
                            translation: "aunt"
                        ),
                        Language.Term(
                            spanishWord: "el hijo",
                            translation: "son"
                        ),
                        Language.Term(
                            spanishWord: "la hija",
                            translation: "daughter"
                        ),
                        Language.Term(
                            spanishWord: "el suegro",
                            translation: "father-in-law"
                        ),
                        Language.Term(
                            spanishWord: "la suegra",
                            translation: "mother-in-law"
                        )
                    ],
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
                    lessonText: """
                                Education plays a vital role in Spanish-speaking cultures, and knowing school-related vocabulary can greatly enhance your ability to communicate in academic settings. The term for “school” is “la escuela,” which is where students, or “los estudiantes,” learn various subjects. Essential vocabulary includes “el maestro” (male teacher) and “la maestra” (female teacher), along with important school items such as “el libro” (book), “el cuaderno” (notebook), and “el lápiz” (pencil). Understanding these terms will help you navigate conversations about education, classes, and learning experiences.

                                In addition to vocabulary, knowing key phrases can enhance your interactions at school. For instance, you might hear “¿Dónde está la clase de matemáticas?” (Where is the math class?) or “Tengo tarea para mañana” (I have homework for tomorrow). Engaging in discussions about your favorite subjects, like “la historia” (history) or “las ciencias” (science), can also provide an excellent opportunity to practice your Spanish. Familiarizing yourself with this vocabulary will enable you to participate in school-related conversations and deepen your understanding of educational contexts in Spanish-speaking environments.
                                """,
                    vocabulary: [
                        Language.Term(
                            spanishWord: "la escuela",
                            translation: "school"
                        ),
                        Language.Term(
                            spanishWord: "el maestro",
                            translation: "male teacher"
                        ),
                        Language.Term(
                            spanishWord: "la maestra",
                            translation: "female teacher"
                        ),
                        Language.Term(
                            spanishWord: "el estudiante",
                            translation: "male student"
                        ),
                        Language.Term(
                            spanishWord: "la estudiante",
                            translation: "female student"
                        ),
                        Language.Term(
                            spanishWord: "el libro",
                            translation: "book"
                        ),
                        Language.Term(
                            spanishWord: "el cuaderno",
                            translation: "notebook"
                        ),
                        Language.Term(
                            spanishWord: "el lápiz",
                            translation: "pencil"
                        ),
                        Language.Term(
                            spanishWord: "la tarea",
                            translation: "homework"
                        ),
                        Language.Term(
                            spanishWord: "las matemáticas",
                            translation: "mathematics"
                        ),
                        Language.Term(
                            spanishWord: "la historia",
                            translation: "history"
                        ),
                        Language.Term(
                            spanishWord: "las ciencias",
                            translation: "science"
                        ),
                        Language.Term(
                            spanishWord: "el examen",
                            translation: "exam"
                        ),
                        Language.Term(
                            spanishWord: "el aula",
                            translation: "classroom"
                        ),
                        Language.Term(
                            spanishWord: "la clase",
                            translation: "class"
                        )
                    ],
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
                    lessonText: """
                                Understanding the human body is essential for anyone learning Spanish, especially for those interested in health and wellness. The word for “body” is “el cuerpo,” and it comprises various parts, each with its own name. Key vocabulary includes “la cabeza” (the head), “los ojos” (the eyes), “la boca” (the mouth), and “las manos” (the hands). Each part plays a vital role in our daily lives, and knowing their names in Spanish allows for better communication in medical contexts, fitness discussions, or everyday conversations about health.

                                When discussing the human body, it's also helpful to know how to describe physical conditions or symptoms. For example, phrases like “me duele la cabeza” (my head hurts) or “tengo fiebre” (I have a fever) can be crucial in a medical setting. Engaging with vocabulary related to the human body not only enhances your language skills but also provides insight into how to discuss health and wellness effectively in Spanish-speaking contexts.
                                """,
                    vocabulary: [
                        Language.Term(
                            spanishWord: "el cuerpo",
                            translation: "the body"
                        ),
                        Language.Term(
                            spanishWord: "la cabeza",
                            translation: "the head"
                        ),
                        Language.Term(
                            spanishWord: "los ojos",
                            translation: "the eyes"
                        ),
                        Language.Term(
                            spanishWord: "la boca",
                            translation: "the mouth"
                        ),
                        Language.Term(
                            spanishWord: "las manos",
                            translation: "the hands"
                        ),
                        Language.Term(
                            spanishWord: "el corazón",
                            translation: "the heart"
                        ),
                        Language.Term(
                            spanishWord: "el estómago",
                            translation: "the stomach"
                        ),
                        Language.Term(
                            spanishWord: "las piernas",
                            translation: "the legs"
                        ),
                        Language.Term(
                            spanishWord: "los pies",
                            translation: "the feet"
                        ),
                        Language.Term(
                            spanishWord: "la piel",
                            translation: "the skin"
                        ),
                        Language.Term(
                            spanishWord: "los dedos",
                            translation: "the fingers"
                        ),
                        Language.Term(
                            spanishWord: "el brazo",
                            translation: "the arm"
                        ),
                        Language.Term(
                            spanishWord: "la espalda",
                            translation: "the back"
                        ),
                        Language.Term(
                            spanishWord: "la nariz",
                            translation: "the nose"
                        ),
                        Language.Term(
                            spanishWord: "la oreja",
                            translation: "the ear"
                        )
                    ],
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
                    lessonText: """
                                Learning about animals in Spanish is not only fun but also essential for expanding your vocabulary. Animals play a significant role in various cultures and ecosystems, and being able to identify and describe them can enhance your language skills. The word for “animal” in Spanish is “el animal.” Common animals include “el perro” (the dog), “el gato” (the cat), “el caballo” (the horse), and “el pájaro” (the bird). Understanding these basic terms allows learners to participate in conversations about pets, wildlife, and nature.

                                When discussing animals, it's also useful to know some adjectives and verbs associated with them. For example, you might say “el perro es leal” (the dog is loyal) or “los gatos son independientes” (cats are independent). Learning the sounds animals make can also be a fun aspect of language learning; for instance, “el perro ladra” (the dog barks) or “el gato maulla” (the cat meows). Engaging with vocabulary related to animals enhances your ability to communicate in diverse contexts, from conversations about pets to discussions about wildlife conservation.
                                """,
                    vocabulary: [
                        Language.Term(
                            spanishWord: "el animal",
                            translation: "the animal"
                        ),
                        Language.Term(
                            spanishWord: "el perro",
                            translation: "the dog"
                        ),
                        Language.Term(
                            spanishWord: "el gato",
                            translation: "the cat"
                        ),
                        Language.Term(
                            spanishWord: "el caballo",
                            translation: "the horse"
                        ),
                        Language.Term(
                            spanishWord: "el pájaro",
                            translation: "the bird"
                        ),
                        Language.Term(
                            spanishWord: "la vaca",
                            translation: "the cow"
                        ),
                        Language.Term(
                            spanishWord: "la oveja",
                            translation: "the sheep"
                        ),
                        Language.Term(
                            spanishWord: "el cerdo",
                            translation: "the pig"
                        ),
                        Language.Term(
                            spanishWord: "el pez",
                            translation: "the fish"
                        ),
                        Language.Term(
                            spanishWord: "el ratón",
                            translation: "the mouse"
                        ),
                        Language.Term(
                            spanishWord: "el león",
                            translation: "the lion"
                        ),
                        Language.Term(
                            spanishWord: "la tortuga",
                            translation: "the turtle"
                        ),
                        Language.Term(
                            spanishWord: "el elefante",
                            translation: "the elephant"
                        ),
                        Language.Term(
                            spanishWord: "el tigre",
                            translation: "the tiger"
                        ),
                        Language.Term(
                            spanishWord: "la mariposa",
                            translation: "the butterfly"
                        )
                    ],
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

