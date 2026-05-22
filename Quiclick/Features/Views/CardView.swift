//
//  CardView.swift
//  Quiclick
//
//  Created by Luiz Henrique da Silva Bezerra on 20/05/26.
//

import SwiftUI

enum ViewType : String, CaseIterable, Identifiable{
    case distanceregular, distance5km, distance10km, distance15km, distance21km, distance42km
    case bestpace
    case timeregular,time2hours
    case weeklydistance
    
    var id: String { self.rawValue }
    
    var image : String {
        switch self{
        case .distanceregular: return "EmptyDistanceCardView"
        case .distance5km: return "Distance5kmImage"
        case .distance10km: return "Distance10kmImage"
        case .distance15km: return "Distance15kmImage"
        case .distance21km: return "Distance21kmImage"
        case .distance42km: return "Distance42kmImage"
        case .bestpace: return "BestPaceImage"
        case .timeregular: return "TimeRegularImage"
        case .time2hours: return "Time2HoursImage"
        case .weeklydistance: return "WeeklyDistanceCardImage"
        }
    }
}

struct CardView: View{
    
    var viewtype: ViewType
    
    var body: some View{
        switch viewtype {
            
        case .distanceregular:
            ZStack(alignment: .bottomLeading){
                
                Image("EmptyDistanceCardView")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 173, height: 160)
                    .overlay {
                        Rectangle()
                            .fill(
                                Gradient(
                                    stops: [
                                        .init(color: Color.clear, location: 0.5),
                                        .init(color: Color.black.opacity(0.5), location: 1),
                                    ]
                                )
                            )
                    }
                    .blur(radius: 2)
                    .border(Color.gray, width: 0.5)
                    .cornerRadius(12)

                
                HStack{
                    Text("Distância")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color.white)
                }
                .padding(10)
                Image(systemName: "lock.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundColor(Color.white)
                    .bold()
                    .offset(x: 68, y : -68)
                
            }
        case .distance5km:
            ZStack(alignment: .bottomLeading){
                Image("Distance5kmImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 173, height: 160)
                    .clipped()
                    .overlay {
                        Rectangle()
                            .fill(
                                Gradient(
                                    stops: [
                                        .init(color: Color.clear, location: 0.5),
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
                    .offset(x:144,y:-120)
                    .foregroundColor(Color.white)
                    .bold()
                HStack{
                    Text("Distância")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color.white)
                }
                .padding(10)
                
                
            }
        case .distance10km:
            ZStack(alignment: .bottomLeading){
                Image("Distance10kmImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 173, height: 160)
                    .overlay {
                        Rectangle()
                            .fill(
                                Gradient(
                                    stops: [
                                        .init(color: Color.clear, location: 0.5),
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
                    .offset(x:144,y:-120)
                    .foregroundColor(Color.white)
                    .bold()
                HStack{
                    Text("Distância")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color.white)
                }
                .padding(10)
                
                
            }
        case .distance15km:
            ZStack(alignment: .bottomLeading){
                Image("Distance15kmImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 173, height: 160)
                    .overlay {
                        Rectangle()
                            .fill(
                                Gradient(
                                    stops: [
                                        .init(color: Color.clear, location: 0.5),
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
                    .offset(x:144,y:-120)
                    .foregroundColor(Color.white)
                    .bold()
                HStack{
                    Text("Distância")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color.white)
                }
                .padding(10)
                
            }
        case .distance21km:
            ZStack(alignment: .bottomLeading){
                Image("Distance21kmImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 173, height: 160)
                    .overlay {
                        Rectangle()
                            .fill(
                                Gradient(
                                    stops: [
                                        .init(color: Color.clear, location: 0.5),
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
                    .offset(x:144,y:-120)
                    .foregroundColor(Color.white)
                    .bold()
                HStack{
                    Text("Distância")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color.white)
                }
                .padding(10)
                
                
            }
        case .distance42km:
            ZStack(alignment: .bottomLeading){
                Image("Distance42kmImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 173, height: 160)
                    .overlay {
                        Rectangle()
                            .fill(
                                Gradient(
                                    stops: [
                                        .init(color: Color.clear, location: 0.5),
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
                    .offset(x:144,y:-120)
                    .foregroundColor(Color.white)
                    .bold()
                HStack{
                    Text("Distância")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color.white)
                }
                .padding(10)
                
                
            }
            
        case .bestpace:
            ZStack(alignment: .bottomLeading){
                Image("PaceCardImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 353, height: 160)
                    .overlay {
                        Rectangle()
                            .fill(
                                Gradient(
                                    stops: [
                                        .init(color: Color.clear, location: 0.5),
                                        .init(color: Color.black.opacity(0.5), location: 1),
                                    ]
                                )
                            )
                    }
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14)
                    .offset(x:320,y:-120)
                    .foregroundColor(Color.white)
                    .bold()
                HStack{
                    Text("Pace")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color.white)
                }
                .padding()
            }
        
        case .timeregular:
            ZStack(alignment:.bottomLeading){
                Image("TimeRegularImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 173, height: 160)
                    .overlay {
                        Rectangle()
                            .fill(
                                Gradient(
                                    stops: [
                                        .init(color: Color.clear, location: 0.5),
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
                    .offset(x:144,y:-120)
                    .foregroundColor(Color.white)
                    .bold()
                HStack{
                    Text("Tempo")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color.white)
                }
                .padding(10)
            }
        case .time2hours:
            ZStack(alignment: .bottomLeading){
                Image("TimeCardImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 173, height: 160)
                    .overlay {
                        Rectangle()
                            .fill(
                                Gradient(
                                    stops: [
                                        .init(color: Color.clear, location: 0.5),
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
                    .offset(x:144,y:-120)
                    .foregroundColor(Color.white)
                    .bold()
                Text("2h")
                    .font(.title)
                    .fontWeight(.bold)
                    .offset(x:-46,y:0)
                    .foregroundColor(Color.white.opacity(0.9))
                        
                HStack{
                    Text("Tempo")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color.white)
                }
                .padding(10)
            }
            
        case .weeklydistance:
            ZStack(alignment: .bottomLeading){
                Image("WeeklyDistanceImage")
                    .resizable()
                    .scaledToFill()
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
                    .offset(x:320,y:-260)
                    .foregroundColor(Color.white)
                    .bold()
                HStack{
                    Text("Semana")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color.white)
                }
                .padding()
            }
        }
    }
}

#Preview {
    CardView(viewtype: .distance42km)
}
