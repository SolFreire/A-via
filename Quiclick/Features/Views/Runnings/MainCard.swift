//
//  MainCard.swift
//  a-via
//
//  Created by Luiz Henrique da Silva Bezerra on 08/06/26.
//

import SwiftUI

struct MainCard: View {
    var body: some View {
        ViewThatFits {
            HStack(alignment: .bottom) {
                VStack (alignment: .leading) {
                    Text("Edição Rápida")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.limeButtons)
                    Text("Personalize seu último treino!")
                        .padding(.bottom, 8)
                    Text("Correu,\nregistrou,\ncompartilhou.") +
                    Text(" a-via.")
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.limeButtons)
                }
                
                Spacer()
                
                Rectangle()
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image("a-viaStickerGreen")
                            .resizable()
                    )
                    .foregroundStyle(Color.clear)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.carbonCards)
            .cornerRadius(12)
            .foregroundStyle(Color.white)
            
            
            HStack(alignment: .bottom) {
                VStack (alignment: .leading) {
                    Text("Edição Rápida")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.limeButtons)
                    Text("Personalize seu último treino!")
                        .padding(.bottom, 5)
                    Text("Correu,\nregistrou,\ncompartilhou.") +
                    Text(" a-via.")
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.limeButtons)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.carbonCards)
            .cornerRadius(12)
            .foregroundStyle(Color.white)
        }
        
    }
}

#Preview{
    MainCard()
}
