import SwiftUI

// difficulty buttons in setings screen
struct DifficultyButtons: View {
    // Observed object recieved from parent
    @ObservedObject var settings: Settings
    @Binding var selected: Int
    @Binding var show: Bool
    var body: some View {
        ForEach((1...3), id: \.self) { index in
            Button(action: {
                self.selected = index
            }, label: {
                if self.selected == index {
                    Image(String(index))
                        .padding()
                        .scaleEffect(1.3)
                } else {
                    Image(String(index))
                        .padding()
                        .mask(Color.white.opacity(0.3))
                }
            })
        }
    }
}
