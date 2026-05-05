//
//  BestDistance.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 05/05/26.
//

import SwiftUI

struct BestDistanceCardView: View{
    var body: some View{
        ZStack(){
            Image("DistanceCardImage")
                .resizable()
                .scaledToFit()
                .frame(width: 173, height: 160)
                .cornerRadius(12)

        }
    }
}

#Preview {
    BestDistanceCardView()
}
