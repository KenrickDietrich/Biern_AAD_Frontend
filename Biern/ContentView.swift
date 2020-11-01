import SwiftUI

struct ContentView: View {
    // initialize global data provider
    @StateObject var data = DataProvider()

    // on appear fetch auth token
    // navigate to first view login
    var body: some View {
        NavigationView {
            LoginView(data: self.data)
        }.onAppear { self.data.login() }
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
