//
//  CleanArchitectureApp.swift
//  CleanArchitecture
//
//  Created by jrobles on 07/01/2025.
//

import SwiftUI

@main
struct CleanArchitectureApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel())
        }
    }
}