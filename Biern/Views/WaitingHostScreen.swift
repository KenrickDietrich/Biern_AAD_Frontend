import SwiftUI

struct WaitingHostScreen: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    var body: some View {
            ZStack {
                BackgroundCardComponent()
                
                //create a VStack which contains the text and the button
                VStack {
                    Text("The party is waiting for the next game")
                    NavigationLink(destination: BackgroundCardComponent()) {
                        Text("Next game").fontWeight(.medium)
                    }
                    .padding(8.0)
                    .background(Color("Orange"))
                    .foregroundColor(Color("White"))
                    .cornerRadius(10)
                }
            }.edgesIgnoringSafeArea(.all)
    }
}
