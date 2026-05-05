//
//  RewardCard.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 23/04/26.
//

import SwiftUI

struct RewardCardView: View{
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Color(hex: 0x1b5518))
                .frame(width: 360, height: 178)
                
                
            HStack{
                Spacer()
                VStack(alignment: .leading){
                    Text("Parabéns! Você correu")
                        .foregroundStyle(Color.white)
                        .font(.caption)
                    Text("50 Km")
                        .bold()
                        .font(.largeTitle)
                        .foregroundStyle(Color.white)
                    Text("O equivalente ao comprimento do Rio Cocó!")
                        .foregroundStyle(Color.white)
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                }
                Image("RunRiver")
                    .resizable()
                    .scaledToFit()
                
            }
            .padding(30)
        }
    }
}

#Preview {
    RewardCardView()
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
