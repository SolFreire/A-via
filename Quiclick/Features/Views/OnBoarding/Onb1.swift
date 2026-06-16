//
//  Onb1.swift
//  a-via
//
//  Created by Soraia Freire Batista on 16/06/26.
//

import SwiftUI

struct Onb1View: View {
    var body: some View {
        VStack(alignment:.center,spacing: 80){

            Image("Onb1Image")
                .resizable()
                .scaledToFit()
                .offset(x:0, y:30)
        }
        .overlay{
                Text("Adicione uma foto a sua corrida salva no Apple Health")
                    .font(Font.system(.largeTitle, design: .rounded).bold())
                    .multilineTextAlignment(.center)
                    .offset(x: 0, y: -200)
                    .foregroundColor(.white)
                    .dynamicTypeSize(.large)
        }
        .padding()
    }
}

#Preview {
    Onb1View()
}
