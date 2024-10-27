//
//  QuizView.swift
//  LearnTheLingoApp
//
//  Created by IS 543 on 10/26/24.
//

import SwiftUI

struct QuizView: View {
    
    var languageViewModel = LanguageViewModel()
    
    let topicTitle: String
    
    var topic: Language.Topic {
        languageViewModel.selectedTopic(for: topicTitle)
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    QuizView(languageViewModel: LanguageViewModel(), topicTitle: "Numbers")
}
