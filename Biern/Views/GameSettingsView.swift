import SwiftUI

struct GameSettingsView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @ObservedObject var party: Party
    var body: some View {
        NavigationItemContainer {
            ZStack {
                BackgroundCardComponent()
                VStack {
                    Text("Party code:")
                        .fontWeight(.bold)
                        .padding(2)
                    if(self.party.settings.difficulty === 3){
                        Text("It is 3")
                    }
                }
            }
        }
    }
}

struct GameSettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameSettingsView(party: Party(partyCode: "party code", users: ["Jan", "Willem", "Bram", "Piet"],
                                        settings: Setting(difficulty: 3)))
    }
}
