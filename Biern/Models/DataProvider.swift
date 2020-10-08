import Foundation

class DataProvider: ObservableObject {
    @Published var parties = [PartyData]()
    
    func fetchParties() {
       // fetch all parties
    }
}

