//
//  TestWidget.swift
//  TestWidget
//
//  Created by Iris Roemermann on 13/12/2024.
//


import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), name: "Placeholder", streak: 0, progress: 0, target: "Target")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = loadSharedData()
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let entry = loadSharedData()
        let timeline = Timeline(entries: [entry], policy: .atEnd)  // Refresh after current entry time
        completion(timeline)
    }

    private func loadSharedData() -> SimpleEntry {
        // Get the shared data
        let userDefaults = UserDefaults(suiteName: "group.group-project.widget-test")
        let name = userDefaults?.string(forKey: "name") ?? "Unknown"
        let streak = userDefaults?.integer(forKey: "streak") ?? 0
        let progress = userDefaults?.integer(forKey: "progress") ?? 0
        let target = userDefaults?.string(forKey: "target") ?? "No Target"

        print("Widget Loaded Data - Name: \(name), Streak: \(streak), Progress: \(progress), Target: \(target)")

        return SimpleEntry(date: Date(), name: name, streak: streak, progress: progress, target: target)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let name: String
    let streak: Int
    let progress: Int
    let target: String
}

struct TestWidgetEntryView: View {
    var entry: SimpleEntry

    var body: some View {
        VStack {
            Text(entry.name)
            Text("Streak: \(entry.streak)")
            Text("Progress: \(entry.progress)")
            Text("Target: \(entry.target)")
        }
    }
}

struct TestWidget: Widget {
    let kind: String = "TestWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                TestWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                TestWidgetEntryView(entry: entry)
                    .padding()
                    .background(Color(.systemBackground))
            }
        }
        .configurationDisplayName("Equine Integration widget")
        .description("This is an example widget.")
    }
}

//
//@main
//struct TestWidgetBundle: WidgetBundle {
//    @WidgetBundleBuilder
//    var body: some Widget {
//        TestWidget()
//    }
//}

//#Preview(as: .systemSmall) {
//    TestWidgetEntryView(entry: SimpleEntry(date: Date(), name: "Timmy", streak: 3, progress: 3, target: "Train 4 times this week"))
//}
