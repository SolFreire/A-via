//
//  Onb0View.swift
//  a-via
//
//  Created by Soraia Freire Batista on 16/06/26.
//

import SwiftUI

struct Onb0View: View {
    var body: some View {
        VStack(spacing: 80){
            VStack{
                Text("Bem - vindo")
                    .font(Font.system(.largeTitle, design: .rounded).bold())
                HStack{
                    Text("ao")
                        .font(Font.system(.largeTitle, design: .rounded).bold())
                    Text("a-via")
                        .foregroundStyle(Color.limeButtons).bold()
                        .font(Font.system(.largeTitle, design: .rounded))
                    Text("!")
                        .font(Font.system(.largeTitle, design: .rounded).bold())
                }

            }
            Image("a-viaStickerGreen")
                .resizable()
                .frame(width: 256, height: 248)
        }
    }
}

#Preview {
    Onb0View()
}
