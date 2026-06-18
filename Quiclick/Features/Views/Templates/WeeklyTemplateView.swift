//
//  WeeklyTemplateView.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 27/04/26.
//
import SwiftUI
import SwiftData

struct WeeklyTemplateView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \WorkoutModel.id)
    private var workouts: [WorkoutModel]
    
    @State private var viewModel = WeeklyTemplateViewModel()
    @State var shareImageTemplate: UIImage? = UIImage(named: "EmptyDistanceCardView")
    @State var shareTemplate: TypeTemplateView = .distanceregular
    @State var toShareTemplateSheet: ToShareTemplate? = nil
    
    let listTemplateDistance: [TypeTemplateView] = [.distance5km, .distance10km, .distance15km, .distance21km, .distance42km]
    let listTemplateTime: [TypeTemplateView] = [.timeregular, .time2hours]
    let templatePace: TypeTemplateView = .bestpace
    
    
    private var bestDistance: Double {
        viewModel.BestDistance(Workouts: workouts)
    }
    
    private var bestTime: TimeInterval {
        viewModel.WeekBestTime(weeklyWorkouts: workouts)
    }
    
    private var bestPace: Double {
        viewModel.WeekBestPace(weeklyWorkouts: workouts)
    }
    
    var body: some View {
        NavigationStack {
            
            if workouts.isEmpty {
                EmptyWeekView()
            } else {
                ScrollView(.vertical ,showsIndicators: false) {
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 15) {
                            ForEach(ShareMode.allCases, id: \.self) { mode in
                                 let toShareTemplate = ToShareTemplate(
                                    template: shareTemplate,
                                    shareMode: mode,
                                    bestPace: bestPace,
                                    bestTime: bestTime
                                )
                                
                                ImageTemplateView(
                                    toShareTemplate: toShareTemplate
                                )
                                .onTapGesture {
                                    self.toShareTemplateSheet = toShareTemplate
                                }
                                
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .safeAreaPadding()
                    .sheet(item: $toShareTemplateSheet) { shareTemplate in
                        TemplateShareView(
                            toShareTamplate: shareTemplate
                        )
                    }
                    
                    
                    VStack (alignment: .leading, spacing: 40){
                        
                        VStack (alignment: .leading, spacing: 10) {
                            Text("Templates de distância")
                                .font(.title3)
                                .fontWeight(.medium)
                            
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack(alignment: .center, spacing: 10) {
                                    
                                    ForEach (listTemplateDistance, id: \.self) { templateDistance in
                                        let isBlocked = viewModel.templateDistanceBlocked(viewTypeTemplate: templateDistance, bestDistance: bestDistance)
                                        
                                        Image(templateDistance.image)
                                            .resizable()
                                            .frame(width: 76, height: 165)
                                            .cornerRadius(12)
                                            .scaledToFit()
                                            .overlay(
                                                !isBlocked ?
                                                ZStack{
                                                    Rectangle()
                                                        .frame(width: 76, height: 165)
                                                        .cornerRadius(12)
                                                        .foregroundStyle(Color.gray.opacity(0.7))
                                                    Image(systemName: "lock.fill")
                                                        .font(.title)
                                                }
                                                : nil
                                                
                                            )
                                            .onTapGesture {
                                                if (isBlocked){
                                                    shareImageTemplate = UIImage(named: templateDistance.image)
                                                    shareTemplate = templateDistance
                                                }
                                            }
                                    }
                                }
                            }
                        }
                        
                        VStack (alignment: .leading, spacing: 10){
                            Text("Templates de tempo")
                                .font(.title3)
                                .fontWeight(.medium)
                            
                            ScrollView (.horizontal) {
                                HStack(alignment: .center, spacing: 10) {
                                    
                                    ForEach (listTemplateTime, id: \.self) { templateTime in
                                        let isBlocked = viewModel.templateTimeBlocked(viewTypeTemplate: templateTime, bestTime: bestTime/3600)
                                        
                                        Image(templateTime.image)
                                            .resizable()
                                            .frame(width: 76, height: 165)
                                            .cornerRadius(12)
                                            .scaledToFit()
                                            .overlay(
                                                !isBlocked ?
                                                ZStack{
                                                    Rectangle()
                                                        .frame(width: 76, height: 165)
                                                        .cornerRadius(12)
                                                        .foregroundStyle(Color.gray.opacity(0.7))
                                                    Image(systemName: "lock.fill")
                                                        .font(.title)
                                                }
                                                : nil
                                            )
                                            .onTapGesture {
                                                if (isBlocked){
                                                    shareImageTemplate = UIImage(named: templateTime.image)
                                                    shareTemplate = templateTime
                                                }
                                            }
                                    }
                                    
                                }
                                
                            }
                        }
                        
                        VStack (alignment: .leading, spacing: 10) {
                            Text("Templates de pace")
                                .font(.title3)
                                .fontWeight(.medium)
                            
                            Image(templatePace.image)
                                .resizable()
                                .frame(width: 76, height: 165)
                                .cornerRadius(12)
                                .scaledToFit()
                                .onTapGesture {
                                    shareImageTemplate = UIImage(named: templatePace.image)
                                    shareTemplate = templatePace
                                }
                        }
                        
                        
                    }
                    .padding()
                    .navigationTitle("Templates")
                }
            }
        }
    }
}

#Preview {
    WeeklyTemplateView()
}
