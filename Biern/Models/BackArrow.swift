import SwiftUI

class BackArrow: ObservedObject {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @Published var body : some View {
        Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
            HStack {
            Image("arrow-right")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                Text("Go back")
            }
        }
    }
}
