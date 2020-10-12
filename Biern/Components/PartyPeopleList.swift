import SwiftUI

struct PartyPeopleList: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @ObservedObject var party: Party
    var body: some View {
        VStack {
            Text("Joined people")
                .fontWeight(.bold)
            ScrollView {
                ForEach(self.party.users, id: \.self) { user in
                    Text(user)
                        .padding(1)
                }.padding()
            }.frame(width: screenWidth * 0.5, height: screenHeight * 0.18, alignment: .center)
            .background(Color("Grey"))
            .cornerRadius(10)
        }
    }
}

struct PartyPeopleList_Previews: PreviewProvider {
    static var previews: some View {
        PartyPeopleList(party: Party(partyCode: "joe joe",
                                     users: ["Jan", "Willem", "Bram", "Piet"],
                                     settings: Setting(difficulty: 3)))
    }
}
