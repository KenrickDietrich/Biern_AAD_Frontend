import SwiftUI

struct GameView: View {
    @State var color: Color
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @ObservedObject var data: DataProvider
    @State var isActive = false

    var body: some View {
        ZStack {
            VStack {
                Image("crown")
                    .resizable()
                    .frame(width: screenWidth * 0.3, height: screenWidth * 0.3)
                NavigationLink(destination: PartyHostView(data: self.data), isActive: $isActive) {
                    Button(action: {
                        self.isActive = true
                    }, label: {
                        Rectangle()
                            .fill(color)
                            .frame(width: screenWidth * 0.8,
                                   height: screenHeight * 0.5)
                            .cornerRadius(28)
                    })
                }

            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(color: Color("Green"), data: DataProvider())
    }
}
