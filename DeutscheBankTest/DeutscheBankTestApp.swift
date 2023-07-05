//
//  DeutscheBankTestApp.swift
//  DeutscheBankTest
//
//  Created by Taranjeet Kaur on 04/07/23.
//

import SwiftUI

@main
struct DeutscheBankTestApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView()
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
