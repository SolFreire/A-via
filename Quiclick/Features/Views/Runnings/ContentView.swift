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
    private var recentWorkouts:[WorkoutModel] = []
    var body: some View {
        NavigationStack{
            ScrollView(.vertical) {
                VStack(alignment:.leading, spacing: 6){
                            HStack{
                                Text("Avia, corredor!")
                                    .font(.largeTitle)
                                    .bold()
                                Spacer()
                                NavigationLink{
                                    CalendarView(workouts: workouts)
                                }label:{Image(systemName: "calendar")}
                                    .font(.system(size: 28))
                                    .foregroundStyle(.limeButtons)
                                }
                                Text("Suas Corridas")
                                    .font(.title3)
                                    .bold()
                                
                                //temp
                                NavigationLink {
                                    if !workouts.isEmpty {
                                        SingleRunView(workout: workouts.first!)
                                    }
                                } label: {
                                    MainCard()
                                        .multilineTextAlignment(.leading)
                                }
                                .padding(.vertical, 30)
                                .frame(minWidth: 344, maxWidth: .infinity, maxHeight: 900)
                                
                                
                                VStack(alignment:.leading, spacing:16){
                                    Text("Corridas recentes")
                                        .font(.title3)
                                        .bold()
                                        .padding(.top, 10)
                                    if viewModel.isLoading {
                                        HealthLoadingView()
                                    }
                                    else{
                                        if workouts.isEmpty {
                                            EmptyView()
                                                .padding(40)
                                        }
                                        else{
                                            VStack(alignment: .leading, spacing: 20) {
                                                VStack(alignment: .leading, spacing: 8) {
                                                    ForEach(workouts, id: \.self) { workout in
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
                                    }

                                }
                                
                            }
                            .padding()
            }
            .refreshable {
                Task{
                    await viewModel.requestAuthorization(context:context)}
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
