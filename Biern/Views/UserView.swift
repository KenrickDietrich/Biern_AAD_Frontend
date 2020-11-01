import SwiftUI

struct UserView: View {
    // get screen size
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    // global data provider recieved from parent
    @ObservedObject var data: DataProvider
    // local variable
    @State var isActive = false
    var body: some View {
        NavigationItemContainer {
            ZStack {
                BackgroundCardComponent()
                VStack(spacing: 30) {
                    HStack {
                        Text("Hallo, " + "\(self.data.user.username)")
                            .font(.title)
                    }
                    .padding(5.0)
                    .frame(width: screenWidth * 0.6)
                    HStack {
                        // navigate to party host view
                        NavigationLink(destination: PartyHostView(data: self.data),
                                       isActive: $isActive) {
                            NavigationButton {
                                Button(action: {
                                    // call create party request
                                    self.data.createParty()
                                    self.isActive = true
                                }, label: {
                                    Text("Create game")
                                        .fontWeight(.medium)
                                        .accessibilityIdentifier("createGameTextId")
                                })
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
            .onAppear { self.data.fetchGames() }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(data: DataProvider())
    }
}
