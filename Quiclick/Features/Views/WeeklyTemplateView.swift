//
//  WeeklyTemplateView.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 27/04/26.
//
import SwiftUI
import SwiftData

struct WeeklyTemplateView: View {
    let calendar = Calendar.current

    @State private var viewModel = WeeklyTemplateViewModel()
    @Environment(\.modelContext) private var context

    @Query(sort: \WorkoutModel.id)
    private var workouts: [WorkoutModel]

    
    private var weeklyWorkouts: [WorkoutModel] {
        workouts.filter { $0.date.isCurrentWeek }
    }
    private var bestDistance: Double {
            viewModel.WeekBestDistance(weeklyWorkouts: weeklyWorkouts)
    }

    private var bestTime: TimeInterval {
        viewModel.WeekBestTime(weeklyWorkouts: weeklyWorkouts)
    }

    private var bestPace: Double {
        viewModel.WeekBestPace(weeklyWorkouts: weeklyWorkouts)
    }

    private var distanceViewType: BestDistanceCardView.ViewType {
        bestDistance >= 5000 ? .fivekm : .regular
    }

    private var timeViewType: BestTimeCardView.ViewType {
        bestTime >= 7200 ? .twohoursrunning : .regular
    }

    var body: some View {
        VStack(alignment: .leading) {
                    Text("Métricas da Semana")
                        .font(.largeTitle)
                        .bold()
            if weeklyWorkouts.isEmpty {
                EmptyWeekView()
            }
            else {
                ScrollView(.vertical,showsIndicators: false){
                    VStack {
                        WeeklyCounterCardView()
                        HStack {
                            BestDistanceCardView(
                                viewtype: distanceViewType,
                                bestDistance: bestDistance
                            )
                            BestTimeCardView(
                                viewtype: timeViewType,
                                bestTime: bestTime
                            )
                        }
                        BestPaceCardView(bestPace: bestPace)
                    }
                }
            }
        }
        .padding()
        
    }
}


#Preview {
    WeeklyTemplateView()
}
