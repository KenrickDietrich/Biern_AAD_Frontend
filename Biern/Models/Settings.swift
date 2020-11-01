import Foundation

class Settings: ObservableObject {
    @Published var settingsId: String = ""
    @Published var difficulty: Int = 1
    @Published var showNames: Bool = true

    init() {}

}
