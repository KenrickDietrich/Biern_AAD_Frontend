import SwiftUI

struct JoinPartyView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @ObservedObject var data: DataProvider
    @ObservedObject var userData: User
    @State var input = ""
    @State var isActive = false

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
                    NavigationLink(destination: PartyUserView(data: self.data, userData: self.userData),
                                   isActive: $isActive) {
                        NavigationButton {
                            Button(action: {
                                self.isActive = true
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
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct JoinPartyView_Previews: PreviewProvider {
    static var previews: some View {
        JoinPartyView(data: DataProvider(), userData: User())
    }
}
