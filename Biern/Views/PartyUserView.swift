import SwiftUI

struct PartyUserView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @ObservedObject var data: DataProvider
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationItemContainer {
            ZStack {
                BackgroundCardComponent()
                VStack {
                    HStack {
                        VStack {
                            Text("Username:")
                                .fontWeight(.bold)
                                .padding(2)
                            Text("Current Room:")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }.padding()
                        VStack {
                            Text("Pietje")
                                .padding(2)
                            Text("X56J1P12")
                        }.padding()
                    }.padding(.top, 50.0)
                    if !self.data.parties.isEmpty {
                        PartyPeopleList(party: self.data.parties[0])
                    }
                    HStack {
                        NavigationButton {
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Text("Exit")
                                    .fontWeight(.medium)
                            })
                        }
                        Spacer()
                        NavigationButton {
                            NavigationLink(destination: PartyUserView(data: self.data)) {
                                Text("Not Ready")
                                    .fontWeight(.medium)
                            }
                        }
                    }.frame(width: screenWidth * 0.5, height: screenHeight * 0.2)
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
