//
//  widget_testApp.swift
//  widget-test
//
//  Created by Iris Roemermann on 13/12/2024.
//

import SwiftUI
import Foundation
import WidgetKit

func updateSharedData(name: String, streak: Int, progress: Int, target: String) {
    // Set the data that should be shared between app & widget
    if let userDefaults = UserDefaults(suiteName: "group.group-project.widget-test") {
        userDefaults.set(name, forKey: "name")
        userDefaults.set(streak, forKey: "streak")
        userDefaults.set(progress, forKey: "progress")
        userDefaults.set(target, forKey: "target")
        userDefaults.synchronize() // Synchronize is usually unnecessary, but helpful for debugging
        print("Shared data updated: Name: \(name), Streak: \(streak), Progress: \(progress), Target: \(target)")
    } else {
        print("Failed to initialize UserDefaults with suiteName.")
    }
    
    // Reload all widget timelines after data update
    WidgetCenter.shared.reloadAllTimelines()
    print("Widget timelines reloaded after data update.")
}


func onNameChanged(newName: String) {
    // Values
    let updatedStreak = 5
    let updatedProgress = 4
    let updatedTarget = "Testing"

    print("call update data")

    // Update shared data
    updateSharedData(name: newName, streak: updatedStreak, progress: updatedProgress, target: updatedTarget)
    print("updated data")
}


@main
struct widget_testApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
