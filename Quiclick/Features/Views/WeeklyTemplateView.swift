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
    
    private var weeklyTotalDistance: Int {
        viewModel.weeklyTotalDistance(weeklyWorkouts: weeklyWorkouts)
    }

    private var bestTime: TimeInterval {
        viewModel.WeekBestTime(weeklyWorkouts: weeklyWorkouts)
    }

    private var bestPace: Double {
        viewModel.WeekBestPace(weeklyWorkouts: weeklyWorkouts)
    }
    
    private var weeklyCounterViewType: ViewType {
        .weeklydistance
    }

    private var distanceViewType: ViewType {
        if bestDistance >= 5000 && bestDistance < 10000 {
            .distance5km
        }
        else if bestDistance >= 10000 && bestDistance < 15000 {
            .distance10km
        }
        else if bestDistance >= 15000 && bestDistance < 21000 {
            .distance15km
        }
        else if bestDistance >= 21000 && bestDistance < 42000 {
            .distance21km
        }
        else if bestDistance >= 42000 {
            .distance42km
        }
        else {
            .distanceregular
        }
    }

    private var timeViewType: ViewType {
        bestTime >= 7200 ? .time2hours : .timeregular
    }
    
    private var paceViewType: ViewType {
        .bestpace
    }
    
    @State private var metricViewType: ViewType? = nil
    @State private var nameMetric: String? = nil

    var body: some View {
        NavigationStack {
            
            ScrollView(.vertical ,showsIndicators: false) {
                if weeklyWorkouts.isEmpty {
                    EmptyWeekView()
                } else {
                    VStack {
                        CardView(viewtype: weeklyCounterViewType)
                            .onTapGesture {
                                metricViewType = weeklyCounterViewType
                                nameMetric = "Distância Percorrida na Semana"
                            }
                        
                        HStack {
                            if distanceViewType == .distanceregular {
                                CardView(viewtype: distanceViewType)
 
                            }
                            else{
                                CardView(viewtype: distanceViewType)
                                    .onTapGesture {
                                        metricViewType = distanceViewType
                                        nameMetric = "Melhor Distância"
                                    }
                            }
                            CardView(viewtype: timeViewType)
                                .onTapGesture {
                                    metricViewType = timeViewType
                                    nameMetric = "Melhor tempo"
                            }
                        }
                        
                        CardView(viewtype: paceViewType)
                            .onTapGesture {
                                metricViewType = paceViewType
                                nameMetric = "Melhor Pace"
                            }
                    }
                }
            }
            .navigationDestination(item: $metricViewType) { metricViewType in
                TemplateShareView(
                    metricViewType: metricViewType,
                    titleMetric: nameMetric ?? "Métrica",
                    imageTemplate: UIImage(named: metricViewType.image),
                    bestPace: bestPace,
                    weeklyDistance: weeklyTotalDistance,
                    bestTime: bestTime)
            }
            .navigationTitle("Métricas da Semana")
        }
    }
}


#Preview {
    WeeklyTemplateView()
}
