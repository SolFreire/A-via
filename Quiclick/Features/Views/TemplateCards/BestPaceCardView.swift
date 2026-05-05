//
//  RewardCard.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 23/04/26.
//

import SwiftUI

struct BestPaceCardView: View{
    var body: some View{
        ZStack(){
            Image("PaceCardImage")
                .resizable()
                .scaledToFit()
                .frame(width: 353, height: 160)
                .cornerRadius(12)

                Text("05:00")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                   .padding()
        }
    }
}

#Preview {
    BestPaceCardView()
}

extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}
