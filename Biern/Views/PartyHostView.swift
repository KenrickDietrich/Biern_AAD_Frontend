import SwiftUI

struct PartyHostView: View {
    // get screen size
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    // global data provider recieved from parent
    @ObservedObject var data: DataProvider
    var body: some View {
        NavigationItemContainer {
            ZStack {
                BackgroundCardComponent()
                VStack {
                    HStack {
                        Text("Party code:")
                            .fontWeight(.bold)
                            .padding(2)
                        Text(self.data.party.partyCode)
                    }.padding()
                    HStack {
                        Image("question")
                            .padding(.horizontal)
                        Image("share")
                            .padding(.horizontal)
                    }
                    PartyPeopleList(party: self.data.party)
                        .padding()
                    HStack {
                        // navigate to select game view
                        NavigationLink(destination: ChooseGameView(data: self.data)) {
                            VStack {
                                Image("games")
                                Text("Games")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("Black"))
                            }.padding()
                        }
                        Spacer()
                        // navigate to settings view
                        NavigationLink(destination:
                                        GameSettingsView(settings: self.data.party.settings, data: self.data)
                        ) {
                            VStack {
                                Image("stopwatch")
                                Text("Game settings")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("Black"))
                            }
                        }
                    }.frame(width: screenWidth * 0.6, height: screenHeight * 0.1, alignment: .center)
                    // start game and navigate to waiting view
                    NavigationButton {
                        NavigationLink(destination: WaitingView(data: self.data)) {
                            Text("Start game")
                                .fontWeight(.medium)
                        }
                    }.padding()
                }.offset(y: screenHeight * 0.05)
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct PartyHostView_Previews: PreviewProvider {
    static var previews: some View {
        PartyHostView(data: DataProvider())
    }
}
