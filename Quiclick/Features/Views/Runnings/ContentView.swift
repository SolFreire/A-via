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
                        .padding(.trailing, 10)

                }
                Text("Suas Corridas")
                    .font(.title3)
                    .bold()
                
                //temp
                Rectangle()
                    .frame(width: 359, height: 140)
                    .cornerRadius(10)
                    .padding(.vertical, 30)
                
                VStack(alignment:.leading, spacing:16){
                    Text("Corridas recentes")
                        .font(.title3)
                        .bold()
                        .padding(.top, 10)
                    if viewModel.isLoading {
                        HealthLoadingView()
                    }
                    else{
                        ScrollView(.vertical, showsIndicators: false){
                            if workouts.isEmpty {
                                EmptyView()
                                    .padding(40)
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
