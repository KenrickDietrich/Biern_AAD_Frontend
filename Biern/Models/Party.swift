import Foundation

class Party: ObservableObject {
    @Published var partyId = UUID()
    @Published var partyCode: String = ""
    @Published var hostId: String = ""
    @Published var users: [String] = []
    @Published var isActive: Bool = false
    // Change when both settings and results model is made
    @Published var settings: Setting
    @Published var results: String = ""

    init(partyCode: String, users: [String], settings: Setting) {
        self.partyCode = partyCode
        self.users = users
        self.settings = settings
    }
}
