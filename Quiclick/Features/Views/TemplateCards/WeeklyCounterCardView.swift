//
//  WeeklyCounterCardView.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 05/05/26.
//
import SwiftUI

struct WeeklyCounterCardView : View{
    var body: some View{
        ZStack(){
            Image("WeeklyDistanceCardImage")
                .resizable()
                .scaledToFit()
                .frame(width: 353, height: 300)
                .overlay {
                    Rectangle()
                        .fill(
                            Gradient(
                                stops: [
                                    .init(color: Color.clear, location: 0.8),
                                    .init(color: Color.black.opacity(0.5), location: 1),
                                ]
                            )
                        )
                }
                .cornerRadius(12)
            
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(width: 14)
                .offset(x:160,y:-126)
                .foregroundColor(Color.white)
                .bold()
            Text("Semana")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .offset(x:-110,y:126)

        }
    }
}

#Preview {
    WeeklyCounterCardView()
}
