//
//  BestDistance.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 05/05/26.
//

import SwiftUI

struct BestDistanceCardView: View{
    enum ViewType {
        case regular, fivekm
    }
    var viewtype: ViewType
    var bestDistance: Double
    var body: some View{
        switch viewtype {
        case .fivekm:
            ZStack(){
                Image("DistanceCardImage")
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
                    .offset(x:68,y:-56)
                    .foregroundColor(Color.white)
                    .bold()
                Text("Distância")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .offset(x:-12,y:56)
                
            
            }
        case .regular:
            ZStack(){
               
                Rectangle()
                    .fill(
                        Gradient(
                            stops: [
                                .init(color: Color.clear, location: 0.5),
                                .init(color: Color.black.opacity(0.5), location: 1),
                            ]
                        )
                    )
                    .frame(width: 173, height: 160)
                    .cornerRadius(12)
                    .foregroundColor(.gray)
        
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14)
                    .offset(x:68,y:-56)
                    .foregroundColor(Color.white)
                    .bold()
                Text("Distância")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .offset(x:-12,y:56)
                
                }

        }
        

    }
}

#Preview {
    BestDistanceCardView(viewtype: .fivekm, bestDistance: 5000)
}
