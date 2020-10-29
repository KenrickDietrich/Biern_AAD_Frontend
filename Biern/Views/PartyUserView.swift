import SwiftUI

struct PartyUserView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @ObservedObject var data: DataProvider
    @ObservedObject var userData: User
    @Environment(\.presentationMode) var presentationMode
    @State var isReady = false
    var body: some View {
        NavigationItemContainer {
            ZStack {
                BackgroundCardComponent()
                VStack {
                    HStack {
                        VStack {
                            Text("Username:")
                                .fontWeight(.bold)
                                .padding()
                            Text("Current Room:")
                                .fontWeight(.bold)
                        }.padding()
                        VStack {
                            Text("\(self.userData.username)")
                                .padding()
                            Text("X56J1P12")
                        }.padding()
                    }
                    if !self.data.parties.isEmpty {
                        PartyPeopleList(party: self.data.parties[0])
                            .padding()
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
                        if isReady {
                            NavigationButton {
                                Button(action: {
                                    self.isReady.toggle()
                                    self.userData.isReady.toggle()
                                }, label: {
                                    Text("Ready")
                                        .fontWeight(.medium)
                                        .animation(.spring())
                                })
                            }
                        } else {
                            NavigationButton {
                                Button(action: {
                                    self.isReady.toggle()
                                    self.userData.isReady.toggle()
                                }, label: {
                                    Text("Not Ready")
                                        .fontWeight(.medium)
                                        .animation(.spring())
                                })
                            }
                        }
                    }.frame(width: screenWidth * 0.5, height: screenHeight * 0.2)
                }.offset(y: screenHeight * 0.05)
            }.edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                self.data.fetchParties()
            })
        }
    }
}

struct PartyUserView_Previews: PreviewProvider {
    static var previews: some View {
        PartyUserView(data: DataProvider(), userData: User())
    }
}
