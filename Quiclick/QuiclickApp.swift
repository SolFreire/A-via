//
//  QuiclickApp.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 23/04/26.
//

import SwiftUI
import SwiftData

@main
struct QuiclickApp: App {

    var body: some Scene{
        WindowGroup{
            TabView{
                Tab("Corridas", systemImage: "figure.run") {
                    ContentView()
                }
                Tab("Templates", systemImage:"photo.artframe"){
                    WeeklyTemplateView()
                }
            }
        }
        .modelContainer(for: WorkoutModel.self)
    }
}
