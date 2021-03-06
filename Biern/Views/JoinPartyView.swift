import SwiftUI

struct JoinPartyView: View {
    // get screen size
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    // global data provider recieved from parent
    @ObservedObject var data: DataProvider
    // local variables
    @State var input = ""
    @State var isActive = false
    @State var showAlert = false
    var body: some View {
        NavigationItemContainer {
            ZStack {
                BackgroundCardComponent()
                VStack(spacing: 30) {
                    VStack {
                        Text("Party code:")
                        TextField("", text: self.$input)
                            .padding(5.0)
                            .background(Color("Grey"))
                            .cornerRadius(12)
                            .frame(width: screenWidth * 0.6)
                    }
                    // navigate to party user view
                    NavigationLink(destination: PartyUserView(data: self.data),
                                   isActive: $isActive) {
                        NavigationButton {
                            Button(action: {
                                // check if input is not empty
                                // continue to next view
                                if self.input.count != 0 {
                                    self.isActive = true
                                }
                                // if not show alert
                                else {
                                    self.showAlert = true
                                }
                            }, label: {
                                Text("Join game")
                                    .fontWeight(.medium)
                            })
                        }
                    }
                    Text("""
                        Enter the party code that you want to join.
                        Note: The party codes are case sensitive.
                        """)
                        .font(.footnote)
                        .padding(.horizontal, 50.0)

                }.foregroundColor(Color("Black"))
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Try again"), message: Text("Please enter a party code and try again!"))
                })
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct JoinPartyView_Previews: PreviewProvider {
    static var previews: some View {
        JoinPartyView(data: DataProvider())
    }
}
