import SwiftUI

struct GameView: View {
    // get screen size
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    // global data provider recieved from parent
    @ObservedObject var data: DataProvider
    // local variables
    @State var isActive = false
    @State var color: Color

    var body: some View {
        ZStack {
            VStack {
                Image("crown")
                    .resizable()
                    .frame(width: screenWidth * 0.3, height: screenWidth * 0.3)
                // navigate to party host view
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
        GameView(data: DataProvider(), color: Color("Green"))
    }
}
