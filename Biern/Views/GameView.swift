import SwiftUI

struct GameView: View {
    @State var color: Color

    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height

    var body: some View {
        ZStack {
            VStack {
                Image("crown")
                    .resizable()
                    .frame(width: screenWidth * 0.3, height: screenWidth * 0.3)
                Rectangle()
                    .fill(color)
                    .frame(width: screenWidth * 0.8,
                           height: screenHeight * 0.5)
                    .cornerRadius(28)
                    .onTapGesture {
                        color = Color("Green")
                    }
            }
            //hide the navigation bar, users can't go back on this page
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea([.top, .bottom])
        }
    }
}
