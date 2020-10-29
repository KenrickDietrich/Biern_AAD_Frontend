import Foundation

class Settings: ObservableObject {
    @Published var settingsId = UUID()
    @Published var difficulty: Int = 1
    @Published var settings: [Setting] = [
        Setting(title: "Show Names",
                description:
                    "Determines whether the usernames get shown during the game",
                isActive: false)
    ]

    init() {}

}
