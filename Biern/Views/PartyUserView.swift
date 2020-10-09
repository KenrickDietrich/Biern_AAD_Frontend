import SwiftUI

struct PartyUserView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @ObservedObject var data: DataProvider
    var body: some View {
        NavigationItemContainer {
            ZStack {
                BackgroundCardComponent()
                VStack {
                    HStack {
                        Text("Username:")
                        Text("Pietje")
                    }
                    HStack {
                        Text("Current Room:")
                        Text("X56J1P12")
                    }
                    if !self.data.parties.isEmpty {
                        PartyPeopleList(party: self.data.parties[0])
                    }
                    HStack {
                        NavigationButton {
                            NavigationLink(destination: PartyUserView(data: self.data)) {
                                Text("Exit")
                                    .fontWeight(.medium)
                            }
                        }
                        Spacer()
                        NavigationButton {
                            NavigationLink(destination: PartyUserView(data: self.data)) {
                                Text("Not Ready")
                                    .fontWeight(.medium)
                            }
                        }
                    }.frame(width: screenWidth * 0.5, height: screenHeight * 0.2, alignment: .center)
                }
            }.edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                self.data.fetchParties()
            })
        }
    }
}

struct PartyUserView_Previews: PreviewProvider {
    static var previews: some View {
        PartyUserView(data: DataProvider())
    }
}
