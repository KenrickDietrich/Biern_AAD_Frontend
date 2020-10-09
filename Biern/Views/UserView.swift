import SwiftUI

struct UserView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @ObservedObject var userData: UserData
    @ObservedObject var data: DataProvider

    var body: some View {
        NavigationItemContainer {
            ZStack {
                BackgroundCardComponent()
                VStack(spacing: 30) {
                    HStack {
                        Text("Hallo, " + "\(self.userData.username)")
                            .font(.title)
                    }
                    .padding(5.0)
                    .frame(width: screenWidth * 0.6)
                    HStack {
                        NavigationButton {
                            NavigationLink(destination: PartyHostView(data: self.data)) {
                                Text("Create game")
                                    .fontWeight(.medium)
                            }
                        }
                        NavigationButton {
                            NavigationLink(destination: JoinPartyView(data: self.data)) {
                                Text("Join game")
                                    .fontWeight(.medium)
                            }
                        }

                    }
                    Text("Choose if you want to join a game or create one.")
                        .font(.footnote)
                        .padding(.horizontal, 80.0)
                }.foregroundColor(Color("Black"))
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(userData: UserData(), data: DataProvider())
    }
}
