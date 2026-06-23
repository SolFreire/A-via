//
//  WorkoutCardView.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 23/04/26.
//

import SwiftUI

struct WorkoutCardView: View {
    
    let workout: WorkoutModel
    
    var body: some View {
        
        HStack(spacing: 0) {
            if(workout.imageData != nil){
                if let image = workout.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame( maxWidth: 72, idealHeight: 107, alignment: .top)
                        .clipped()
                }
            }else{
                Rectangle()
                    .frame( maxWidth: 72, idealHeight: 107,maxHeight: 147)
                    .foregroundColor(.blankCard)
                    .overlay {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(.white)
                            .font(.system(size: 40))
                    }
            }
            
            VStack(alignment: .leading, spacing : 12){
                
                Text(dateFormatter.string(from: workout.date))
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .padding(.top, 6)
                
                HStack(spacing :2){
                    content
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .border(.clear)
        .background(.carbonCards)
        .cornerRadius(10)
    }
    
    @ViewBuilder
    var content: some View {
        ViewThatFits{
            HStack(spacing : 1){
                VStack(alignment: .leading, spacing: 8){
                    Text("Distância")
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text("\((workout.distance/1000).formatted()) km")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                VStack(alignment: .leading, spacing: 8){
                    Text("Tempo")
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(formatDuration(workout.duration))
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                VStack(alignment: .leading, spacing: 8){
                    Text("Pace")
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text("\(paceformatter(workout.pace))/km")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
            }.padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 10){
                HStack(spacing: 8){
                    Text("Distância : \((workout.distance/1000).formatted()) km")
                        .font(.caption)
                        .fontWeight(.semibold)
                }

                HStack(spacing: 8){
                    Text("Tempo : \(formatDuration(workout.duration))")
                        .font(.caption)
                        .fontWeight(.semibold)

                }
                HStack(spacing: 8){
                    Text("Pace : \(paceformatter(workout.pace))/km")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }.padding()
        }
    }
}

func formatDuration(_ duration : Double) -> String{
    let total = duration
    var durationformated : String = ""
    let hours = floor(total/3600)
    let minuts = floor((total - (hours*3600))/60)
    let seconds = floor(total.truncatingRemainder(dividingBy: 60))
    if hours == 0{
         durationformated = "\(minuts.formatted())m \(seconds.formatted())s "
    }
    else{
        durationformated = "\(hours.formatted())h \(minuts.formatted())m \(seconds.formatted())s "
    }
    return durationformated
}

#Preview {
    WorkoutCardView(workout: WorkoutModel(id: UUID(), date: Date(), duration: 1025, distance: 1234))
}
