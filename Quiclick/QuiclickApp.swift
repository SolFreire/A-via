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
    
    var container : ModelContainer = {
        do {
            let cloud = ModelConfiguration(
                "Cloud",
                schema: Schema([
                    WorkoutModelCloud.self
                ]),
                cloudKitDatabase: .private("iCloud.personalproject.Quiclick")
            )
            let local = ModelConfiguration(
                "Local",
                schema: Schema([WorkoutModel.self
                ]),
                cloudKitDatabase: .none
            )
            return try  ModelContainer(
                for: Schema([WorkoutModelCloud.self,
                             WorkoutModel.self
                ]),
                configurations: [cloud,local]
            )
        }
        catch{
            fatalError("Container init failed \(error)")
        }
    }()
}

