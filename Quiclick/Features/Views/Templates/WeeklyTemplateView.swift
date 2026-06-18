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
    @State private var viewModelShareView = SingleRunViewModel()
    
    @Environment(\.modelContext) private var context
    
    @Query(sort: \WorkoutModel.id)
    private var workouts: [WorkoutModel]
    
    let listTemplateDistance: [TypeTemplateView] = [.distance5km, .distance10km, .distance15km, .distance21km, .distance42km]
    let listTemplateTime: [TypeTemplateView] = [.timeregular, .time2hours]
    let templatePace: TypeTemplateView = .bestpace
    
    private var bestDistance: Double {
        viewModel.BestDistance(Workouts: workouts)
    }
    //
    private var weeklyTotalDistance: Int {
        viewModel.weeklyTotalDistance(weeklyWorkouts: workouts)
    }
    
    private var bestTime: TimeInterval {
        viewModel.WeekBestTime(weeklyWorkouts: workouts)
    }
    
    private var bestPace: Double {
        viewModel.WeekBestPace(weeklyWorkouts: workouts)
    }
    
    private var weeklyCounterViewType: TypeTemplateView {
        .weeklydistance
    }
    
    //    private func distanceViewType: ViewType (TemplateImage: String) {
    //        if bestDistance >= 5000 && bestDistance < 10000 {
    //            .distance5km
    //        }
    //        else if bestDistance >= 10000 && bestDistance < 15000 {
    //            .distance10km
    //        }
    //        else if bestDistance >= 15000 && bestDistance < 21000 {
    //            .distance15km
    //        }
    //        else if bestDistance >= 21000 && bestDistance < 42000 {
    //            .distance21km
    //        }
    //        else if bestDistance >= 42000 {
    //            .distance42km
    //        }
    //        else {
    //            .distanceregular
    //        }
    //    }
    
    private var timeViewType: TypeTemplateView {
        bestTime >= 7200 ? .time2hours : .timeregular
    }
    
    private var paceViewType: TypeTemplateView {
        .bestpace
    }
    
    @State private var metricViewType: TypeTemplateView? = nil
    @State private var nameMetric: String? = nil
    @State var shareImageTemplate: UIImage? = UIImage(named: "EmptyDistanceCardView")
    @State var shareTemplate: TypeTemplateView = .distanceregular
    @State private var showingSheetShare = false
    
    var body: some View {
        NavigationStack {
            
            if workouts.isEmpty {
                EmptyWeekView()
            } else {
                ScrollView(.vertical ,showsIndicators: false) {
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 15) {
                            shareStory
                                .onTapGesture {
                                    showingSheetShare = true
                                }
                                .sheet(isPresented: $showingSheetShare){
                                    TemplateShareView( imageTemplate: shareStory )
                                }
                            
                            shareFeed
                                .onTapGesture {
                                    showingSheetShare = true
                                }
                                .sheet(isPresented: $showingSheetShare){
                                    TemplateShareView( imageTemplate: shareFeed )
                                }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .safeAreaPadding()
                    
                    
                    
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
    @ViewBuilder
    func imageSection(metricViewType: TypeTemplateView) -> some View {
        switch metricViewType {
        case .timeregular:
            VStack {
                Text("Uau!\nSua corrida mais\nlonga durou")
                Text("\(floor((bestTime)/60).formatted()) minutos.")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .font(.system(size: 22, weight: .bold))
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .foregroundStyle(.white)
            .dynamicTypeSize(.large)
            
            
        case .bestpace:
            VStack {
                Text("Pace de ")
                Text("\((bestPace).formatted(.number.precision(.fractionLength(2))))" + " min/km")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Rápido como quem\nperdeu o ônibus")
            }
            .font(.system(size: 22, weight: .bold))
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .foregroundStyle(.white)
            .dynamicTypeSize(.large)
            
        default:
            Text("")
        }
    }
    
    var shareStory: some View{
        Image(shareTemplate.image)
            .resizable()
            .scaledToFill()
            .frame(width: 318, height: 600)
            .clipped()
            .cornerRadius(12)
            .overlay {
                if (shareTemplate == .bestpace) {
                    imageSection(metricViewType: shareTemplate)
                        .offset(y: 130)
                }
                else if (shareTemplate == .timeregular) {
                    imageSection(metricViewType: shareTemplate)
                        .offset(y: -150)
                }
                else {
                    imageSection(metricViewType: shareTemplate)
                }
            }
    }
    
    var shareFeed: some View {
        Image(shareTemplate.image)
            .resizable()
            .scaledToFill()
            .frame(width: 318, height: 396)
            .clipped()
            .cornerRadius(12)
            .overlay {
                if (shareTemplate == .bestpace) {
                    imageSection(metricViewType: shareTemplate)
                        .offset(y: 99)
                }
                else if (shareTemplate == .timeregular) {
                    imageSection(metricViewType: shareTemplate)
                        .offset(y: -99)
                    
                }
                else {
                    imageSection(metricViewType: shareTemplate)
                }
            }
        }
}



#Preview {
    WeeklyTemplateView()
}
