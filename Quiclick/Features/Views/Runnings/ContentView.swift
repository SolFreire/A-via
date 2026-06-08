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
    @State private var viewModel = WorkoutViewModel()
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading, spacing: 6){
                Text("Avia, corredor!")
                    .font(.largeTitle)
                    .bold()
                Text("Suas Corridas")
                    .font(.title3)
                    .bold()
                if viewModel.isLoading {
                    HealthLoadingView()
                }
                else {
                    Text("Corridas recentes")
                        .font(.title3)
                        .bold()
                    ScrollView(.vertical, showsIndicators: false){
                        if workouts.isEmpty {
                            EmptyView()
                        }
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(workouts) { workout in
                                    NavigationLink {
                                        SingleRunView(workout: workout)
                                    } label: {
                                        WorkoutCardView(workout: workout)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                    .refreshable {
                        Task{
                            await viewModel.requestAuthorization(context:context)}
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
