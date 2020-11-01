import SwiftUI

struct GameSettingsView: View {
    // get screen size
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    // Observed object recieved from parent
    @ObservedObject var settings: Settings
    @ObservedObject var data: DataProvider
    // presentation mode to dismiss wrapped value
    @Environment(\.presentationMode) var presentationMode
    // local variables
    @State var selected = 1
    @State var show = false

    var body: some View {
        NavigationItemContainer {
            ZStack {
                BackgroundCardComponent()
                VStack {
                    Text("Choose game settings")
                        .fontWeight(.bold)
                        .padding(2)
                        .padding(.top, 100.0)
                        .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text("Level")
                                .fontWeight(.bold)
                            Text("Determines the difficulty of the game")
                                .font(/*@START_MENU_TOKEN@*/.callout/*@END_MENU_TOKEN@*/)
                            HStack {
                                // show difficulty buttons in settings page
                                DifficultyButtons(settings: self.settings,
                                                  selected: self.$selected,
                                                  show: self.$show)
                            }
                        }
                        SettingsItem(settings: settings)
                    }.frame(width: screenWidth * 0.65, height: screenHeight * 0.5, alignment: .center)
                    .padding()
                    // navigate back and save settings
                    // send setsettings request to API
                    NavigationButton {
                        Button(action: {
                            self.data.party.settings.difficulty = self.selected
                            self.data.party.settings.showNames = self.show
                            self.data.setSettings()
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Save")
                                .fontWeight(.medium)
                        })
                    }
                }
            }.edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                self.selected = self.data.party.settings.difficulty
                self.show = self.data.party.settings.showNames
            })
        }
    }
}

struct GameSettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameSettingsView(settings: Settings(), data: DataProvider())
    }
}
