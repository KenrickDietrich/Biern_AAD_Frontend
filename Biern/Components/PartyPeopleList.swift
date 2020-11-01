import SwiftUI

// list for joined people in party
struct PartyPeopleList: View {
    // get screen size
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    // Observed object recieved from parent
    @ObservedObject var party: Party
    var body: some View {
        VStack {
            Text("Joined people")
                .fontWeight(.bold)
            ScrollView {
                // show if users is not empty
                if !self.party.users.isEmpty {
                    // loop through list and display each user
                    ForEach(self.party.users.indices, id: \.self) { index in
                        Text(self.party.users[index].username)
                        .padding(1)
                    }.padding()
                }
            }.frame(width: screenWidth * 0.5, height: screenHeight * 0.18, alignment: .center)
            .background(Color("Grey"))
            .cornerRadius(10)
        }
    }
}

struct PartyPeopleList_Previews: PreviewProvider {
    static var previews: some View {
        PartyPeopleList(party: Party())
    }
}
