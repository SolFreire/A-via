//
//  Onb2.swift
//  a-via
//
//  Created by Soraia Freire Batista on 16/06/26.
//

import SwiftUI

struct Onb2View: View {
    var body: some View {
        VStack(alignment:.center,spacing: 40){
            VStack(){
                Text("Edite a Foto!")
                    .font(Font.system(.largeTitle, design: .rounded).bold())
                    .multilineTextAlignment(.center)
                Text("Clique e adicione Stickers")
                    .font(Font.system(.title2, design: .rounded).bold())
                    .multilineTextAlignment(.center)
            }
            Image("Onb2Image")
                .resizable()
                .scaledToFit()
                .frame(maxHeight:526)

        }
        .padding()
    }
}

#Preview {
    Onb2View()
}
