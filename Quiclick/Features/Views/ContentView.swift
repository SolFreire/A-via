//
//  ContentView.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 23/04/26.
//

import SwiftUI
import SwiftData
import HealthKit

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \WorkoutModel.date, order: .reverse)
    private var workouts: [WorkoutModel]
    private var weeklyWorkouts: [WorkoutModel] {
        workouts.filter { $0.date.isCurrentWeek }
    }
    @State private var viewDenied = false
    @State private var viewModel = WorkoutViewModel()
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading, spacing: 8){
                Text("Eai, Corredor?")
                    .font(.largeTitle)
                    .bold()
                if viewModel.isLoading {
                    HealthLoadingView()
                }
                else {
                    Text("Corridas da Semana")
                        .font(.title3)
                        .fontWeight(.medium)

                    if weeklyWorkouts.isEmpty {
                        EmptyView()
                    } else {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 20) {
                                VStack(alignment: .leading, spacing: 8) {
                                    ForEach(weeklyWorkouts) { workout in
                                        NavigationLink {
                                            SingleRunView(workout: workout)
                                        } label: {
                                            WorkoutCardView(workout: workout)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }.onAppear{
            Task{
                await viewModel.requestAuthorization(context:context)
            }
        }

    }
}

#Preview {
    ContentView()
        .modelContainer(for: WorkoutModel.self, inMemory: true)
}
