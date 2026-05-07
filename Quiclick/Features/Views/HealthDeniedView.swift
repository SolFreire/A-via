//
//  HealthDeniedView.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 07/05/26.
//

import SwiftUI

struct HealthDeniedView: View {
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
             Image(systemName: "heart.text.square.fill")
                 .font(.system(size: 72))
                 .foregroundColor(.gray)

            Text("Acesso ao Apple Health negado")
                .font(.headline)
                .multilineTextAlignment(.center)

            Text("Para ver suas corridas, permita o compartilhamento de Exercícios com o Quiclick na aba de compartilhamentos do Apple Health.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

//            Button {
//                if let url = URL(string: UIApplication.openSettingsURLString) {
//                    UIApplication.shared.open(url)
//                }
//            } label: {
//                Label("Abrir Configurações", systemImage: "gear")
//                    .font(.subheadline)
//                    .fontWeight(.medium)
//                    .padding(.horizontal, 24)
//                    .padding(.vertical, 12)
//                    .background(Color.gray.opacity(0.12))
//                    .foregroundColor(.gray)
//                    .cornerRadius(12)
//            }

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    HealthDeniedView()
}
