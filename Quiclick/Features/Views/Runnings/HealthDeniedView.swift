////
////  HealthDeniedView.swift
////  Quiclick
////
////  Created by Soraia Freire Batista on 07/05/26.
////


import SwiftUI

struct HealthDeniedView: View {

    var body: some View {

        VStack(spacing: 28) {

            Spacer()

            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.12))
                    .frame(width: 120, height: 120)

                Image(systemName: "heart.text.square.fill")
                    .font(.system(size: 52))
                    .foregroundStyle(.gray)
            }

            VStack(spacing: 12) {

                Text("Acha que há algo de Errado?")
                    .font(.title2.bold())
                    .multilineTextAlignment(.center)
                
                Text("Você pode ter negado o acesso ao Health")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

                Text("""
                O a-via precisa de acesso aos seus treinos \
                para importar automaticamente suas corridas.
                
                Você pode liberar o acesso em:
                """)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

                Text("Saúde → Compartilhamento → a-via")
                .font(.footnote)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
                .padding(.top, 4)
                
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
    }
}
#Preview {
    HealthDeniedView()
}
