import Foundation

// party class with id, party code,
// host id, list of users, is active status,
// list of selected games, settings,
// list of results
class Party: ObservableObject {
    @Published var partyId = ""
    @Published var partyCode: String = ""
    @Published var hostId: String = ""
    @Published var users: [User] = []
    @Published var isActive: Bool = false
    @Published var selectedGames: [Game] = []
    @Published var settings: Settings = Settings()
    @Published var results: String = ""

    // when a party is created, create a random string
    // with the length of 6 characters
    init() {
        self.partyCode = randomString(length: 6)
    }

    func randomString(length: Int) -> String {
      let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map { _ in letters.randomElement()! })
    }

}
