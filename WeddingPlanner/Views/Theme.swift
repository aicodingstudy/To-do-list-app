import SwiftUI

extension Color {
    static let bobaGreen = Color(red: 98/255, green: 165/255, blue: 84/255)
    static let bobaBackground = Color(red: 30/255, green: 30/255, blue: 30/255)
}

struct ThemedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(Color.bobaGreen.opacity(configuration.isPressed ? 0.6 : 1))
            .cornerRadius(8)
            .foregroundStyle(.black)
    }
}
