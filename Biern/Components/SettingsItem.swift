import SwiftUI

// single setting item with title, description and toggle button
struct SettingsItem: View {
    // Observed object recieved from parent
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
