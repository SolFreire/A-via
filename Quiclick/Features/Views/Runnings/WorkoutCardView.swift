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
                        .frame( maxWidth: 72, idealHeight: 107,maxHeight: 147, alignment: .top)
                        .clipped()
                }
            }else{
                Rectangle()
                    .frame( maxWidth: 72, idealHeight: 107,maxHeight: 147)
                    .foregroundColor(.gray.opacity(0.2))
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
                
                HStack(spacing :30){
                    VStack(alignment: .leading, spacing: 6){
                        Text("Distância")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text("\((workout.distance/1000).formatted()) km")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    VStack(alignment: .leading, spacing: 6){
                        Text("Tempo")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text(formatDuration(workout.duration))
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    VStack(alignment: .leading, spacing: 6){
                        Text("Pace")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text("\(workout.pace.formatted(.number.precision(.fractionLength(2))))/km")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                }.padding(.horizontal)
                
            }
        }
        .frame(minWidth:287, maxWidth: .infinity, idealHeight: 107, maxHeight: 147, alignment: .leading)
        .background(.carbonCards)
        .cornerRadius(10)
    }
    
    @ViewBuilder
    var content: some View {
        VStack(alignment: .leading, spacing: 8){
            Text("Distância")
                .font(.caption)
                .fontWeight(.semibold)
            Text("\((workout.distance/1000).formatted()) km")
                .font(.headline)
                .fontWeight(.semibold)
        }
        VStack(alignment: .leading, spacing: 8){
            Text("Tempo")
                .font(.caption)
                .fontWeight(.semibold)
            Text(formatDuration(workout.duration))
                .font(.headline)
                .fontWeight(.semibold)
        }
        VStack(alignment: .leading, spacing: 8){
            Text("Pace")
                .font(.caption)
                .fontWeight(.semibold)
            Text("\(workout.pace.formatted(.number.precision(.fractionLength(2))))/km")
                .font(.headline)
                .fontWeight(.semibold)
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
    WorkoutCardView(workout: WorkoutModel(id: UUID(), date: Date(), duration: 2222, distance: 1234))
}
