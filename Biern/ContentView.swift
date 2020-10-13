import SwiftUI

struct ContentView: View {
    @StateObject var userData = User()
    @StateObject var data = DataProvider()

    var body: some View {
        NavigationView {
            LoginView(userData: self.userData, data: self.data)
        }
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
                .environment(\.colorScheme, .light)
                .previewDisplayName("iPhone XS Max")
        }
    }
}
