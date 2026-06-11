//
//  CalendarView.swift
//  a-via
//
//  Created by Soraia Freire Batista on 08/06/26.
//
import SwiftUI

struct CalendarView: View {
    var workouts: [WorkoutModel]
    
    @State private var viewModel = CalendarViewModel()
    
    var body: some View {
        ScrollView(.vertical){
            VStack(alignment:.leading, spacing: 24){
                Text("Calendário de Treinos")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding()
                ForEach(viewModel.groupWorkouts(workouts), id: \.self){ (section : [WorkoutModel]) in
                    
                    VStack(alignment: .leading, spacing: 8){
                        Section(header: Text(monthFormatterString.string(from: section[0].date as Date).firstUppercased).font(.title2).bold()){
                            if section[0].image != nil{
                                NavigationLink {
                                    SingleRunView(workout: section[0])
                                } label: {
                                    FeaturedWorkoutView(workout: section[0])
                                }
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8.0), count: 4), spacing: 8.0){
                                    ForEach(Array(section.dropFirst()), id: \.self){ workout in
                                        NavigationLink(destination: SingleRunView(workout: workout)){
                                            CalendarItemView(workout: workout)
                                                .aspectRatio(1, contentMode: .fit)
                                                .padding(.bottom, 8)

                                        }
                                    }
                                }
                            }
                            else{
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8.0), count: 4), spacing: 8.0){
                                    ForEach(section, id: \.self){ workout in
                                        NavigationLink(destination: SingleRunView(workout: workout)){
                                            CalendarItemView(workout: workout)
                                                .aspectRatio(1, contentMode: .fit)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)

    }
}
