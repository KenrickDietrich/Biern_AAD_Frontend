import SwiftUI

struct GameSettingsView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @ObservedObject var settings: Settings
    @Environment(\.presentationMode) var presentationMode
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
                                DifficultyButtons(settings: self.settings,
                                                  selected: self.$selected,
                                                  show: self.$show)
                            }
                        }
                        SettingsItem(settings: settings)
                    }.frame(width: screenWidth * 0.65, height: screenHeight * 0.5, alignment: .center)
                    .padding()
                    NavigationButton {
                        Button(action: {
                            self.settings.difficulty = self.selected
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Save")
                                .fontWeight(.medium)
                        })
                    }
                }
            }.edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                self.selected = self.settings.difficulty
            })
        }
    }
}

struct GameSettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameSettingsView(settings: Settings())
    }
}
