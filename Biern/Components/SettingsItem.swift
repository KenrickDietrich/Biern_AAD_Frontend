import SwiftUI

struct SettingsItem: View {
    @ObservedObject var settings: Settings
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Show names")
                    .fontWeight(.bold)
                Text("Determines whether the usernames get shown during the game")
                    .font(/*@START_MENU_TOKEN@*/.callout/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            if self.settings.showNames == true {
                Button(action: {
                        self.settings.showNames.toggle()
                }, label: {
                    Image("toggle-active").animation(.spring())
                })
            } else {
                Button(action: {
                        self.settings.showNames.toggle()
                }, label: {
                    Image("toggle").animation(.spring())
                })

            }
        }
    }
}

struct SettingsItem_Previews: PreviewProvider {
    static var previews: some View {
        SettingsItem(settings: Settings())
    }
}
