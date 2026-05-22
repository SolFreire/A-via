////
////  RewardCard.swift
////  Quiclick
////
////  Created by Soraia Freire Batista on 23/04/26.
////
//
//import SwiftUI
//
//struct BestPaceCardView: View{
//    var bestPace: Double
//    
//    var body: some View{
//        ZStack(alignment: .bottomLeading){
//            Image("PaceCardImage")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 353, height: 160)
//                .overlay {
//                    Rectangle()
//                        .fill(
//                            Gradient(
//                                stops: [
//                                    .init(color: Color.clear, location: 0.5),
//                                    .init(color: Color.black.opacity(0.5), location: 1),
//                                ]
//                            )
//                        )
//                }
//                .cornerRadius(12)
//                .shadow(radius: 4)
//                
//            Image(systemName: "chevron.right")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 14)
//                .offset(x:320,y:-120)
//                .foregroundColor(Color.white)
//                .bold()
//            HStack{
//                Text("Pace")
//                    .font(.system(size: 34, weight: .bold))
//                    .foregroundColor(Color.white)
//            }.padding()
//        }
//    }
//}
//
//#Preview {
//    BestPaceCardView(bestPace: 4.30)
//}
//
//extension Color {
//    init(hex: Int, opacity: Double = 1) {
//        self.init(
//            .sRGB,
//            red: Double((hex >> 16) & 0xff) / 255,
//            green: Double((hex >> 08) & 0xff) / 255,
//            blue: Double((hex >> 00) & 0xff) / 255,
//            opacity: opacity
//        )
//    }
//}
