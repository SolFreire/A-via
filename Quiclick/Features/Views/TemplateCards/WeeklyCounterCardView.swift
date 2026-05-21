////
////  WeeklyCounterCardView.swift
////  Quiclick
////
////  Created by Soraia Freire Batista on 05/05/26.
////
//import SwiftUI
//
//struct WeeklyCounterCardView : View{
//    
//    var body: some View{
//        ZStack(alignment: .bottomLeading){
//            Image("WeeklyDistanceCardImage")
//                .resizable()
//                .scaledToFill()
//                .frame(width: 353, height: 300)
//                .overlay {
//                    Rectangle()
//                        .fill(
//                            Gradient(
//                                stops: [
//                                    .init(color: Color.clear, location: 0.8),
//                                    .init(color: Color.black.opacity(0.5), location: 1),
//                                ]
//                            )
//                        )
//                }
//                .cornerRadius(12)
//            
//            Image(systemName: "chevron.right")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 14)
//                .offset(x:320,y:-260)
//                .foregroundColor(Color.white)
//                .bold()
//            HStack{
//                Text("Semana")
//                    .font(.system(size: 34, weight: .bold))
//                    .foregroundColor(Color.white)
//            }.padding()        }
//    }
//}
//
//#Preview {
//    WeeklyCounterCardView()
//}
