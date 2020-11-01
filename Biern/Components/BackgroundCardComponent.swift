import SwiftUI

// background view for all views
struct BackgroundCardComponent: View {
    // get screen size
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    var body: some View {
        Color("Grey")
            .edgesIgnoringSafeArea(.all)
            .overlay(
                ZStack {
                    Image("background")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    ZStack {
                        Rectangle()
                            .fill(Color("White"))
                            .frame(width: screenWidth * 0.8, height: screenHeight * 0.75)
                            .cornerRadius(28)
                        ZStack {
                            Circle()
                                .fill(Color("White"))
                                .frame(width: screenWidth * 0.5,
                                       height: screenHeight * 0.5)
                            Image("crown")
                                .resizable()
                                .frame(width: screenWidth * 0.3, height: screenWidth * 0.3)
                        }.offset(y: -screenHeight * 0.35)
                    }.offset(y: screenHeight * 0.05)
                    Spacer()
                }
            )
    }
}

struct BackgroundCardComponent_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundCardComponent()
            .previewDevice("iPhone 11 Pro Max")
    }
}
