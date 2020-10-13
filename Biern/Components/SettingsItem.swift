import SwiftUI

struct SettingsItem: View {
    @ObservedObject var setting: Setting
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(self.setting.title)
                    .fontWeight(.bold)
                Text(self.setting.description)
                    .font(/*@START_MENU_TOKEN@*/.callout/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            if self.setting.isActive == true {
                Button(action: {
                        self.setting.isActive.toggle()
                }, label: {
                    Image("toggle-active").animation(.spring())
                })
            } else {
                Button(action: {
                        self.setting.isActive.toggle()
                }, label: {
                    Image("toggle").animation(.spring())
                })

            }
        }
    }
}

struct SettingsItem_Previews: PreviewProvider {
    static var previews: some View {
        SettingsItem(setting: Setting(title: "Drinking game",
                                      description:
                                        "Determines whether the game you play is a drinking game",
                                      isActive: true))
    }
}
