import SwiftUI

struct GameSettingsView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @ObservedObject var settings: Settings
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationItemContainer {
            ZStack {
                BackgroundCardComponent()
                VStack {
                    Text("Choose game settings")
                        .fontWeight(.bold)
                        .padding(2)
                        .padding(.top, 100.0)
                    ScrollView {
                        ForEach(self.settings.settings, id: \.settingId) { setting in
                            SettingsItem(setting: setting)
                        }
                    }.frame(width: screenWidth * 0.65, height: screenHeight * 0.5, alignment: .center)
                    .padding()
                    NavigationButton {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Save")
                                .fontWeight(.medium)
                        })
                    }
                }

            }
        }
    }
}

struct GameSettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameSettingsView(settings: Settings())
    }
}
