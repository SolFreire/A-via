//
//  BestTimeCardView.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 05/05/26.
//

import SwiftUI

struct BestTimeCardView: View{

    enum ViewType {
        case regular, twohoursrunning
    }
    var viewtype: ViewType
    var bestTime: Double
    
    var body: some View{
        switch viewtype {
        case .twohoursrunning:
            ZStack(){
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
                    .offset(x:68,y:-56)
                    .foregroundColor(Color.white)
                    .bold()
                Text("2h")
                    .font(.title)
                    .fontWeight(.bold)
                    .offset(x:-46,y:0)
                    .foregroundColor(Color.white.opacity(0.9))
                        
                Text("Tempo")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .offset(x:-30,y:56)
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
       
                Text("Tempo")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .offset(x:-30,y:56)
                }

    }

    }
}

#Preview {
    BestTimeCardView(viewtype:.regular, bestTime: 0.0)
}
