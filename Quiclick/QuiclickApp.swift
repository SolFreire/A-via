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
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    var container : ModelContainer
    init(){
        do{
            container = try ModelContainer(for:WorkoutModel.self)
        } catch {
            fatalError("Could not initialize ModelContainer: \(error)")
        }
    }
    var body: some Scene{
        WindowGroup{
            if isFirstLaunch {
                OnboardingView(isOnboarding: $isFirstLaunch)
            }
            else{
                TabView{
                    Tab("Corridas", systemImage: "figure.run") {
                        ContentView()
                    }
                    Tab("Templates", systemImage:"photo.artframe"){
                        WeeklyTemplateView()
                    }
                }
                .tint(.limeButtons)

            }
        }
        .modelContainer(container)
    }
}

