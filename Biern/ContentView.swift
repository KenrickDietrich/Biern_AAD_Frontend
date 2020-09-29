import SwiftUI

struct ContentView: View {
    @StateObject var userData = UserData()

    var body: some View {
        LoginView(userData: self.userData)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            Group {
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("iPhone SE")

            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
        }
    }
}
