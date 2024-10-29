//
//  LearnTheLingoAppApp.swift
//  LearnTheLingoApp
//
//  Created by IS 543 on 10/26/24.
//

import SwiftUI

@main
struct LearnTheLingoAppApp: App {
    var body: some Scene {
        WindowGroup {
            // the intial instance that is set and will be used throughout the app
            HomeView(languageViewModel: LanguageViewModel())
        }
    }
}
