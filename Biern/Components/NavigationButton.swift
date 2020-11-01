import SwiftUI

// reusable button to keep styling consistant
struct NavigationButton<Content>: View where Content: View {
    private let content: () -> Content

    var body: some View {
        content()
            .padding(10.0)
            .background(Color("Orange"))
            .foregroundColor(Color("White"))
            .cornerRadius(10)
    }

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
}
