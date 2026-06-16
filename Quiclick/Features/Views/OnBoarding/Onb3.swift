//
//  Onb3.swift
//  a-via
//
//  Created by Soraia Freire Batista on 16/06/26.
//

import SwiftUI

struct Onb3View: View {
    var body: some View {
        VStack(alignment:.center,spacing: 40){

            Text("Confira os Templates conquistados a partir do seu recorde!")
                .font(Font.system(.largeTitle, design: .rounded).bold())
                .multilineTextAlignment(.center)
                .dynamicTypeSize(.large)
            HStack(spacing: 12){
                Image("Distance15kmImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 170, height: 280)
                    .cornerRadius(20)
                    .overlay{
                        LinearGradient(gradient: Gradient(colors:[.black.opacity(0.9),.black.opacity(0.1)]), startPoint: .leading, endPoint: .trailing)
                    }
                Image("Distance21kmImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 170, height: 350)
                    .cornerRadius(20)
                Image("Distance42kmImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 170, height: 280)
                    .cornerRadius(20)
                    .overlay{
                        LinearGradient(gradient: Gradient(colors:[.black.opacity(0.9),.black.opacity(0.1)]), startPoint: .trailing, endPoint: .leading)
                    }
            }

        }
        .padding()
    }
}

#Preview {
    Onb3View()
}
