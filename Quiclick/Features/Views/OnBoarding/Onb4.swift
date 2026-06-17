//
//  Onb4.swift
//  a-via
//
//  Created by Soraia Freire Batista on 16/06/26.
//

import SwiftUI

struct Onb4View: View {
    @Binding var isOnboarding: Bool
    var body: some View {
        VStack(alignment:.center,spacing: 50){

            Text("Para ter a experiência completa, conect-se ao Apple Health!")
                .font(Font.system(.largeTitle, design: .rounded).bold())
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .dynamicTypeSize(.large)
            
            Image("Onb4Image")
                .resizable()
                .scaledToFit()
                .frame(maxHeight:131)
            
            Text("De lá que trazemos seus treinos para você editar e personalizar!")
                .font(Font.system(.title3, design: .rounded).bold())
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .dynamicTypeSize(.large)
            
            Button{
                isOnboarding = false
            }label:{
                Text("Conceder Permissão")
            }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)
                .padding(10)
                .tint(.white)
                .foregroundStyle(Color.black)
        }
        .padding()
    }
}

