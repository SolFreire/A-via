////
////  HealthDeniedView.swift
////  Quiclick
////
////  Created by Soraia Freire Batista on 07/05/26.
////
//
//import SwiftUI
//
//struct HealthDeniedView: View {
//    var body: some View {
//            Spacer()
//            VStack(spacing: 24) {
//                Text("Acha que isso é um Erro?")
//                    .font(.largeTitle)
//                    .multilineTextAlignment(.center)
//            Spacer()
//
//             Image(systemName: "heart.text.square.fill")
//                 .font(.system(size: 72))
//                 .foregroundColor(.gray)
//
//            Text("Acesso ao Apple Health negado")
//                .font(.headline)
//                .multilineTextAlignment(.center)
//
//            Text("Para ver suas corridas, permita o compartilhamento de Exercícios com o Quiclick na aba de compartilhamentos do Apple Health.")
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//                .multilineTextAlignment(.center)
//                .padding(.horizontal, 32)
//
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
//
//            Spacer()
//        }
//        .frame(maxWidth: .infinity)
//    }
//}
//
//#Preview {
//    HealthDeniedView()
//}

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
