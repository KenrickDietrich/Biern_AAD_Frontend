import SwiftUI

struct WaitingHostView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    var body: some View {
        ZStack {
            BackgroundCardComponent()
            VStack {
                Text("The party is waiting for the next game")
                NavigationButton {
                    NavigationLink(destination: BackgroundCardComponent()) {
                        Text("Next game").fontWeight(.medium)
                    }
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct WaitingHostView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingHostView()
    }
}
