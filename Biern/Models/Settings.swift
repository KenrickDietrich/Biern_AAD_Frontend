import Foundation

class Settings: ObservableObject {
    @Published var settingsId = UUID()
    @Published var difficulty: Int = 1
    @Published var settings: [Setting] = [ Setting(title: "Drinking game",
                                                   description:
                                                     "Determines whether the game you play is a drinking game",
                                                   isActive: true),
                                           Setting(title: "Show Names",
                                                  description:
                                                    "Determines whether the usernames get shown during the gmae",
                                                  isActive: false),
                                           Setting(title: "Beer",
                                                   description:
                                                     "Determines whether the game should include beer as punishment",
                                                   isActive: true),
                                           Setting(title: "Wine",
                                                   description:
                                                     "Determines whether the game should include wine as punishment",
                                                   isActive: false)
                                         ]

}
