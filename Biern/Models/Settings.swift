import Foundation

// settings class with id, difficulty and show names option
class Settings: ObservableObject {
    @Published var settingsId: String = ""
    @Published var difficulty: Int = 1
    @Published var showNames: Bool = false

    init() {}

}
