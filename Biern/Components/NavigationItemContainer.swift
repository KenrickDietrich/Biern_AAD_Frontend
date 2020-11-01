import SwiftUI

// custom back arrow for navigating back
struct NavigationItemContainer<Content>: View where Content: View {
    private let content: () -> Content
    // presentation mode to dismiss wrapped value
    @Environment(\.presentationMode) var presentationMode

    private var backArrow: some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss()}, label: {
                Image("arrow-right")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
        })
    }

    var body: some View {
        content()
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backArrow)
    }

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
}
