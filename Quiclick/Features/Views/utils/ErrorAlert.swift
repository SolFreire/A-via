//
//  ErrorAlert.swift
//  a-via
//

import SwiftUI

extension View {
    /// Mostra um alerta sempre que a ViewModel publica uma mensagem de erro,
    /// e limpa a mensagem ao fechar.
    func errorAlert(_ message: Binding<String?>) -> some View {
        alert(
            "Algo deu errado",
            isPresented: Binding(
                get: { message.wrappedValue != nil },
                set: { if !$0 { message.wrappedValue = nil } }
            )
        ) {
            Button("OK", role: .cancel) { message.wrappedValue = nil }
        } message: {
            Text(message.wrappedValue ?? "")
        }
    }
}
