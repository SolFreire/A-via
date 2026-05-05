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
                .frame(width: .infinity, height: 160)
                .cornerRadius(12)

        }
    }
}

#Preview {
    WeeklyCounterCardView()
}
