import Foundation

class PartyData: ObservableObject {
    @Published var partyId = UUID()
    @Published var partyCode: String = ""
    @Published var hostId: String = ""
    @Published var users: [String] = []
    @Published var isActive: Bool = false
    // Change when both settings and results model is made
    @Published var settings: String = ""
    @Published var results: String = ""

    init(partyCode: String, users: [String]) {
        self.partyCode = partyCode
        self.users = users
    }
}
