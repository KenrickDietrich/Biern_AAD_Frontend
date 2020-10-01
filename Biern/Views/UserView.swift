import SwiftUI

struct UserView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @ObservedObject var userData: UserData

    var body: some View {
        NavigationView {
            ZStack {
                BackgroundCardComponent()
                VStack(spacing: 30) {
                    HStack {
                        Text("Hallo, " + "\(self.userData.username)")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                    .padding(5.0)
                    .frame(width: screenWidth * 0.6)
                    HStack {
                    //Change BackgroundCardComponent to next view
                    NavigationLink(destination: BackgroundCardComponent()) {
                        Text("Create game")
                    }
                    .padding(8.0)
                    .background(Color("Orange"))
                    .foregroundColor(Color("White"))
                    .cornerRadius(10)
                    //Change BackgroundCardComponent to next view
                    NavigationLink(destination: BackgroundCardComponent()) {
                        Text("Join game")

                    }
                    .padding(8.0)
                    .background(Color("Orange"))
                    .foregroundColor(Color("White"))
                    .cornerRadius(10)
                    }

                    Text("Choose if you want to join a game or create one.")
                        .font(.footnote)
                        .padding(.horizontal, 50.0)
                }.foregroundColor(Color("Black"))
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(userData: UserData())
    }
}
