//
//  WorkoutCardView.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 23/04/26.
//

import SwiftUI

struct WorkoutCardView: View {
    
    let workout: WorkoutModel
    
    let dateFormatter={
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    

    var body: some View {

        VStack(spacing: 0) {
            if(workout.imageData != nil){
                if let image = workout.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth:353, maxWidth: .infinity, minHeight: 283, maxHeight: 283, alignment: .top)
                        .clipped()
                      

               }
            }else{
                Rectangle()
                    .frame(minWidth:353, maxWidth: .infinity, minHeight: 283, maxHeight: 283)
                    .foregroundColor(.gray.opacity(0.2))
                    .overlay {
                        Image(systemName: "photo")
                            .foregroundStyle(.white)
                            .font(.system(size: 50))
                    }
                    .clipped()
            }
            VStack(alignment: .leading, spacing: 12){
                Text(dateFormatter.string(from: workout.date))
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.horizontal)

                HStack(spacing:30){
                    ViewThatFits{
                        HStack(spacing: 30){
                            content
                        }
                        VStack(alignment: .leading){
                            content

                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(minWidth:353, maxWidth: .infinity, minHeight: 116, alignment: .leading)
            .background(.gray.opacity(0.1))
            
        }
        .cornerRadius(10)
    }
    
    @ViewBuilder
    var content: some View {
        VStack(alignment: .leading, spacing: 8){
            Text("Distância")
                .font(.caption)
                .fontWeight(.medium)
            Text("\((workout.distance/1000).formatted()) km")
                .font(.callout)
                .fontWeight(.medium)
        }
        VStack(alignment: .leading, spacing: 8){
            Text("Pace")
                .font(.caption)
                .fontWeight(.medium)
            Text("\(workout.pace.formatted(.number.precision(.fractionLength(2))))/km")
                .font(.callout)
                .fontWeight(.medium)
        }
        VStack(alignment: .leading, spacing: 8){
            Text("Tempo")
                .font(.caption)
                .fontWeight(.medium)
            Text(formatDuration(workout.duration))
                .font(.callout)
                .fontWeight(.medium)
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
    WorkoutCardView(workout: WorkoutModel(id: UUID(), date: Date(), duration: 2222, distance: 1000))
}
