import SwiftUI

struct WaitingHostScreen: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    var body: some View {
            ZStack {
                BackgroundCardComponent()

                VStack {
                    Text("joeee")
                }
            }.edgesIgnoringSafeArea(.all)
    }
}

//struct WaitingHostScreen_Preview: PreviewProvider {
//    static var previews: some View {
//        JoinPartyView()
//    }
//}
