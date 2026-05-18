//
//  EmptyView.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 07/05/26.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            Image(systemName: "figure.run.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72)
                .foregroundColor(.secondary.opacity(0.5))

            Text("Nenhuma corrida essa semana")
                .font(.headline)
                .foregroundColor(.primary)

            Text("Registre seu primeiro treino no Fitness para conseguir vê-lo aqui.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
}

#Preview {
    EmptyView()
}
