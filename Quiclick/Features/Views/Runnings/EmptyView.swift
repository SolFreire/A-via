//
//  EmptyView.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 07/05/26.
//

import SwiftUI

struct EmptyView: View {

    var body: some View {

        VStack(alignment: .center, spacing: 16) {

            Text("Nenhuma corrida aqui!")
                .font(.title3)
                .bold()

            Text("Você pode ter Negado acesso ao Health")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            Text("Você pode liberar o acesso em:")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            Text("Saúde -> Compartilhamento -> a-via")
                .font(.footnote)
                .bold()
                .multilineTextAlignment(.center)
            Button{
                healthRedirection()
            }label:{Image(systemName: "heart.text.square.fill");Text("Ir para o Saúde")}
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)
                .padding(10)
                .tint(.limeButtons)
                .foregroundStyle(Color.black)

        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
    func healthRedirection() {
        if let url = URL(string:"x-apple-health://"){
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

#Preview {
    EmptyView()
}
