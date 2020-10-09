import SwiftUI

struct PartyPeopleList: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @ObservedObject var party: PartyData
    var body: some View {
        VStack {
            Text("Joined people")
            ScrollView {
                ForEach(self.party.users, id: \.self) { user in
                    Text(user)
                        .padding(2)

                }.padding()
            }.frame(width: screenWidth * 0.5, height: screenHeight * 0.2, alignment: .center)
            .background(Color("Grey"))
            .cornerRadius(10)
        }
    }
}

struct PartyPeopleList_Previews: PreviewProvider {
    static var previews: some View {
        PartyPeopleList(party: PartyData(partyCode: "joe joe", users: ["Jan", "Willem", "Bram", "Piet"]))
    }
}
