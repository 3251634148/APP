//
//  LCX_IOS_APPApp.swift
//  LCX-IOS-APP
//
//  Created by lcx001st on 2025/1/15.
//

import SwiftUI
import Firebase

@main
struct LCX_IOS_APPApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ChatView()
        }
    }
}
