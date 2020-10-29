import Foundation

class Party: ObservableObject {
    @Published var partyId = UUID()
    @Published var partyCode: String = ""
    @Published var hostId: String = ""
    @Published var users: [String] = []
    @Published var isActive: Bool = false
    // Change when both settings and results model is made
    @Published var selectedGames: [Game] = []
    @Published var settings: Settings = Settings()
    @Published var results: String = ""

    init() {
        self.partyCode = randomString(length: 6)
    }

    func randomString(length: Int) -> String {
      let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map { _ in letters.randomElement()! })
    }

}
