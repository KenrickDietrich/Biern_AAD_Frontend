import SwiftUI

struct NavigationItemContainer<Content>: View where Content: View {
    private let content: () -> Content
    @Environment(\.presentationMode) var presentationMode

    private var backArrow : some View { Button(action: { self.presentationMode.wrappedValue.dismiss()}) {
        Image("arrow-right")
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.black)
        }
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
