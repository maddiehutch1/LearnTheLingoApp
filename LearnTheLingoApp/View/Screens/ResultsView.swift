//
//  ResultsView.swift
//  LearnTheLingoApp
//
//  Created by IS 543 on 10/28/24.
//

import SwiftUI

struct ResultsView: View {
//    let correctAnswers: Int
//    let numberOfQuestions: Int
    let score: Int
    
    var body: some View {
        VStack {
            Text("Your Results")
                .font(.headline)
                .padding()
            Text("\(score)")
                .font(.title)
            Button("Restart Quiz") {
                
            }
        }
        .background(Color.lightTan)
    }
}

#Preview {
    ResultsView(score: 20)
}
