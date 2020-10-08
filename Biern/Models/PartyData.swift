import Foundation

class PartyData: ObservableObject {
    @Published var partyId = UUID()
    @Published var partyCode: String = ""
    @Published var hostId: String = ""
    @Published var users: [UserData] = []
    @Published var isActive: Bool = false
    // Change when both settings and results model is made
    @Published var settings: String = ""
    @Published var results: String = ""

    init(partyCode: String) {
        self.partyCode = partyCode
    }

}
