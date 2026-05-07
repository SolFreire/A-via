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
            ScrollView{
                VStack(alignment: .leading, spacing: 20){
                    VStack(alignment: .leading, spacing: 8){
                        Text("Eai, Corredor?")
                            .font(.largeTitle)
                            .bold()
                        Text("Corridas da Semana")
                            .font(.title3)
                            .fontWeight(.medium)
                    }
                    if(workouts.isEmpty){
                        Spacer()
                        Text("Parece que alguém ainda não começou a correr")
                    }
                    else{
                        ForEach(workouts){ workout in
                            NavigationLink{
                                SingleRunView(workout: workout)
                            } label:{
                                WorkoutCardView(workout: workout)
                            }
                                
                        }
                    }
                }

            }
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
